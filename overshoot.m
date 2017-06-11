function [ PO, z ] = overshoot( zeta )
    PO = 100 * exp(-zeta * pi / sqrt(1 - zeta^2));
    z = sqrt(log(PO/100)^2/(pi^2+log(PO/100)^2));
end

