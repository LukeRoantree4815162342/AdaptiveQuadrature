function [APP, eval_count, xpt, fx] = adaptive(func_names, a, b, TOL, N)  %#1
    format long   %#2
    eval_count = 0; i=1; APP = 0; 
    
    TOL_mat(i) = 10*TOL;
    h(i) = (b-a(i))/2;   
    
    FA = func_names(a(i));
    FB = func_names(b);
    FC = func_names(a(i) + h(i));
    S = h(i)*(FA(i) + (4*FC(i)) + FB(i))/3; %#3
    
    iter = 1;
    eval_count = eval_count + 3;
    
    xpt = b; xpt(eval_count-1) = a(i) + h(i); xpt(eval_count) = a(i); 
    fx = FB; fx(eval_count-1) = FC; fx(eval_count) = FA;

    while i>0
        
        FD = func_names(a(i)+(h(i)/2));
        FE = func_names(a(i)+3*(h(i)/2));
        S1 = h(i)*(FA(i)+4*FD + FC(i))/6; %#4a
        S2 = h(i)*(FC(i) + 4*FE + FB(i))/6; %#4b
        eval_count = eval_count + 2;
        xpt(eval_count-1) = a(i)+(h(i)/2); xpt(eval_count) = a(i)+3*(h(i)/2);
        fx(eval_count-1) = FD; fx(eval_count) = FE;
        
        v1 = a(i); v2 = FA(i); v3 = FB(i); v4 = FC(i); v5 = h(i); v6 = TOL_mat(i); v7 = S(i); v8 = iter(i);
        i = i-1;
           
        if (abs(S2+S1-v7) < v6);  %#5
            APP = APP + (S2 + S1); 
        
        else
        
            if v8 > N
                disp('Level Exceeded');
            break
            
            else  %#6
                i=i+1; 
                a(i) = v1 + v5; 
                FA(i) = v4;
                FC(i) = FE;
                FB(i) = v3;
                h(i) = v5/2;
                TOL_mat(i)= v6/2;
                S(i) = S2;
                iter(i) = v8 + 1;
                
                i=i+1; 
                a(i) = v1;
                FA(i) = v2;
                FC(i) = FD;
                FB(i) = v4;
                h(i) = h(i-1);
                TOL_mat(i) = TOL_mat(i-1);
                S(i) = S1;
                iter(i) = iter(i-1);  
            end
        end
    end
        
    [xnew, ind] = sort(xpt);
    ynew = fx(ind);
    xpt = xnew;
    fx = ynew;
end

