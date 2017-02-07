clear;

filename = 'phillipp2.data';
d = 50;
it = 20;
%filename = 'phillipp4.data';
%d = 5;
%it = 10;

X = load(filename);
A = X(1:d,:);
b = X(d+1,:)';
z = X(d+2,:)';

% Get some stats
max(max(abs(A)))
min(min(abs(A)))
norm(A - A')
cond(A)
norm(A*z - b)
norm(z - linsolve(A,b))
norm(z - pinv(A)*b)

figure; hold all;

% Setup data type
bit = 64;
fracbit = 53;
T = mytypes('fixed',bit,fracbit);
%T = mytypes('wfixed',bit,fracbit);
% Do a GCD with fixed point
Afp = cast(A,'like',T);
bfp = cast(b,'like',T);
Xfp = cgdfp7(Afp,bfp,it,T);
Xfp2db = double(Xfp);
err = sqrt(sum((double(Xfp) - z*ones(1,it)).^2,1));
plot(log10(err));

%% Setup data type
%bit = 32;
%fracbit = 22;
%T = mytypes('fixed',bit,fracbit);
%% Do a GCD with fixed point
%Afp = cast(A,'like',T);
%bfp = cast(b,'like',T);
%Xfp = cgdfp2(Afp,bfp,it,T);
%Xfp2db = double(Xfp);
%err = sqrt(sum((double(Xfp) - z*ones(1,it)).^2,1));
%plot(log10(err));

