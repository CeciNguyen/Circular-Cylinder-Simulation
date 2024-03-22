% Import data
folder1 = "/Users/grantkitlowski/Documents/github/Circular-Cylinder-Simulation/Part 5 Steady Flow/20-mesh-1/postProcessing/singleGraph/20/";
folder2 = "/Users/grantkitlowski/Documents/github/Circular-Cylinder-Simulation/Part 5 Steady Flow/20-mesh-2/postProcessing/singleGraph/100/";
folder3 = "/Users/grantkitlowski/Documents/github/Circular-Cylinder-Simulation/Part 5 Steady Flow/20-mesh-3/postProcessing/singleGraph/100/";
folder4 = "/Users/grantkitlowski/Documents/github/Circular-Cylinder-Simulation/Part 5 Steady Flow/20-mesh-4/postProcessing/singleGraph/100/";


[sp1, usp1, thp1] = PlotVelocities(folder1);
[sp2, usp2, thp2] = PlotVelocities(folder2);
[sp3, usp3, thp3] = PlotVelocities(folder3);
[sp4, usp4, thp4] = PlotVelocities(folder4);


figure;
plot(sp1, usp1);
hold on;
plot(sp2, usp2);
plot(sp3, usp3);
plot(sp4, usp4);
xlabel('Distance from the wall');
ylabel('Radial Velocity');
title('Radial Velocity Profile at pi/4, pi/2, 3pi/4');
legend('pi/4', 'pi/2', '3pi/4');
hold off;

figure;
plot(sp1, thp1);
hold on;
plot(sp2, thp2);
plot(sp3, thp3);
plot(sp4, thp4);
xlabel('Distance from the wall');
ylabel('Tangential Velocity');
title('Tangential Velocity Profile at pi/4, pi/2, 3pi/4');
legend('pi/4', 'pi/2', '3pi/4');
hold off;

function S = S(x,y)
    S = sqrt(x.^2 + y.^2);
end


function U_theta = U_theta(Ux,Uy,theta)
    U_theta = -Ux.*sin(theta) + Uy.*cos(theta);
end

function U_r = r(Ux,Uy,theta)
    U_r = Ux.*cos(theta) + Uy.*sin(theta);
end


function strainNorm = TensorNorm(r, matrix)
    
    r1 = sqrt(matrix(1,1)^2 + matrix(1,2)^2);
    r2 = sqrt(matrix(2,1)^2 + matrix(2,2)^2);
    r3 = sqrt(matrix(3,1)^2 + matrix(3,2)^2);
    
    er1 = (r(2,1)-r(1,1))/(r2 - r1);
    er2 = (r(3,1)-r(2,1))/(r3 - r2);
    
    strainNorm = (er1 + er2)/2; 
end

function strainTang = TensorTang(t, matrix)

    r1 = sqrt(matrix(1,1)^2 + matrix(1,2)^2);
    r2 = sqrt(matrix(2,1)^2 + matrix(2,2)^2);
    r3 = sqrt(matrix(3,1)^2 + matrix(3,2)^2);
    
    et1 = (r1 + r2) / 4 * (t(2,1)/r2 -t(1,1)/r1)/(r2 - r1);
    et2 = (r2 + r3) / 4 * (t(3,1)/r3 -t(2,1)/r2)/(r3 - r2);
    
    strainTang = (et1 + et2)/2;
end

function [sp, usp, thp] = PlotVelocities(folder)
    pie_4 = importdata(folder + "line1_U.xy");

    % Extract data for pi/4 line
    pie_4x = pie_4(:, 1);
    pie_4y = pie_4(:, 2);
    pie_4Ux = pie_4(:, 4);
    pie_4Vy = pie_4(:, 5);

    % obtain the difference between the cylinder and the wall
    sp = S(pie_4x,pie_4y);
    usp = r(pie_4Ux, pie_4Vy,pi/4);
    thp = U_theta(pie_4Ux, pie_4Vy,pi/4);
end