// SPDX-FileCopyrightText: 2011-2012 Tasos Varoudis
//
// SPDX-License-Identifier: GPL-3.0-or-later

// 2d polygons (and line sets too...)

#include "p2dpoly.h"

#include <cmath>
#include <vector>

//////////////////////////////////////////////////////////////////////////////////////

// gps2os: function to convert long-lat GPS coordinates to OS national grid

// n.b.: approximation only

// This algorithm is taken from:

// "A guide to coordinate systems in Great Britain"
// http://www.ordnancesurvey.co.uk/oswebsite/gps/information/coordinatesystemsinfo/guidecontents/index.html
// (v1.9 Mar 2008 D00659, Crown Copyright)
// Sourced: 21-Mar-08

// It's truly ick... and nuts... there must be an easier way...

// Outline:
// 1. take long-lat on ETRS89 ellipsoid and convert to 3d cartesian coordinates
// 2. shift 3d cartesian coordinates from ETRS89 ellipsoid to OSGB36 ellipsoid
// 3. convert 3d cartesian coordinates to long-lat on OSGB36 ellipsoid
// 4. project onto OSFB36 2d grid using a transverse Mercator projection

// According to OS, accurate to within about 5 metres

Point2f gps2os(const Point2f &pt) {
    // *first*, we have ETRS89 data...

    // Convert it to 3D Cartesian Coordinates
    double lambda = M_PI * pt.x / 180.0;
    double phi = M_PI * pt.y / 180.0;

    // GRS80 ellipsoid
    double a = 6378137.0000;
    double b = 6356752.3141;
    double eSq = (pafmath::sqr(a) - pafmath::sqr(b)) / pafmath::sqr(a);

    double nu = a / sqrt(1.0 - eSq * pafmath::sqr(sin(phi)));

    double x = nu * cos(phi) * cos(lambda);
    double y = nu * cos(phi) * sin(lambda);
    double z = (1 - eSq) * nu * sin(phi);

    // Now we have the ETRS89 location, convert it to a rough OSGB36 location:

    // rough conversion chart

    // t_x (m)     t_y (m)   t_z (m)    s (ppm)    r_x (sec)  r_y (sec)  r_z (sec)
    // -446.448    +125.157  -542.060   +20.4894   -0.1502    -0.2470    -0.8421 = (in radians: )

    // nb, seconds converted to radians:
    double rX = -0.7281901490265230623720509817416e-6;
    double rY = -1.1974897923405539041670878328241e-6;
    double rZ = -4.0826160086234026020206666559563e-6;

    x = -446.448 + (1.0 + 2.04894e-5) * x - rZ * y + rY * z;
    y = +125.157 + rZ * x + (1.0 + 2.04894e-5) * y - rX * z;
    z = -542.060 - rY * x + rX * y + (1.0 + 2.04894e-5) * z;

    double p = sqrt(pafmath::sqr(x) + pafmath::sqr(y));

    // now place it back in long lat on the OSGB36 ellipsoid:

    // Airy 1830 (OSGB36) ellipsoid
    a = 6377563.396;
    b = 6356256.910;
    eSq = (pafmath::sqr(a) - pafmath::sqr(b)) / pafmath::sqr(a);

    lambda = atan(y / x);
    phi = atan(z / (p * (1.0 - eSq)));
    double lastphi = phi;

    nu = a / sqrt(1.0 - eSq * pafmath::sqr(sin(phi)));
    do {
        phi = atan((z + eSq * nu * sin(phi)) / p);
    } while (fabs(lastphi - phi) > 1e-6);

    // now, it's on the ellipsoid, project it onto the OSGB36 grid:

    // E_0 easting of true origin                400 000m
    double e0 = 400000;
    // N_0 northing of true origin              -100 000m
    double n0 = -100000;
    // F_0 scaling factor on central meridian    0.9996012717
    double f0 = 0.9996012717;
    // lambda_0 longitude of true origin         -2.0 radians: -0.034906585039886591538473815369772
    double lambda0 = -0.034906585039886591538473815369772;
    // phi_0 latitude of true origin             49.0 radians:
    double phi0 = 0.85521133347722149269260847655942;

    nu = a * f0 * pow((1 - eSq * pafmath::sqr(sin(phi))), -0.5);

    double n = (a - b) / (a + b);
    double rho = a * f0 * (1.0 - eSq) * pow((1 - eSq * pafmath::sqr(sin(phi))), -1.5);
    double etaSq = nu / rho - 1;

    double nSq = pow(n, 2);
    double nCubed = pow(n, 3);
    double m =
        b * f0 *
        ((1.0 + n + 0.25 * 5 * (nSq + nCubed)) * (phi - phi0) -
         (3.0 * (n + nSq + 0.125 * 7 * nCubed)) * sin(phi - phi0) * cos(phi + phi0) +
         (0.125 * 15.0 * (nSq + nCubed)) * sin(2.0 * (phi - phi0)) * cos(2.0 * (phi + phi0)) -
         (35.0 / 24.0 * nCubed) * sin(3.0 * (phi - phi0)) * cos(3.0 * (phi + phi0)));
    double i = m + n0;
    double ii = 0.5 * nu * sin(phi) * cos(phi);
    double tanphi = tan(phi);
    double iii =
        nu * sin(phi) * pow(cos(phi), 3.0) * (5.0 - pafmath::sqr(tanphi) + 9.0 * etaSq) / 24.0;
    double iiia = nu * sin(phi) * pow(cos(phi), 5.0) *
                  (61.0 - 58.0 * pafmath::sqr(tanphi) + pow(tanphi, 4.0)) / 720.0;
    double iv = nu * cos(phi);
    double v = nu * pow(cos(phi), 3.0) * (nu / rho - pafmath::sqr(tanphi)) / 6.0;
    double vi = nu * pow(cos(phi), 5.0) *
                (5.0 - 18.0 * pafmath::sqr(tanphi) + pow(tanphi, 4) + 14.0 * etaSq -
                 58.0 * pafmath::sqr(tanphi) * etaSq) /
                120.0;

    double e = e0 + iv * (lambda - lambda0) + v * pow((lambda - lambda0), 3) +
               vi * pow((lambda - lambda0), 5);
    double nn = i + ii * pow((lambda - lambda0), 2) + iii * pow((lambda - lambda0), 4) +
                iiia * pow((lambda - lambda0), 6);

    return Point2f(e, nn);
}

