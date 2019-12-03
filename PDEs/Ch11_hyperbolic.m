%% Define a 1D space and time grid in x,t for a test problem
lx=64;
a=0;     %here a,b are the endpoints of the x-domain
b=1;     %use a square region for a test problem
x=linspace(a,b,lx);
dx=x(2)-x(1);        %grid spacing
dt=0.01;              %time step
t=0:dt:10;
lt=numel(t);


%% Paramters of the PDE
v=1;    %velocity of wave propagation
CFL=v*dt/dx;


%% Set the initial conditions
x0=1/2*(a+b);
sigx=1/15*(b-a);
finitial=exp(-(x-x0).^2/2/sigx^2);

figure(1);
plot(x,finitial);
xlabel('x');
ylabel('f(x,t_0)');


%% Analytical solution
% fexact=zeros(lx,lt);
% fexact(:,1)=finitial;
% 
% for n=1:lt-1
%     for i=1:lx
%       xloc=mod(x0+v*t(n),b);
%       fexact(i,n+1)=exp(-(x(i)-xloc).^2/2/sigx^2);
%     end %for
%     
%     plot(x,fexact(:,n));
%     xlabel('x');
%     ylabel('f(x,t)');
%     title('Exact')
%     pause(0.1);
% end %for


%% FTCS method (will be unstable)
figure(2);

fFTCS=zeros(lx,lt);
fFTCS(:,1)=finitial;

%ghost cell values for implementing boundary conditions
fleft=zeros(2,1);
fright=zeros(2,1);

for n=1:lt-1
    fleft=fFTCS(lx-1:lx,n);    %ghost cells here implement periodic boundary conditions
    fright=fFTCS(1:2,n);
    
    fFTCS(1,n+1)=fFTCS(1,n)+dt/2/dx*v*(fFTCS(2,n)-fleft(2));
    for i=2:lx-1     %interior grid points
        fFTCS(i,n+1)=fFTCS(i,n)+dt/2/dx*v*(fFTCS(i+1,n)-fFTCS(i-1,n));
    end %for
    fFTCS(lx,n+1)=fFTCS(lx,n)+dt/2/dx*v*(fright(1)-fFTCS(lx-1,n));
    
    plot(x,fFTCS(:,n));
    xlabel('x');
    ylabel('f(x,t)');
    title('FTCS')
    pause(0.1);
end %for



%% Upwinding and Godunov's method


%% Lax-Friedrich's method


%% Lax-Wendroff


%% Problems with implicit approaches to waves

