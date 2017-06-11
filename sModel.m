function [ sys,state0,str,ts ] = sModel( t,state,u,flag,h,modelSel)
    switch flag
        case 0
            s = simsizes;
            s.NumContStates  = 0;  
            s.NumDiscStates  = 4;
            s.NumOutputs     = 4;   
            s.NumInputs      = 1;   
            s.DirFeedthrough = 0;
            s.NumSampleTimes = 1; 
            sys = simsizes(s);

            str = [];
            ts = [h 0];   
        case 2
            M = 0.5; % masa wozka
            m = 0.2; % masa wahadla
            L = 0.3; % dlugosc od mocowania do srodka ciezkosci wahadla
            I = 0.006; % moment bezwladnosci wahadla
            b = 0.1; % wspolczynnik tarcia wozka
            g = 9.81; % przyspieszenie ziemskie
            F = u(1); % sila przylozona do wozka
            
            thetaDot = state(1);
            theta = state(2);
            xDot = state(3);
            x = state(4);
            
            stateDot = zeros(4,1);
                 
            if (strcmp(modelSel,'full'))
                sTheta = sin(theta);
                cTheta = cos(theta);

                q = m^2 * L^2 * cTheta^2 - (I + m * L^2) * (M + m);
                stateDot(1) = (F * m * L * cTheta - b * m * L * cTheta * xDot - (M + m) * m * L * g * sTheta + m^2 * L^2 * sTheta * cTheta * thetaDot^2) / q;
                stateDot(2) = thetaDot;
                stateDot(3) = ((I + m * L^2) * (-F + b * xDot - m * L * sTheta * thetaDot^2) + m^2 * L^2 * g * sTheta * cTheta) / q;
                stateDot(4) = xDot;
            else
                A = [0, g * (M + m) / (M * L), b / (M * L), 0;
                    1, 0, 0, 0;
                    0, -g * m / M, -b / M, 0;
                    0, 0, 1, 0];
                B = [-1/(M * L);
                    0;
                    1/M;
                    0];
                stateDot = A * state + B * u(1);
            end
            sys = state + h * stateDot;
        case 3
            sys = state; % wyjsciem jest stan     
        case {1,4,9}
            sys = []; 
        otherwise
            error(['unhandled flag = ',num2str(flag)]);
    end
end