//////////////////////////////////////////////////////////////////////////////////////

static long g_count = 0L;

int bitcount(int a) {
    int ret = 0;
    while (a != 0) {
        ret += (a & 1) ? 1 : 0;
        a = a >> 1;
    }
    return ret;
}

////////////////////////////////////////////////////////////////////////////////////////

// EdgeU is used for polygon clipping to viewports

// are a,b,c in ccw order (true) or cw order (false)
bool ccwEdgeU(const EdgeU &a, const EdgeU &b, const EdgeU &c) {
    bool ccw = false;
    if (c.edge > a.edge || (c.edge == a.edge && c.u > a.u)) {
        if (b.edge > a.edge || (b.edge == a.edge && b.u > a.u)) {
            if (b.edge < c.edge || (b.edge == c.edge && b.u < c.u)) {
                ccw = true;
            }
        }
    } else {
        if (b.edge > a.edge || (b.edge == a.edge && b.u > a.u)) {
            ccw = true;
        } else if (b.edge < c.edge || (b.edge == c.edge && b.u < c.u)) {
            ccw = true;
        }
    }
    return ccw;
}

// EdgeU is used for polygon clipping to viewports
// get the actual point from an EdgeU
Point2f QtRegion::getEdgeUPoint(const EdgeU &eu) {
    switch (eu.edge) {
    case 0:
        return Point2f(bottomLeft.x + (eu.u * width()), bottomLeft.y);
    case 1:
        return Point2f(topRight.x, bottomLeft.y + (eu.u * height()));
    case 2:
        return Point2f(topRight.x - (eu.u * width()), topRight.y);
    case 3:
        return Point2f(bottomLeft.x, topRight.y - (eu.u * height()));
    }
    return Point2f();
}

