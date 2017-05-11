function y = func_two(x)
  for i = 1:length(x)
    y(i) = sin(1/x(i));
  end
end