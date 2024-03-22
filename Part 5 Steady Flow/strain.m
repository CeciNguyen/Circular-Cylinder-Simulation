clear all;

folder = "/Users/grantkitlowski/Documents/github/Circular-Cylinder-Simulation/Part 5 Steady Flow/20-mesh-4/postProcessing/singleGraph/100/";
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

r1 = sqrt(pie_4x.^2 + pie_4y.^2 + pie_4z.^2);
r2 = sqrt(pie_2x.^2 + pie_2y.^2 + pie_2z.^2);
r3 = sqrt(pie3_4x.^2 + pie3_4y.^2 + pie3_4z.^2);

V1 = sqrt(pie_4Ux.^2 + pie_4Vy.^2 + pie_4Wz.^2);
V2 = sqrt(pie_2Ux.^2 + pie_2Vy.^2 + pie_2Wz.^2);
V3 = sqrt(pie3_4Ux.^2 + pie3_4Vy.^2 + pie3_4Wz.^2);

t1 = atan(pie_4y ./ pie_4x);
t2 = atan(pie_2y ./ pie_2x);
t3 = atan(pie3_4y ./ pie3_4x);


dudr1 = getStrainRateTensorAtWall(pie_4Ux, pie_4Vy, r1);
du_dr_wall1 = dudr1{1}(1);
[u1_1, u1_2] = getU12(du_dr_wall1, r1);
[du1, dur1] = calcStrain(r1, u1_1, u1_2);

dudr2 = getStrainRateTensorAtWall(pie_2Ux, pie_2Vy, r2);
du_dr_wall2 = dudr2{1}(1);
[u2_1, u2_2] = getU12(du_dr_wall2, r2);
[du2, dur2] = calcStrain(r2, u2_1, u2_2);

dudr3 = getStrainRateTensorAtWall(pie3_4Ux, pie3_4Vy, r3);
du_dr_wall3 = dudr3{1}(1);
[u3_1, u3_2] = getU12(du_dr_wall3, r3);
[du3, dur3] = calcStrain(r3, u3_1, u3_2);

disp("err1: " + du1);
disp("er02: " + dur1);
disp("err2: " + du2);
disp("er02: " + dur2);
disp("err3: " + du3);
disp("er02: " + dur3);



function [u1, u2] = getU12(dudr, r)
    del_r1_1 = r(1) - 0.5;
    del_r2_1 = r(end) - 0.5;
    u1 = del_r1_1 * dudr + ((del_r1_1 * dudr) ^ 2) / 2;
    u2 = del_r2_1 * dudr + ((del_r2_1 * dudr) ^ 2) / 2;
end

function [du_dr, dur_dr] = calcStrain(r, u1_1, u1_2)
    del_r1_1 = r(1) - 0.5;
    del_r2_1 = r(end) - 0.5;

    du_dr = ((u1_1*del_r2_1) / (del_r1_1*(del_r2_1 - del_r1_1))) + ((u1_2*del_r1_1) / (del_r2_1*(del_r1_1 - del_r2_1))) - 0.06;

    dur_dr = 0.25 * (((u1_1*del_r2_1) / (r(1) * del_r1_1*(del_r2_1 - del_r1_1))) + ((u1_2*del_r1_1) / (r(end) * del_r2_1*(del_r1_1 - del_r2_1)))) - 0.06;
end


function strain_rate_tensor = getStrainRateTensorAtWall(velocities_x, velocities_y, radii)

    num_points = length(velocities_x);
    strain_rate_tensor = cell(1, num_points);
  
    for i = 1:num_points
      velocity_x = velocities_x(i);
      velocity_y = velocities_y(i);
      radius = (radii(1) - 0.5) - (radii(end) - 0.5);
      
      % Combine x and y components into a 2D vector
      velocity = [velocity_x, velocity_y];
      
      % Velocity gradient
      velocity_gradient = [gradient(velocity(1,:))/radius, ...
                           gradient(velocity(:,2))/radius];
                       
      % Isolate symmetric part (strain rate tensor)
      strain_rate_tensor{i} = 0.5 * (velocity_gradient + velocity_gradient');
    end
  end
  