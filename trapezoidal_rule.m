function [APP, eval_count, xpt, fx] = trapezoidal_rule(func_name, a, b, TOL, N)
  h = b-a;
  APP1 = (h/2.0)*(func_name(a) + func_name(b));  % one trapezium
  h = h/2.0;
  APP1(2) = (h/2.0)*(func_name(a) + func_name(b)) + h*func_name(a+h);   % two trapezia
  eval_count = 5;
  i = 1; iter = 0; num_traps = 0; APP = 0;
  while abs(APP1(i+1) - APP1(i)) > TOL  % continue until approximation accurate enough
    if iter >= N
      disp("Max iteration exceeded");
      break;
    end
    i = i + 1;
    h = h/2.0;
    num_traps = (2^(i))-1;
    APP1(i+1) = (h/2.0)*(func_name(a) + func_name(b));
    for j = 1:(num_traps - 1)
      APP1(i+1) = APP1(i+1) + h*func_name(a+j*h);
    end
    eval_count = eval_count + num_traps + 1;
    iter = iter + 1;
  end
  APP = APP1(i+1);
  xpt = linspace(a,b,num_traps);
  fx = func_name(xpt);
end
  
    
    