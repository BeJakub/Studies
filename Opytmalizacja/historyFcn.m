function [x fval history] = historyFcn(x0)
    history = [];
    options = optimset('OutputFcn', @myoutput, 'Display','iter', 'TolFun',1e-8,'TolX',1e-8,'PlotFcns',@optimplotfval);
    [x fval] = fminsearch(@objfun, x0,options);   
    function stop = myoutput(x,optimvalues,state);
        stop = false;
        if isequal(state,'iter')
          history = [history; x];
        end
    end
    
    function z = objfun(x)
      z = 2*x(1)^2-1.05*x(1)^4+x(1)^6/6+x(1)*x(2)+x(2)^2;
    end
end