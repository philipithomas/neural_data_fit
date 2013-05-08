%% Intro
% Fitting Dynamical Systems to Neural Data
% April 2013
% ESE 415: Optimization
%
% Rachel Blake
% Adam Weinberger
% Philip Thomas

%% Reset
clear
clf
close all
format long
clc

%% Variable initialization

% N is the dimension
N = 100;

% Number of movements
C = 10;

% Number of samples
T = 100;

% R is treated as a random matrix, but it represents the ?ring rates at the
% movement times
R = rand( C * T , N );

% initialize first iteration of decision variable, M
M = skewdec( N , N ); 


%% Generation of R_dot

% initialize blank R_dot
R_dot = zeros( C * T , N );

% Loop through and subtract subsequent test
for i = 1:C
    for j = 1:T
        if ( j == 1 )
            % no prior trial - just zeros
            %
            % It's already zeros based on initialization, but this is
            % the equivalent of what we would do:
            %
            % R_dot( ( ( i-1 ) * T + j ), : ) = zeros( 1 , N );
        else
            % Calculate new row
            current_trial = R( ( ( i-1 ) * T + j ), : );
            prior_trial   = R( ( ( i-1 ) * T + j - 1 ), : );
            new_row       = current_trial - prior_trial;  
            
            % Insert new row
            R_dot( ( ( i-1 ) * T + j ), : ) = new_row;
        end
    end
end

% Functions are separate files
% neural_function(  R , R_dot , M )
% neural_function_derivative(  R , R_dot , M )
% neural_function_hessian(  R , R_dot , M )

% We converge partially with Newton's method, then use Steepest Descent


%% Steepest Descent
l = 0;
threshhold_steepest = 10^( -5 );
alpha = 10^-5;
sigma = 1.000000000000001;
while 1>0
    M_prior_descent = M;
    l = l + 1
    
   
    % direction
    d = -1 * neural_function_derivative( R , R_dot , M );
    
    % step size
%   alpha = pinv(R) * ( R_dot * ( d * R' ) - R * M * ( d * R' ) ) * pinv( d * (d * R'));
%   alpha = inv(R'*R) * (-R'*R_dot * d - R'*R*M*d) * inv(d*d); 
    alpha = alpha/sigma;
%   index = find(alpha<0);
%    alpha(index) = 0;
 
    M = M + alpha .* d;
    
    % Force Skew Symmetry
    M = (M - M')./2;
    neural_function( R , R_dot , M )
    error = norm( M - M_prior_descent , 2 );
    norm1(l) = norm(neural_function_derivative( R , R_dot , M ));
    if norm(neural_function_derivative( R , R_dot , M )) < threshhold_steepest  %error < threshhold_steepest
        break;
    end
end



value = neural_function( R , R_dot , M )