// EdgeU is used for polygon clipping to viewports
// get where the polygon exits the viewport
EdgeU QtRegion::getCutEdgeU(const Point2f &inside, const Point2f &outside) {
    EdgeU eu;
    if (outside.x < bottomLeft.x) {
        double y = outside.y +
                   (inside.y - outside.y) * (bottomLeft.x - outside.x) / (inside.x - outside.x);
        if (y >= bottomLeft.y && y <= topRight.y) {
            eu.edge = 3;
            eu.u = (topRight.y - y) / height();
        }
    }
    if (eu.edge == -1 && outside.x > topRight.x) {
        double y =
            inside.y + (outside.y - inside.y) * (topRight.x - inside.x) / (outside.x - inside.x);
        if (y >= bottomLeft.y && y <= topRight.y) {
            eu.edge = 1;
            eu.u = (y - bottomLeft.y) / height();
        }
    }
    if (eu.edge == -1 && outside.y < bottomLeft.y) {
        double x = outside.x +
                   (inside.x - outside.x) * (bottomLeft.y - outside.y) / (inside.y - outside.y);
        if (x >= bottomLeft.x && x <= topRight.x) {
            eu.edge = 0;
            eu.u = (x - bottomLeft.x) / width();
        }
    }
    if (eu.edge == -1 && outside.y > topRight.y) {
        double x =
            inside.x + (outside.x - inside.x) * (topRight.y - inside.y) / (outside.y - inside.y);
        if (x >= bottomLeft.x && x <= topRight.x) {
            eu.edge = 2;
            eu.u = (topRight.x - x) / width();
        }
    }
    // if at this stage eu.edge is still -1 there's a problem!
    return eu;
}

//////////////////////////////////////////////////////////////////////////

// union of two regions

QtRegion runion(const QtRegion &a, const QtRegion &b) {
    QtRegion n;
    n.bottomLeft.x = a.bottomLeft.x < b.bottomLeft.x ? a.bottomLeft.x : b.bottomLeft.x;
    n.bottomLeft.y = a.bottomLeft.y < b.bottomLeft.y ? a.bottomLeft.y : b.bottomLeft.y;
    n.topRight.x = a.topRight.x > b.topRight.x ? a.topRight.x : b.topRight.x;
    n.topRight.y = a.topRight.y > b.topRight.y ? a.topRight.y : b.topRight.y;
    return n;
}

// test intersecting regions, touching counts

bool intersect_region(const QtRegion &a, const QtRegion &b, double tolerance) {
    if (overlap_x(a, b, tolerance) && overlap_y(a, b, tolerance)) {
        return true;
    } else {
        return false;
    }
}

bool overlap_x(const QtRegion &a, const QtRegion &b, double tolerance) {
    if (a.bottomLeft.x > b.bottomLeft.x) {
        if (b.topRight.x >= a.bottomLeft.x - tolerance) {
            return true;
        }
    } else {
        if (a.topRight.x >= b.bottomLeft.x - tolerance) {
            return true;
        }
    }
    return false;
}

bool overlap_y(const QtRegion &a, const QtRegion &b, double tolerance) {
    if (a.bottomLeft.y > b.bottomLeft.y) {
        if (b.topRight.y >= a.bottomLeft.y - tolerance) {
            return true;
        }
    } else {
        if (a.topRight.y >= b.bottomLeft.y - tolerance) {
            return true;
        }
    }
    return false;
}

// line set up

// default: nothing:

Line::Line() {
    m_bits.parity = 0;
    m_bits.direction = 0;
    // Points automatically assigned to 0,0
}

