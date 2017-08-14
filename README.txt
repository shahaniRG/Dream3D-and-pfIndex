"pfIndex.m" is a Matlab program that hkl indexes peaks on a stereographical pole figure. pfIndex opens the pole figure image in Matlab and requests four sets of xy-coordinates from the image as input: the [001] axis, the [111] axis, the [101] axis, and the peak to be indexed.

pfIndex uses the inverse of the stereographic projection to convert the inputted xy-coordinates from a 2D plane to 3D spherical coordinates using the following equation:

r = x^2 + y^2
(x,y,0) -> (X,Y,Z) = (2x/(r^2 + 1), 2y(r^2 + 1), (r^2 - 1)/(r^2 + 1))

This conversion is performed to minimize the effects of distortion from the stereographical projection. Using a system of linear equations, Matlab then solves for the 3x3 rotation matrix (M) required to align the axes XYZ-coordinates with their respective hkl.

[m11 m12 m13] [X] = [h]
[m21 m22 m23] [Y] = [k]
[m31 m32 m33] [Z] = [l]

The hkl value of the peak is then found by multiplying the rotation matrix to the peak's XYZ-coordinates. The user may need to manually clear fractions in the result. Fractional values may have some error due to rounding.
