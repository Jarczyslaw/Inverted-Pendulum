% funkcja wykonywania przy kazdym tyknieciu timera
function timerFcn( obj,event,s,theta)
    i = get(obj,'TasksExecuted'); % aktualna iteracja
    deltaT = get(obj,'Period'); % okres pomiedzy kolejnymi tyknieciami
    % wyciagamy globalny wozek, przesuwamy go i obracamy do wartosci z
    % symulacji
    global c; 
    c = c.move(s(i));
    c = c.rotate(theta(i));
    
    drawnow;
    
    % generowanie gifa na podstawie narysowanych klatek animacji
%     filename = 'anim.gif';
%     frame = getframe(gcf);
%     im = frame2im(frame);
%     [imind,cm] = rgb2ind(im,256);
%     if (i == 1)
%         imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',deltaT);
%     else
%         imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',deltaT);
%     end
end