Line::Line(const Point2f &a, const Point2f &b) {
    if (a.x == b.x) {
        bottomLeft.x = a.x;
        topRight.x = b.x;
        // vertical lines stored consistently as parity 1
        if (a.y <= b.y) {
            bottomLeft.y = a.y;
            topRight.y = b.y;
            m_bits.parity = 1;
            m_bits.direction = 1;
        } else {
            bottomLeft.y = b.y;
            topRight.y = a.y;
            m_bits.parity = 1;
            m_bits.direction = 0;
        }
    } else if (a.x < b.x) {
        bottomLeft.x = a.x;
        topRight.x = b.x;
        if (a.y <= b.y) {
            bottomLeft.y = a.y;
            topRight.y = b.y;
            m_bits.parity = 1;
            m_bits.direction = 1;
        } else {
            bottomLeft.y = b.y;
            topRight.y = a.y;
            m_bits.parity = 0; // -1
            m_bits.direction = 1;
        }
    } else {
        bottomLeft.x = b.x;
        topRight.x = a.x;
        if (b.y <= a.y) {
            bottomLeft.y = b.y;
            topRight.y = a.y;
            m_bits.parity = 1;
            m_bits.direction = 0;
        } else {
            bottomLeft.y = a.y;
            topRight.y = b.y;
            m_bits.parity = 0; // -1
            m_bits.direction = 0;
        }
    }
}

//////////////////////////////////////////////////////////////////////////////

double dot(const Line &a, const Line &b) {
    return (a.bx() - a.ax()) * (b.bx() - b.ax()) + (a.by() - a.ay()) * (b.by() - b.ay());
}

// intersection test: touching counts as an intersection
// (uses dot product comparison)

// NB You must MUST check that line *regions do not intersect* before using this test
// By this test, *all parallel lines intersect*

bool intersect_line(const Line &a, const Line &b, double tolerance) {
    g_count++;

    if (((a.ay() - a.by()) * (b.ax() - a.ax()) + (a.bx() - a.ax()) * (b.ay() - a.ay())) *
                ((a.ay() - a.by()) * (b.bx() - a.ax()) + (a.bx() - a.ax()) * (b.by() - a.ay())) <=
            tolerance &&
        ((b.ay() - b.by()) * (a.ax() - b.ax()) + (b.bx() - b.ax()) * (a.ay() - b.ay())) *
                ((b.ay() - b.by()) * (a.bx() - b.ax()) + (b.bx() - b.ax()) * (a.by() - b.ay())) <=
            tolerance) {
        return true;
    }

    return false;
}

// intersection test: touching does not count as an intersection
// (uses dot product comparison)

bool intersect_line_no_touch(const Line &a, const Line &b, double tolerance) {
    g_count++;

    if (((a.ay() - a.by()) * (b.ax() - a.ax()) + (a.bx() - a.ax()) * (b.ay() - a.ay())) *
                ((a.ay() - a.by()) * (b.bx() - a.ax()) + (a.bx() - a.ax()) * (b.by() - a.ay())) <
            -tolerance &&
        ((b.ay() - b.by()) * (a.ax() - b.ax()) + (b.bx() - b.ax()) * (a.ay() - b.ay())) *
                ((b.ay() - b.by()) * (a.bx() - b.ax()) + (b.bx() - b.ax()) * (a.by() - b.ay())) <
            -tolerance) {
        return true;
    }

    return false;
}

// returns 0 for no intersect, 1 for touching and 2 for crossing
int intersect_line_distinguish(const Line &a, const Line &b, double tolerance) {
    g_count++;

    double alpha = ((a.ay() - a.by()) * (b.ax() - a.ax()) + (a.bx() - a.ax()) * (b.ay() - a.ay())) *
                   ((a.ay() - a.by()) * (b.bx() - a.ax()) + (a.bx() - a.ax()) * (b.by() - a.ay()));

    double beta = ((b.ay() - b.by()) * (a.ax() - b.ax()) + (b.bx() - b.ax()) * (a.ay() - b.ay())) *
                  ((b.ay() - b.by()) * (a.bx() - b.ax()) + (b.bx() - b.ax()) * (a.by() - b.ay()));

    if (alpha <= tolerance && beta <= tolerance) {
        if (alpha < -tolerance && beta < -tolerance) {
            return 2;
        } else {
            return 1;
        }
    }

    return 0;
}

