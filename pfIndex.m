format compact
%Opens pole figure image
prompt = 'Filename: ';
fname = input(prompt, 's');
image = imread(fname);
imshow(image)

%if you want to reindex the same image triangle multiple times, this saves 
%the previous axes coordinates
fprintf('Same image and IPF?\n');
samevar = input('true/false?: ');
if samevar == false
	clear all
	%these variables should be pixel values from the image
	fprintf('Enter coordinates of [001] axis\n');
	ax = input('x: ');
	ay = input('y: ');
	
	fprintf('Enter coordinates of [-111] axis\n');
	bx = input('x: ');
	by = input('y: ');
	
	fprintf('Enter coordinates of [011] axis\n');
	cx = input('x: ');
	cy = input('y: ');
end

fprintf('Enter coordinates of the peak to index\n');
dx = input('x: ');
dy = input('y: ');

%default axes
axisA = [0; 0; 1];
axisB = [-1; 1; 1];
axisC = [0; 1; 1];
%calculate the sphere coordinates of each axis
%(x,y,0) -> (X, Y, Z)
Aprime = [2*ax/(ax^2 + ay^2 + 1); 2*ay/(ax^2 + ay^2 + 1); (ax^2 + ay^2 - 1)/(ax^2 + ay^2 + 1)];
Bprime = [2*bx/(bx^2 + by^2 + 1); 2*by/(bx^2 + by^2 + 1); (bx^2 + by^2 - 1)/(bx^2 + by^2 + 1)];
Cprime = [2*cx/(cx^2 + cy^2 + 1); 2*cy/(cx^2 + cy^2 + 1); (cx^2 + cy^2 - 1)/(cx^2 + cy^2 + 1)];
Dprime = [2*dx/(dx^2 + dy^2 + 1); 2*dy/(dx^2 + dy^2 + 1); (dx^2 + dy^2 - 1)/(dx^2 + dy^2 + 1)];

% [m11 m12 m13] [X] = [axis]
% [m21 m22 m23] [Y] = [axis]
% [m31 m32 m33] [Z] = [axis]
syms m11 m12 m13
eqn1 = Aprime(1,1)*m11 + Aprime(2,1)*m12 + Aprime(3,1)*m13 == axisA(1,1);
eqn2 = Bprime(1,1)*m11 + Bprime(2,1)*m12 + Bprime(3,1)*m13 == axisB(1,1);
eqn3 = Cprime(1,1)*m11 + Cprime(2,1)*m12 + Cprime(3,1)*m13 == axisC(1,1);
M1 = solve([eqn1, eqn2, eqn3], [m11, m12, m13]);

syms m21 m22 m23
eqn4 = Aprime(1,1)*m21 + Aprime(2,1)*m22 + Aprime(3,1)*m23 == axisA(2,1);
eqn5 = Bprime(1,1)*m21 + Bprime(2,1)*m22 + Bprime(3,1)*m23 == axisB(2,1);
eqn6 = Cprime(1,1)*m21 + Cprime(2,1)*m22 + Cprime(3,1)*m23 == axisC(2,1);
M2 = solve([eqn4, eqn5, eqn6], [m21, m22, m23]);

syms m31 m32 m33
eqn7 = Aprime(1,1)*m31 + Aprime(2,1)*m32 + Aprime(3,1)*m33 == axisA(3,1);
eqn8 = Bprime(1,1)*m31 + Bprime(2,1)*m32 + Bprime(3,1)*m33 == axisB(3,1);
eqn9 = Cprime(1,1)*m31 + Cprime(2,1)*m32 + Cprime(3,1)*m33 == axisC(3,1);
M3 = solve([eqn7, eqn8, eqn9], [m31, m32, m33]);

%     [m11 m12 m13]
% M = [m21 m22 m23]
%	  [m31 m32 m33]
M = [M1.m11, M1.m12, M1.m13; M2.m21, M2.m22, M2.m23; M3.m31, M3.m32, M3.m33];

fprintf('hkl is:\n');
hkl = double(M*Dprime);
disp(rot90(hkl))
fprintf('User may need to clear fractions\n');


%Kabsch method
% [aU, ar] = Kabsch(Aprime, axisA);
% [bU, br] = Kabsch(Bprime, axisB);
% [cU, cr] = Kabsch(Cprime, axisC);

% XYZ = [Aprime, Bprime, Cprime];
% Axes = [axisA, axisB/sqrt(3), axisC/sqrt(2)];
% [Rot, Trans] = Kabsch(XYZ, Axes);