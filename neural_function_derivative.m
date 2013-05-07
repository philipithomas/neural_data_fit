function [ output ] = neural_function_derivative( R , R_dot , A )
%neural_function_derivative gives the output of the function derivative
%   Instead of using the symbolic toolkit, we build separate
%   functions to represent the function being minimized in the problem. 

output = 2 .* ( ( R_dot' * R )' + R_dot' * R - R' * R_dot + ...
    ( R' * R_dot )' + ( R' * R + ( R' * R )') * A + ...
    ( R' * R + ( R' * R )' ) * A' );

% Frobenius norm derivative source:
% http://select.cs.cmu.edu/class/10725-S10/recitations/r4/Matrix_Calculus_Algebra.pdf

end