// returns 0 for no intersect, 1 for touching and 2 for crossing
// n.b. only used by polygon contains -- throws if the first point of line b is touching line a
// (first point of line b is the point to be tested) -- i.e., throws if point touches polygon
int intersect_line_b(const Line &a, const Line &b, double tolerance) {
    g_count++;

    double alpha = ((a.ay() - a.by()) * (b.ax() - a.ax()) + (a.bx() - a.ax()) * (b.ay() - a.ay()));

    double beta = ((a.ay() - a.by()) * (b.bx() - a.ax()) + (a.bx() - a.ax()) * (b.by() - a.ay()));

    double gamma = ((b.ay() - b.by()) * (a.ax() - b.ax()) + (b.bx() - b.ax()) * (a.ay() - b.ay())) *
                   ((b.ay() - b.by()) * (a.bx() - b.ax()) + (b.bx() - b.ax()) * (a.by() - b.ay()));

    if (alpha * beta <= tolerance && gamma <= tolerance) {
        if (alpha * beta < -tolerance && gamma < -tolerance) {
            return 2;
        } else {
            // this function is only used for poly contains point,
            // the throw is defined if the point is *on* the polygon edge
            // (within the tolerance)
            if (fabs(alpha) <= tolerance) {
                throw 1;
            }
            return 1;
        }
    }
    return 0;
}

double Line::intersection_point(const Line &l, int axis, double tolerance) const {
    // use axis = XAXIS for width() > height()
    double loc;
    if (axis == XAXIS) {
        if (l.width() == 0.0) {
            loc = l.bottomLeft.x;
        } else {
            // Using long doubles here to force higher accuracy of calculations
            // and thus parity of the x86 and arm64 results
            long double lg = l.grad(YAXIS);
            long double g = grad(YAXIS);
            if (fabs(static_cast<double>(lg - g)) <= tolerance) {
                // these have almost the same gradient, so it's impossible to tell where they
                // intersect: going for midpoint
                Point2f p = l.midpoint();
                loc = (p.x > topRight.x) ? topRight.x : ((p.x < bottomLeft.x) ? bottomLeft.x : p.x);
            } else {
                // this is the same as: constant(YAXIS) - l.constant(YAXIS)) / (l.grad(YAXIS) -
                // grad(YAXIS));
                // Using long doubles here to force higher accuracy of calculations
                // and thus parity of the x86 and arm64 results
                long double laxv = l.ax();
                long double layv = l.ay();
                long double axv = ax();
                long double ayv = ay();
                loc = static_cast<double>(((ayv - (g * axv)) - (layv - lg * laxv)) / (lg - g));
            }
        }
    } else {
        if (l.height() == 0.0) {
            loc = l.bottomLeft.y;
        } else {
            // Using long doubles here to force higher accuracy of calculations
            // and thus parity of the x86 and arm64 results
            long double lg = l.grad(XAXIS);
            long double g = grad(XAXIS);
            if (fabs(static_cast<double>(lg - g)) <= tolerance) {
                // these have almost the same gradient, so it's impossible to tell where they
                // intersect: going for midpoint
                Point2f p = l.midpoint();
                loc = (p.y > topRight.y) ? topRight.y : ((p.y < bottomLeft.y) ? bottomLeft.y : p.y);
            } else {
                // this is the same as: constant(XAXIS) - l.constant(XAXIS)) / (l.grad(XAXIS) -
                // grad(XAXIS));
                // Using long doubles here to force higher accuracy of calculations
                // and thus parity of the x86 and arm64 results
                long double laxv = l.ax();
                long double layv = l.ay();
                long double axv = ax();
                long double ayv = ay();
                loc = static_cast<double>(((axv - (g * ayv)) - (laxv - (lg * layv))) / (lg - g));
            }
        }
    }
    return loc;
}

// intersecting line segments, touching counts
// (uses intersection point comparison)

