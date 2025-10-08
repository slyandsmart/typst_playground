import numpy as np 

def tangent_point_on_line(Px, v, C):
    """
    Tangency point of the circle centered at C to the line L: Px + u*v.

    Parameters
    ----------
    Px : (2,) a point on the line (your common vertex)
    v  : (2,) direction of the line (v2 for the second line)
    C  : (2,) circle center

    Returns
    -------
    T : (2,) tangency point on the line L
    """
    Px = np.asarray(Px, float)
    v  = np.asarray(v,  float)
    C  = np.asarray(C,  float)

    u = -np.dot(Px - C, v) / np.dot(v, v)   # projection parameter
    T = Px + u * v
    return T
EPS = 1e-12

def _unit(v):
    v = np.asarray(v, dtype=float)
    n = np.linalg.norm(v)
    if n < EPS:
        raise ValueError("Zero-length direction.")
    return v / n

def circle_tangent_to_two_lines(Px, v1, v2, *,
                                which="internal",
                                p_on_circle=None,
                                radius=None):
    """
    Circle tangent to the two lines L1: Px + t*v1 and L2: Px + u*v2.

    Parameters
    ----------
    Px : (2,) point (common vertex of the two lines)
    v1, v2 : (2,) direction vectors (non-parallel)
    which : "internal" or "external"
        Selects the angle bisector to use.
    p_on_circle : (2,), optional
        If provided, the circle will also pass through this point (unique solution).
    radius : float, optional
        If provided, sets the radius. (If p_on_circle is also given, p_on_circle wins.)

    Returns
    -------
    C : (2,) center of the circle
    r : float radius

    Notes
    -----
    - Centers of circles tangent to both lines lie on the angle bisectors.
    - For a center C located at C = Px + s * b (b = chosen bisector unit),
      the radius is r = s * sin(theta/2), where theta is the angle between v1 and v2.
    """
    Px = np.asarray(Px, float)
    u1 = _unit(v1)
    u2 = _unit(v2)

    # angle between directions
    dot = np.clip(u1 @ u2, -1.0, 1.0)
    theta = np.arccos(dot)
    if abs(np.sin(theta)) < EPS:
        raise ValueError("Lines are parallel/collinear; infinite or undefined solutions.")

    # bisector unit vector (internal: u1+u2, external: u1-u2)
    if which == "internal":
        b_raw = u1 + u2
    elif which == "external":
        b_raw = u1 - u2
    else:
        raise ValueError("which must be 'internal' or 'external'.")

    if np.linalg.norm(b_raw) < EPS:
        # happens when u1 ~ -u2 and you chose the degenerate bisector
        raise ValueError("Chosen bisector is undefined for this configuration.")

    b = b_raw / np.linalg.norm(b_raw)

    # geometry: for center C = Px + s b, radius r = s * sin(theta/2)
    phi = 0.5 * theta
    s_to_r = np.sin(phi)

    if p_on_circle is not None:
        p = np.asarray(p_on_circle, float)
        # Solve ||(Px - p) + s b||^2 = (s sin(phi))^2
        d = Px - p
        db = float(d @ b)
        d2 = float(d @ d)
        # (cos^2 phi) s^2 + 2(db) s + d2 = 0
        c2 = np.cos(phi) ** 2
        A = c2
        B = 2.0 * db
        Cq = d2

        # quadratic solution
        disc = B * B - 4 * A * Cq
        if disc < -1e-12:
            raise ValueError("No real solution for the requested constraints.")
        disc = max(disc, 0.0)  # clamp tiny negative due to roundoff
        s_candidates = [(-B + np.sqrt(disc)) / (2 * A),
                        (-B - np.sqrt(disc)) / (2 * A)]
        # pick the physically sensible one: s > 0 (center in direction of b from Px)
        s = max(s_candidates, key=lambda x: x)  # prefer the larger
        if s <= 0:
            # fall back to the positive one if available
            s_pos = [sc for sc in s_candidates if sc > 0]
            if not s_pos:
                raise ValueError("No positive-distance center on the chosen bisector.")
            s = s_pos[0]

        C = Px + s * b
        r = s * s_to_r
        return C, float(r)

    if radius is not None:
        if radius <= 0:
            raise ValueError("radius must be > 0")
        s = radius / s_to_r
        C = Px + s * b
        return C, float(radius)

    # If neither p_on_circle nor radius is provided, there are infinitely many solutions.
    # Return a default one, e.g., s = 1 along the chosen bisector.
    s = 1.0
    C = Px + s * b
    r = s * s_to_r
    return C, float(r)




def intersect_2d_lines(p1, v1, p2, v2, eps=1e-12):
    """
    Intersection of two infinite 2D lines:
      L1: p1 + t * v1
      L2: p2 + u * v2

    Returns:
    (x, y) tuple for the intersection, or None if parallel/collinear.
    """
    x1, y1 = p1
    a1, b1 = v1  # direction of L1
    x2, y2 = p2
    a2, b2 = v2  # direction of L2

    # Solve: p1 + t*v1 = p2 + u*v2  ->  t*v1 - u*v2 = (p2 - p1)
    #  [ a1  -a2 ] [ t ] = [ x2 - x1 ]
    #  [ b1  -b2 ] [ u ]   [ y2 - y1 ]
    det = a1 * (-b2) - b1 * (-a2)   # = -(a1*b2 - b1*a2) = -cross(v1,v2)

    if abs(det) < eps:
        return None  # parallel (or collinear) -> no unique intersection

    dx, dy = (x2 - x1), (y2 - y1)

    # Cramer's rule
    t = (dx * (-b2) - dy * (-a2)) / det
    ix = x1 + t * a1
    iy = y1 + t * b1
    return (ix, iy)


