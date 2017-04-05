function APP = adaptive2(funcname, a, b, TOL, MAXINT)
  %APP = feval(funcname,1234); %placeholder til function is built, use feval rather
                               %than @ handle due to being messy in Octave
                               
                               
  % NOTE: v1,v2, ..., v8 aren't used, instead the values they are meant to
  % hold will be assigned to the first element of the variables they represent
  % (these variables have been made into arrays; 2nd element holds most up-to-date value, 1st
  % holds the previous value)
  
  APP = 0;
  i = 1;
  TOLi = [0, 10*TOL];
  ai = [0, a];
  hi = [0, ((b-a)*0.5)]; % Initial step size half of full width
  
  % Initial approximation Start
  FAi = [0, func_one(ai(2))];
  FBi = [0, func_one(b)];
  FCi = [0, func_one(ai(2)+hi(2))];
  Si = [0, hi(2)*(FAi(2) + 4*FCi(2) + FBi(2))*(1.0/3.0)];
  % Initial approximation End
  
  Li = [0,1];
  while(i>0)
    disp(APP);
    FD = func_one((ai(2) +(hi(2)*0.5)));
    FE = func_one((ai(2) + 3.0*(hi(2)*0.5)));
    S1 = hi(2)*(1.0/6.0)*(FAi(2) + 4*FD + FCi(2));
    S2 = hi(2)*(1.0/6.0)*(FCi(2) + 4*FE + FBi(2));
    ai(1)=ai(2); FAi(1)=FAi(2); FBi(1)=FBi(2); FCi(1)=FCi(2); hi(1)=hi(2); TOLi(1)=TOLi(2); Si(1)=Si(2); Li(1)=Li(2);
    % The above is an unrolled for-loop as matlab is a ridiculous language that shouldnt exist
    i = i-1;  % Remove current level
    if (abs(S1+S2-Si(1))<TOLi(1))
      APP = APP + (S1+S2);
    else
      if (Li(1)>=MAXINT)
        disp('shits fucked yo')
        error('MAXINT exceeded without achieving tolerance');
      else
        i = i+1;
        ai(2) = ai(1) + hi(1);
        FAi(2) = FCi(1);
        FCi(2) = FE;
        FBi(2) = FBi(1);
        hi(2) = hi(1)*0.5;
        TOLi(2) = TOLi(1)*0.5;
        Si(2) = S2;
        Li(2) = Li(1) + 1;
        i = i+1;
        ai(2) = FCi(1);
        FAi(2) = FAi(1);
        FCi(2) = FD;
        FBi(2) = FCi(1);
        Si(2) = S1;
        Li(2) = Li(1);
      end
    end
  end
end