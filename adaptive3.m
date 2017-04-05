function APP = adaptive3(funcname, a, b, TOL, MAXINT)
  %APP = feval(funcname,1234); %placeholder til function is built, use feval rather
                               %than @ handle due to being messy in Octave
                               
  
  APP = 0;
  i = 1;
  TOLi = [];
  TOLi(1) = 10*TOL;
  ai = [];
  ai(1) = a;
  hi = [];
  hi(1) = ((b-a)*0.5); % Initial step size half of full width
  
  % Initial approximation Start
  FAi = [];
  FBi = [];
  FCi = [];
  Si = [];
  Li = [];
  FAi(1) = func_two(ai(end));
  FBi(1) = func_two(b);
  FCi(1) = func_two(ai(end)+hi(end));
  Si(1) = hi(end) *(FAi(end) + 4*FCi(end) + FBi(end))*(1.0/3.0);
  % Initial approximation End
  Li(1) = 1;
  
  while(i>0)
    FD = func_two((ai(i) +(hi(i)*0.5)));
    FE = func_two((ai(i) + 3.0*(hi(i) *0.5)));
    S1 = hi(i)*(1.0/6.0)*(FAi(i) + 4*FD + FCi(i));
    S2 = hi(i)*(1.0/6.0)*(FCi(i) + 4*FE + FBi(i));
    v1=ai(i) ; v2=FAi(i) ; v4=FBi(i) ; v3 =FCi(i) ; v5=hi(i) ; v6=TOLi(i) ; v7=Si(i) ; v8=Li(i) ;
    
    
    i = i-1;  % Remove current level
    %disp(APP);
    if (abs(S1+S2-v7)<v6)
      APP = APP + (S1+S2);
    else
      if (v8>=MAXINT)
        disp('shits fucked yo');
        error('MAXINT exceeded without achieving tolerance');
      else
      
        i = i+1;
        
        ai(i) = v1 + v5;
        FAi(i) = v3;
        FCi(i) = FE;
        FBi(i) = v4;
        hi(i) = v5*0.5;
        TOLi(i) = v6*0.5;
        Si(i) = S2;
        Li(i) = v8 + 1;
        
        i = i+1;
        
        ai(i) = v1;
        FAi(i) = v2;
        FCi(i) = FD;
        FBi(i) = v3;
        hi(i) = hi(i-1);
        TOLi(i) = TOLi(i-1);
        Si(i) = S1;
        Li(i) = Li(i-1);
      end
    end
  end
end