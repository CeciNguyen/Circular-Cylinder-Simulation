% Import data
folder = "/Users/grantkitlowski/Documents/github/Circular-Cylinder-Simulation/Part 5 Steady Flow/20-mesh-2/postProcessing/singleGraph/100/";
pie_4 = importdata(folder + "line1_U.xy");
pie_2 = importdata(folder + "line2_U.xy");
pie3_4 = importdata(folder + "line3_U.xy");

% Extract data for pi/4 line
pie_4x = pie_4(:, 1);
pie_4y = pie_4(:, 2);
pie_4z = pie_4(:, 3);
pie_4Ux = pie_4(:, 4);
pie_4Vy = pie_4(:, 5);
pie_4Wz = pie_4(:, 6);

% Extract data for pi/2 line
pie_2x = pie_2(:, 1);
pie_2y = pie_2(:, 2);
pie_2z = pie_2(:, 3);
pie_2Ux = pie_2(:, 4);
pie_2Vy = pie_2(:, 5);
pie_2Wz = pie_2(:, 6);

% Extract data for 3pi/4 line
pie3_4x = pie3_4(:, 1);
pie3_4y = pie3_4(:, 2);
pie3_4z = pie3_4(:, 3);
pie3_4Ux = pie3_4(:, 4);
pie3_4Vy = pie3_4(:, 5);
pie3_4Wz = pie3_4(:, 6);

% obtain the difference between the cylinder and the wall
spie_4 = S(pie_4x,pie_4y);
spie_2 = S(pie_2x,pie_2y);
spie3_4 = S(pie3_4x,pie3_4y);

% calculate the radial and tangential velocities
Urpie_4 = r(pie_4Ux, pie_4Vy,pi/4);
Uthetapie_4 = U_theta(pie_4Ux, pie_4Vy,pi/4);

Urpie_2 = r(pie_2Ux, pie_2Vy,pi/2);
Uthetapie_2 = U_theta(pie_2Ux, pie_2Vy,pi/2);

Urpie3_4 = r(pie3_4Ux, pie3_4Vy,(pi*3)/4);
Uthetapie3_4 = U_theta(pie3_4Ux, pie3_4Vy,(pi*3)/4);

% find the strain rates
strainNormpie_4 = TensorNorm([Urpie_4, Uthetapie_4], pie_4);
strainTanpie_4 = TensorTang([Urpie_4, Uthetapie_4], pie_4);

strainNormpie_2 = TensorNorm([Urpie_2, Uthetapie_2], pie_2);
strainTanpie_2 = TensorTang([Urpie_2, Uthetapie_2], pie_2);

strainNormpie3_4 = TensorNorm([Urpie3_4, Uthetapie3_4], pie3_4);
strainTanpie3_4 = TensorTang([Urpie3_4, Uthetapie3_4], pie3_4);

figure;
plot(spie_4, Urpie_4);
hold on;
plot(spie_2, Urpie_2);
plot(spie3_4, Urpie3_4);
xlabel('Distance from the wall');
ylabel('Radial Velocity');
title('Radial Velocity Profile at pi/4, pi/2, 3pi/4');
legend('pi/4', 'pi/2', '3pi/4');
hold off;

figure;
plot(spie_4, Uthetapie_4);
hold on;
plot(spie_2, Uthetapie_2);
plot(spie3_4, Uthetapie3_4);
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