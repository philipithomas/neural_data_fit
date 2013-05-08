function [ output ] = neural_function_derivative( R , R_dot , M )
%neural_function_derivative gives the output of the function derivative
%   Instead of using the symbolic toolkit, we build separate
%   functions to represent the function being minimized in the problem. 

output = ( -1 .* R' ) * ( 2 .* ( R_dot - R * M ) );
% Frobenius norm derivative source:
% http://select.cs.cmu.edu/class/10725-S10/recitations/r4/Matrix_Calculus_Algebra.pdf

end


