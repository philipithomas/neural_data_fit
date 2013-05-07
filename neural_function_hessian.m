function [ output ] = neural_function_hessian( R , R_dot , A )
%neural_function_hessian returns the output of the function derivative
%   Instead of using the symbolic toolkit, we build separate
%   functions to represent the function being minimized in the problem. 

output = ( R' * R + ( R' * R )' )' + R' * R + ( R' * R )';

end