bool Line::intersect_line(const Line &l, int axis, double &loc) const {
    // please be intelligent when passing the axis...
    if (axis == XAXIS) {
        if (l.width() == 0.0) {
            // Special case:
            double y = ay() + sign() * (l.ax() - ax()) * height() / width();
            if (y >= bottomLeft.y && y <= l.topRight.y) { // <- you must have checked
                loc = l.bottomLeft.x;                     //    the regions overlap first
                return true;
            }
        } else {
            // Standard:   (note: if m1 == m2, loc is NaN)
            loc = (constant(YAXIS) - l.constant(YAXIS)) / (l.grad(YAXIS) - grad(YAXIS));
            if (std::isnan(loc)) {
                // lines are parallel --- are they coincident?
                // you must have checked the regions overlap first
                if (constant(YAXIS) == l.constant(YAXIS)) {
                    return true;
                }
            } else if (loc >= l.bottomLeft.x && loc <= l.topRight.x) {
                return true;
            }
        }
    } else {
        if (l.height() == 0.0) {
            // Special case:
            double x = ax() + sign() * (l.ay() - ay()) * width() / height();
            if (x >= bottomLeft.x && x <= topRight.x) { // <- you must have checked
                loc = l.bottomLeft.y;                   //  the regions overlap first
                return true;
            }
        } else {
            // Standard:   (note: if m1 == m2, loc is NaN)
            loc = (constant(XAXIS) - l.constant(XAXIS)) / (l.grad(XAXIS) - grad(XAXIS));
            if (std::isnan(loc)) {
                // lines are parallel --- are they coincident?
                // you must have checked the regions overlap first
                if (constant(XAXIS) == l.constant(XAXIS)) {
                    return true;
                }
            } else if (loc >= l.bottomLeft.y && loc <= l.topRight.y) {
                return true;
            }
        }
    }
    return false;
}

// this converts the loc back into a point:

Point2f Line::point_on_line(double loc, int axis) const {
    Point2f p;
    if (axis == XAXIS) {
        p = Point2f(loc, grad(YAXIS) * loc + constant(YAXIS));
    } else {
        p = Point2f(grad(XAXIS) * loc + constant(XAXIS), loc);
    }
    return p;
}

//////////////////////////////////////////////////////////////////////////////

// distance from a point to a line segment

double dist(const Point2f &point, const Line &line) {
    double d = 0.0;

    Point2f alpha = line.end() - line.start();
    Point2f beta = point - line.end();
    Point2f gamma = line.start() - line.end();
    Point2f delta = point - line.start();

    if (dot(alpha, beta) > 0) {
        d = beta.length();
    } else if (dot(gamma, delta) > 0) {
        d = delta.length();
    } else {
        if (alpha.length() < 1e-9 * beta.length()) {
            // should actually be a user-specified tolerance test
            d = beta.length();
        } else {
            d = fabs(det(alpha, beta)) / alpha.length();
        }
    }
    return d;
}

/*
   // for infinite line rather than line segment
   return fabs((line.bx() - line.ax()) * (line.ay() - point.y) -
               (line.ax() - point.x) * (line.by() - line.ay())) / line.length();
*/

//////////////////////////////////////////////////////////////////////////////

// intersection test

bool intersect(const RegionTree &a, const RegionTree &b) {
    if (a.is_leaf() && b.is_leaf()) {
        if (intersect_region(QtRegion(a), QtRegion(b))) {
            return intersect_line((const Line &)QtRegion(a), (const Line &)QtRegion(b));
        } else {
            return false;
        }
    } else {
        if (intersect_region(QtRegion(a), QtRegion(b))) {
            return subintersect(a, b);
        } else {
            return false;
        }
    }
}

bool subintersect(const RegionTree &a, const RegionTree &b) {
    if (intersect(a.left(), b.left())) {
        return true;
    } else if (intersect(a.right(), b.right())) {
        return true;
    } else if (intersect(a.left(), b.right())) {
        return true;
    } else if (intersect(a.right(), b.left())) {
        return true;
    }

    return false;
}

// Intersection count

int intersections(const RegionTree &a, const Line &b) {
    int n = 0;

    if (!a.is_leaf()) {
        if (intersect_region(QtRegion(a), QtRegion(b))) {
            n += intersections(a.left(), b);
            n += intersections(a.right(), b);
        }
    } else {
        // Note: touching lines count 1, non-touching lines count 2, this allows through
        // vertex lines (where it touches both vertices)
        n += intersect_line_b((const Line &)a, (const Line &)b);
    }

    return n;
}

//////////////////////////////////////////////////////////////////////////////

// crop a line to fit within bounds of region
// if line lies outside region, returns false

