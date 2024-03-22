clear all;

folder1 = "/Users/grantkitlowski/Documents/github/Circular-Cylinder-Simulation/Part 5 Steady Flow/20-mesh-1/postProcessing/singleGraph/20/";
folder2 = "/Users/grantkitlowski/Documents/github/Circular-Cylinder-Simulation/Part 5 Steady Flow/20-mesh-2/postProcessing/singleGraph/100/";
folder3 = "/Users/grantkitlowski/Documents/github/Circular-Cylinder-Simulation/Part 5 Steady Flow/20-mesh-3/postProcessing/singleGraph/100/";
folder4 = "/Users/grantkitlowski/Documents/github/Circular-Cylinder-Simulation/Part 5 Steady Flow/20-mesh-4/postProcessing/singleGraph/100/";

[du4, dur4, du2, dur2, du34, dur34] = getStrains(folder1);
[du4_2, dur4_2, du2_2, dur2_2, du34_2, dur34_2] = getStrains(folder2);
[du4_3, dur4_3, du2_3, dur2_3, du34_3, dur34_3] = getStrains(folder3);
[du4_4, dur4_4, du2_4, dur2_4, du34_4, dur34_4] = getStrains(folder4);
del1 = 1/20;
del2 = 1/40;
del3 = 1.5/20;
del4 = 1.5/40;

figure;
plot(sort([del1 del2 del3 del4]), sort([du4 du4_2 du4_3 du4_4]));
hold on;
plot(sort([del1 del2 del3 del4]), sort([du2 du2_2 du2_3 du2_4]));
plot(sort([del1 del2 del3 del4]), sort([du34 du34_2 du34_3 du34_4]));
xlabel('1/del');
ylabel('err');
title('Strain rate tensor at wall, radial');
legend('pi/4', 'pi/2', '3pi/4');
hold off;

figure;
plot(sort([del1 del2 del3 del4]), sort([dur4 dur4_2 dur4_3 dur4_4], "descend"));
hold on;
plot(sort([del1 del2 del3 del4]), sort([dur2 dur2_2 dur2_3 dur2_4], "descend"));
plot(sort([del1 del2 del3 del4]), sort([dur34 dur34_2 dur34_3 dur34_4], "descend"));
xlabel('1/del');
ylabel('er0');
title('Strain rate tensor at wall, tangential');
legend('pi/4', 'pi/2', '3pi/4');
hold off;



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

    dur_dr = 5 *(((u1_1*del_r2_1) / (0.5 * del_r1_1*(del_r2_1 - del_r1_1))) + ((u1_2*del_r1_1) / (1 * del_r2_1*(del_r1_1 - del_r2_1)))) - 3;
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

function [du4, dur4, du2, dur2, du34, dur34] = getStrains(folder)
  pie_4 = importdata(folder + "line1_U.xy");
  pie_2 = importdata(folder + "line2_U.xy");
  pie3_4 = importdata(folder + "line3_U.xy");

  % Extract data for pi/4 line
  pie_4x = pie_4(:, 1);
  pie_4y = pie_4(:, 2);
  pie_4z = pie_4(:, 3);
  pie_4Ux = pie_4(:, 4);
  pie_4Vy = pie_4(:, 5);

  % Extract data for pi/2 line
  pie_2x = pie_2(:, 1);
  pie_2y = pie_2(:, 2);
  pie_2z = pie_2(:, 3);
  pie_2Ux = pie_2(:, 4);
  pie_2Vy = pie_2(:, 5);

  % Extract data for 3pi/4 line
  pie3_4x = pie3_4(:, 1);
  pie3_4y = pie3_4(:, 2);
  pie3_4z = pie3_4(:, 3);
  pie3_4Ux = pie3_4(:, 4);
  pie3_4Vy = pie3_4(:, 5);

  r1 = sqrt(pie_4x.^2 + pie_4y.^2 + pie_4z.^2);
  r2 = sqrt(pie_2x.^2 + pie_2y.^2 + pie_2z.^2);
  r3 = sqrt(pie3_4x.^2 + pie3_4y.^2 + pie3_4z.^2);

  dudr1 = getStrainRateTensorAtWall(pie_4Ux, pie_4Vy, r1);
  du_dr_wall1 = dudr1{1}(1);
  [u1_1, u1_2] = getU12(du_dr_wall1, r1);
  [du4, dur4] = calcStrain(r1, u1_1, u1_2);

  dudr2 = getStrainRateTensorAtWall(pie_2Ux, pie_2Vy, r2);
  du_dr_wall2 = dudr2{1}(1);
  [u2_1, u2_2] = getU12(du_dr_wall2, r2);
  [du2, dur2] = calcStrain(r2, u2_1, u2_2);

  dudr3 = getStrainRateTensorAtWall(pie3_4Ux, pie3_4Vy, r3);
  du_dr_wall3 = dudr3{1}(1);
  [u3_1, u3_2] = getU12(du_dr_wall3, r3);
  [du34, dur34] = calcStrain(r3, u3_1, u3_2);
end
  