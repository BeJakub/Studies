function [x fval history] = myproblem(x0)
    history = [];
    options = optimset('OutputFcn', @myoutput);
    [x fval] = fminsearch(@objfun, x0,options);
        
    function stop = myoutput(x,optimvalues,state);
        stop = false;
        if isequal(state,'iter')
          history = [history; x];
        end
    end
    
    function z = objfun(x)
      z = x(1)^2 + x(1)*x(2) + 0.5*x(2)^2 - x(1) - x(2);
    end
end