bool Line::crop(const QtRegion &r) {
    if (bx() >= r.bottomLeft.x) {
        if (ax() < r.bottomLeft.x) {
            // crop!
            ay() += sign() * (height() * (r.bottomLeft.x - ax()) / width());
            ax() = r.bottomLeft.x;
        }
        if (ax() <= r.topRight.x) {
            if (bx() > r.topRight.x) {
                // crop!
                by() -= sign() * height() * (bx() - r.topRight.x) / width();
                bx() = r.topRight.x;
            }
            if (topRight.y >= r.bottomLeft.y) {
                if (bottomLeft.y < r.bottomLeft.y) {
                    // crop!
                    if (m_bits.parity) {
                        ax() += width() * (r.bottomLeft.y - bottomLeft.y) / height();
                    } else {
                        bx() -= width() * (r.bottomLeft.y - bottomLeft.y) / height();
                    }
                    bottomLeft.y = r.bottomLeft.y;
                }
                if (bottomLeft.y <= r.topRight.y) {
                    if (topRight.y > r.topRight.y) {
                        // crop!
                        if (m_bits.parity) {
                            bx() -= width() * (topRight.y - r.topRight.y) / height();
                        } else {
                            ax() += width() * (topRight.y - r.topRight.y) / height();
                        }
                        topRight.y = r.topRight.y;
                    }
                    // if we got this far, well done, it's in the region:
                    return true;
                }
            }
        }
    }
    // returns false if the entire line is outside the region:
    return false;
}

// cast a ray to the edge of a box

void Line::ray(short dir, const QtRegion &r) {
    if (dir == m_bits.direction) {
        if (width() >= height()) {
            by() = ay() + sign() * height() * (r.topRight.x - ax()) / width();
            bx() = r.topRight.x;
        } else if (m_bits.parity) {
            bx() = ax() + width() * (r.topRight.y - ay()) / height();
            by() = r.topRight.y;
        } else {
            bx() = ax() + width() * (ay() - r.bottomLeft.y) / height();
            by() = r.bottomLeft.y;
        }
    } else {
        if (width() >= height()) {
            ay() = by() - sign() * height() * (bx() - r.bottomLeft.x) / width();
            ax() = r.bottomLeft.x;
        } else if (m_bits.parity) {
            ax() = bx() - width() * (by() - r.bottomLeft.y) / height();
            ay() = r.bottomLeft.y;
        } else {
            ax() = bx() - width() * (r.topRight.y - by()) / height();
            ay() = r.topRight.y;
        }
    }
    // now fit within bounds...
    crop(r);
}

//////////////////////////////////////////////////////////////////////////////

// Polygon set up (the hard bit!)

void Poly::add_line_segment(const Line &l) {
    m_lineSegments++;
    RegionTreeLeaf *leaf = new RegionTreeLeaf(l);

    if (m_pRoot == nullptr) {
        // first ever node

        m_pRoot = (RegionTree *)leaf;
    } else {
        // traverse the tree to the insertion point
        //   you'll just have to take my word for it that the next line
        //   gives you the correct position to insert
        int cutLevel = bitcount(m_lineSegments - 1) - 2;

        if (cutLevel < 0) {
            // replace the root node

            QtRegion newRegion = runion(QtRegion(*m_pRoot), QtRegion(*leaf));
            RegionTree *newRoot = new RegionTreeBranch(newRegion, *m_pRoot, *leaf);
            m_pRoot = newRoot;
        } else {
            RegionTree *here = m_pRoot;
            for (int i = 0; i < cutLevel; i++) {
                here = here->m_pRight;
            }

            // cut and insert

            RegionTree &insertionPoint = here->right();

            QtRegion newRegion = runion(QtRegion(insertionPoint), QtRegion(*leaf));

            RegionTree *newNode = new RegionTreeBranch(newRegion, insertionPoint, *leaf);

            here->m_pRight = newNode;

            // traverse up tree unioning regions
            // (saving data by not recording parents!)
            // Note must be '>=' to catch current root node --- I really stuffed up earlier with
            // '>'!
            while (cutLevel >= 0) {
                here = m_pRoot;
                for (int j = 0; j < cutLevel; j++) {
                    here = here->m_pRight;
                }
                here->m_pRegion = new Line(runion(QtRegion(here->left()), QtRegion(here->right())));
                cutLevel--;
            }
        }
    }
}

