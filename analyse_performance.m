function [accuracies,evals] = analyse_performance(integrate_function, func_name, max_accuracy_exponent, x_range_start, x_range_end, max_int)

  accuracies = []; evals=[];
  for i = 1:max_accuracy_exponent
    accuracies(i) = 10^-i;
  end

  for i = 1:max_accuracy_exponent
    [a,b,c,d] = integrate_function(func_name, x_range_start, x_range_end, accuracies(i), max_int);
    % Note: assumes integrate_function returns [APP, eval_count, xpt, fx]
    evals(i) = b;
  end
end
