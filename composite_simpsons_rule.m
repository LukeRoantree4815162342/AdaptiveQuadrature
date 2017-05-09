function [APP, eval_count, xpt, fx] = composite_simpsons_rule(func_name, a, b, TOL, N)
  h = b-a;
  n = 2;
  iterouter = 1;
  XI0 = func_name(a)+func_name(b); XI=0; eval_count = 2;
  while (length(XI) < 2) || (abs(XI(iterouter-1)-XI(iterouter-2))>TOL)
    if iterouter >= N
      disp("Max iteration exceeded")
    end
    XI1(iterouter) = 0; XI2(iterouter) = 0; XI(iterouter) = 0;
    for iter = 1:(n-1)
      X = a + iter*h/n;
      if mod(iter,2)==0
        XI2(iterouter) = XI2(iterouter) + func_name(X);
      else
        XI1(iterouter) = XI1(iterouter) + func_name(X);
      end
    end
    eval_count = eval_count + (n-1);
    XI(iterouter) = (h/n)*(XI0 + 2*XI2(iterouter) + 4*XI1(iterouter))/3.0;
    iterouter = iterouter + 1;
    n = n*2;
  end
  APP=XI(end);
  xpt = linspace(a,b,n);
  fx = func_name(xpt);
end
  

  
    
    