// ...and after all the efficient stuff, we have a really
// inefficient polygon copy... hmm

RegionTree *Poly::copy_region_tree(const RegionTree *tree) {
    if (!tree) {
        return nullptr;
    }

    RegionTree *newtree;

    if (tree->is_leaf()) {
        newtree = new RegionTreeLeaf();
        newtree->m_pRegion = new Line(*(tree->m_pRegion));
        return newtree;
    } else {
        newtree = new RegionTreeBranch();
    }

    std::vector<RegionTree *> newlist;
    std::vector<RegionTree *> oldlist;

    oldlist.push_back((RegionTree *)tree);
    newlist.push_back((RegionTree *)newtree);

    do {
        RegionTree *oldnode = oldlist.back();
        oldlist.pop_back();
        RegionTree *newnode = newlist.back();
        newlist.pop_back();

        newnode->m_pRegion = new Line(*oldnode->m_pRegion);

        if (oldnode->m_pLeft) {
            if (oldnode->m_pLeft->is_leaf()) {
                newnode->m_pLeft = new RegionTreeLeaf();
                newnode->m_pLeft->m_pRegion = new Line(*(oldnode->m_pLeft->m_pRegion));
            } else {
                oldlist.push_back(oldnode->m_pLeft);
                newnode->m_pLeft = new RegionTreeBranch();
                newlist.push_back(newnode->m_pLeft);
            }
        }
        if (oldnode->m_pRight) {
            if (oldnode->m_pRight->is_leaf()) {
                newnode->m_pRight = new RegionTreeLeaf();
                newnode->m_pRight->m_pRegion = new Line(*(oldnode->m_pRight->m_pRegion));
            } else {
                oldlist.push_back(oldnode->m_pRight);
                newnode->m_pRight = new RegionTreeBranch();
                newlist.push_back(newnode->m_pRight);
            }
        }

    } while (oldlist.size() > 0);

    return newtree;
}

// polygon destruction

void Poly::destroy_region_tree() {
    if (!m_pRoot) {
        return;
    }

    std::vector<RegionTree *> delNodeList;
    std::vector<short> delNodeDir;

    delNodeList.push_back(m_pRoot);

    do {
        RegionTree *currentNode = delNodeList.back();

        if (currentNode->m_pLeft == currentNode && currentNode->m_pRight == currentNode) {

            delete currentNode;
            delNodeList.pop_back();

            if (delNodeList.size() > 0) {
                if (delNodeDir.back() == 0) {
                    delNodeList.back()->m_pLeft = delNodeList.back();
                    delNodeDir.pop_back();
                } else {
                    delNodeList.back()->m_pRight = delNodeList.back();
                    delNodeDir.pop_back();
                }
            }
        } else {
            if (currentNode->m_pRight == nullptr) {
                currentNode->m_pRight = currentNode;
            } else if (currentNode->m_pRight != currentNode) {
                delNodeList.push_back(currentNode->m_pRight);
                delNodeDir.push_back(1);
            } else {
                delNodeList.push_back(currentNode->m_pLeft);
                delNodeDir.push_back(0);
            }
        }
    } while (delNodeList.size() > 0);

    m_pRoot = nullptr;
}

// contains? intersects??

// Here they are!

bool Poly::contains(const Point2f &p) {
    // n.b., intersections throws on some accidental alignments --
    // we must use a point outside the polygon to extend our test
    // line from to prevent them
    Line l(p, Point2f(get_bounding_box().topRight.x + get_bounding_box().width(),
                      get_bounding_box().topRight.y + get_bounding_box().height()));

    int doubleN;

    // note, touching intersections count 1/2
    try {
        doubleN = intersections(*(m_pRoot), l);
    } catch (int) {
        throw 1; // throws if on edge
    }

    if (doubleN % 2 == 0 && doubleN % 4 != 0) {
        return true;
    }

    return false;
}

bool intersect(const Poly &a, const Poly &b) {
    if (intersect(*(a.m_pRoot), *(b.m_pRoot))) {
        return true;
    }
    return false;
}
