function [ output ] = neural_function( R , R_dot , A )
%neural_function gives the output of the function
%   Instead of using the symbolic toolkit, we build separate
%   functions to represent the function being minimized in the problem. 

output =  norm( R_dot - R * ( A - A' ) , 'fro' ) ^ 2;

end

