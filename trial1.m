

Nx = 11;
Nt = 500;
u = zeros(Nt,Nx);
mid = Nx/2;
L = 1000;
dx = L/(Nx-1);
dt = 0.0001;
u(1,51) = 1.0/dx;
C = 1.0;
D = 1.0;

const_part_A = D*dt/(dx.^2);
const_part_B = C*dt;

for i = 2:Nt
  u(i,1)=0.0;
  u(i,Nx)=0.0;
  for j = 2:(Nx-1)
    var1 = const_part_A*(u(i-1,j+1) - 2*u(i-1,j) + u(i-1,j-1));
    var2 = const_part_B*u(i-1,j);
    u(i,j) = u(i-1,j) + var1 + var2;
  end
end

#disp(u(50,35:65))
disp(((u(500,50) - u(499,50))) / (u(500,50))) # Provides an idea of whether u is still changing
disp('~~~~~~~~~~~~~~~~~~~~~~~')
disp(u(20,50))  
disp(u(100,50))
disp(u(450,50))   # These provide an idea of whether u is blowing up or shrinking to nothing over time
disp(u(500,50))