def normal_vectors(vec: list[float]) -> list[float]:

    n_left = np.array([-vec[1], vec[0]])
    n_right = -n_left
    return [n_left, n_right]

def check_min_point(p1,p2,Px):
    dis_p1 = Px - p1
    dis_p2 = Px - p2
    mindis = np.min([np.linalg.norm(dis_p1),np.linalg.norm(dis_p2)])   
    if np.linalg.norm(dis_p1) < np.linalg.norm(dis_p2):
        return mindis, p1
    else:
        return mindis, p2    

    return mindis

p1 = np.array([0.0, 0.0])
p2 = np.array([-6.0, 7.0])

distance = p1 - p2

print('distance: ', distance)

p1n = normal_vectors(p1)

print('normalvectoren p1n: ', p1n)

vp1 = (1, 0.1)  # direction vector of line through p1
vp2 = (0.1, -1)  # direction vector of line through p2

Px = intersect_2d_lines(p1, vp1, p2, vp2)

print('schnittpunkt: ', Px)

mindis, p = check_min_point(p1, p2, Px)

print('mindis: ', mindis)


# circle center is on normalvector of p1 with distance mindis
if distance[1] < 0:
    circle_center = p1 + (mindis) * normal_vectors(vp1)[0] / np.linalg.norm(normal_vectors(vp1)[0])
    th1s = 180
    th2s = 270
else:       
    circle_center = p1 + (mindis) * normal_vectors(vp1)[1] / np.linalg.norm(normal_vectors(vp1)[1])
    th1s = 90
    th2s = 180


v1 = p1 - Px
v2 = p2 - Px
# Option A: circle tangent to both lines and passing through p1
circle_center, r = circle_tangent_to_two_lines(Px, v1, v2, which="internal", p_on_circle=p1)

# Option B: circle tangent to both lines with a chosen radius
# C, r = circle_tangent_to_two_lines(Px, v1, v2, which="internal", radius=2.0)


# Tangency point on the second line (through p2):
T2 = tangent_point_on_line(Px, v2, circle_center)


# Add two points in direction of the vectors of p1 and p2 with a distance of lin_length = 1
lin_length = 2.5
p1_end = p1 + lin_length * np.array(vp1) / np.linalg.norm(vp1)
p2_end = p2 - lin_length * np.array(vp2) / np.linalg.norm(vp2)



# Plot points and vectors as well as a circle with radius mindis and center on normalvector of p1,
import matplotlib.pyplot as plt
import matplotlib.patches as patches
fig, ax = plt.subplots()

ax.plot(Px[0], Px[1], 'go')  # intersection point
ax.plot(p1[0], p1[1], 'ro')  # point p1
ax.plot(p2[0], p2[1], 'bo')  # point p2
ax.plot(T2[0], T2[1], 'co')  # tangency point on line 2
ax.plot(p1_end[0], p1_end[1], 'ro')  # end point of p1 vector
ax.plot(p2_end[0], p2_end[1], 'bo')  # end point of p2 vector
ax.plot([p1[0], p1_end[0]], [p1[1], p1_end[1]], 'r-')  # line for p1
ax.plot([p2[0], p2_end[0]], [p2[1], p2_end[1]], 'b-')  # line for p2

ax.plot(circle_center[0], circle_center[1], 'mo')  # circle center
ax.text(p1[0], p1[1], 'p1', fontsize=12, ha='right')
ax.text(p2[0], p2[1], 'p2', fontsize=12, ha='right')
ax.text(Px[0], Px[1], 'Px', fontsize=12, ha='right')
ax.text(T2[0], T2[1], 'T2', fontsize=12, ha='right')
ax.text(p1_end[0], p1_end[1], 'p1_end', fontsize=12, ha='left')
ax.text(p2_end[0], p2_end[1], 'p2_end', fontsize=12, ha='right')

circle = patches.Circle((circle_center[0], circle_center[1]), r, fill=False, color='b', linestyle='--')
circle_arc = patches.Arc((circle_center[0], circle_center[1]), 2*r, 2*r, angle=0,
                                theta1=th2s, theta2=th1s, color='r', linestyle='--')
# x, y points of the circle_arc
x_arc = [circle_center[0] + r * np.cos(np.radians(angle)) for angle in range(th1s, th2s)]
y_arc = [circle_center[1] + r * np.sin(np.radians(angle)) for angle in range(th1s, th2s)]
ax.plot(x_arc, y_arc, 'g--')

# line from px to p1 and from px to p2
ax.plot([Px[0], p1[0]], [Px[1], p1[1]], 'r--')
ax.plot([Px[0], p2[0]], [Px[1], p2[1]], 'b--')
ax.add_patch(circle)

ax.set_aspect('equal')
ax.set_xlim(-10, 20)
ax.set_ylim(-10, 20)
# plt.grid()
# plt.show()
# fig, ax = plt.subplots()
# Now create with new plot figure 
# one single numpy array  from p1_ent to p2_end with n points in it following the arc of the circle combined with the two line segments
n = 600
line1 = np.linspace(p1_end, p1, n//4, endpoint=False)
line2 = np.linspace(p2, p2_end, n//4, endpoint=True)
arc = np.array([ (circle_center[0] + r * np.cos(np.radians(angle)),
                  circle_center[1] + r * np.sin(np.radians(angle))) 
                 for angle in range(th2s, th1s, (th1s-th2s)//(n//2))])
points = np.vstack((line1, arc, line2))
print('points shape: ', points.shape)
print('points: ', points)   

ax.plot(points[:,0], points[:,1], 'g-')
ax.set_aspect('equal')   
ax.set_xlim(-10, 20)
ax.set_ylim(-10, 20)
plt.grid()
plt.show()