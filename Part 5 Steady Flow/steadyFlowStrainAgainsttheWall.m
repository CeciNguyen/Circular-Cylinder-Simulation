% Import data
pie_4M2 = importdata("line1_U_M2.xy");
pie_2M2 = importdata("line2_UM2.xy");
pie3_4M2 = importdata("line3_UM2.xy");

pie_4M3 = importdata("line1_UM3.xy");
pie_2M3 = importdata("line2_UM3.xy");
pie3_4M3 = importdata("line3_UM3.xy");

pie_4M4 = importdata("line1_UM4.xy");
pie_2M4 = importdata("line2_UM4.xy");
pie3_4M4 = importdata("line3_UM4.xy");

% obtain the difference between the cylinder and the wall
spie_4M4 = S(pie_4M4(:,1),pie_4M4(:,2));
spie_2M4 = S(pie_2M4(:,1),pie_2M4(:,2));
spie3_4M4 = S(pie3_4M4(:,1),pie3_4M4(:,2));

spie_4M3 = S(pie_4M3(:,1),pie_4M3(:,2));
spie_2M3 = S(pie_2M3(:,1),pie_2M3(:,2));
spie3_4M3 = S(pie3_4M3(:,1),pie3_4M3(:,2));

spie_4M2 = S(pie_4M2(:,1),pie_4M2(:,2));
spie_2M2 = S(pie_2M2(:,1),pie_2M2(:,2));
spie3_4M = S(pie3_4M2(:,1),pie3_4M2(:,2));

% find the norm angles
% pi/4
Urpie_4M4 = r(pie_4M4,pi/4);
Urpie_4M3 = r(pie_4M3,pi/4);
Urpie_4M2 = r(pie_4M2,pi/4);
% pi/2
Urpie_2M4 = r(pie_2M4,pi/2);
Urpie_2M3 = r(pie_2M3,pi/2);
Urpie_2M2 = r(pie_2M2,pi/2);
% pi3/4
Urpie3_4M4 = r(pie3_4M4,(3*pi)/4);
Urpie3_4M3 = r(pie3_4M3,(3*pi)/4);
Urpie3_4M2 = r(pie3_4M2,(3*pi)/4);

% find the tan angles
% pi/4
Uthetapie_4M4 = U_theta(pie_4M4,pi/4);
Uthetapie_4M3 = U_theta(pie_4M3,pi/4);
Uthetapie_4M2 = U_theta(pie_4M2,pi/4);
% pi/2
Uthetapie_2M4 = U_theta(pie_2M4,pi/2);
Uthetapie_2M3 = U_theta(pie_2M3,pi/2);
Uthetapie_2M2 = U_theta(pie_2M2,pi/2);
% 3pi/4
Uthetapie3_4M4 = U_theta(pie3_4M4,(3*pi)/4);
Uthetapie3_4M3 = U_theta(pie3_4M3,(3*pi)/4);
Uthetapie3_4M2 = U_theta(pie3_4M2,(3*pi)/4);

% solving at the arc
displMat = [.4619 .1913 .9239 .3827];

layBlocks = [10 12 14 15];

% solve for displacement and tensor norms
% layer 4
displM4 = displ(displMat, layBlocks(1), layBlocks(4));
tensorNormpie_4M4 = TensorNorm(Urpie_4M4, pie_4M4);
tensorNormpie_2M4 = TensorNorm(Urpie_2M4, pie_2M4);
tensorNormpie3_4M4 = TensorTang(Urpie3_4M4, pie3_4M4);

tensorTanpie_4M4 = TensorTang(Uthetapie_4M4, pie_4M4);
tensorTanpie_2M4 = TensorTang(Uthetapie_2M4, pie_2M4);
tensorTanpie3_4M4 = TensorTang(Uthetapie3_4M4, pie3_4M4);

% layer 3
displM3 = displ(displMat, layBlocks(1), layBlocks(4));
tensorNormpie_4M3 = TensorNorm(Urpie_4M3, pie_4M3);
tensorNormpie_2M3 = TensorNorm(Urpie_2M3, pie_2M3);
tensorNormpie3_4M3 = TensorTang(Urpie3_4M3, pie3_4M3);

tensorTanpie_4M3 = TensorTang(Uthetapie_4M3, pie_4M3);
tensorTanpie_2M3 = TensorTang(Uthetapie_2M3, pie_2M3);
tensorTanpie3_4M3 = TensorTang(Uthetapie3_4M3, pie3_4M3);

% layer 2
displM2 = displ(displMat, layBlocks(1), layBlocks(3));
tensorNormpie_4M2 = TensorNorm(Urpie_4M2, pie_4M2);
tensorNormpie_2M2 = TensorNorm(Urpie_2M2, pie_2M2);
tensorNormpie3_4M2 = TensorTang(Urpie3_4M2, pie3_4M2);

tensorTanpie_4M2 = TensorTang(Uthetapie_4M2, pie_4M2);
tensorTanpie_2M2 = TensorTang(Uthetapie_2M2, pie_2M2);
tensorTanpie3_4M2 = TensorTang(Uthetapie3_4M2, pie3_4M2);

% solve for radial strain
radStrainpie_4 = [tensorNormpie_4M4, tensorNormpie_4M3, tensorNormpie_4M2];
radStrainpie_2 = [tensorNormpie_2M4,tensorNormpie_2M3, tensorNormpie_2M2];
radStrainpie3_4 = [tensorNormpie3_4M4, tensorNormpie3_4M3, tensorNormpie3_4M2];

tanStrainpie_4 = [tensorTanpie_4M4, tensorTanpie_4M3,tensorTanpie_4M2];
tanStrainpie_2 = [tensorTanpie_2M4, tensorTanpie_2M3,tensorTanpie_2M2];
tanStrainpie3_4 = [tensorTanpie3_4M4, tensorTanpie3_4M3,tensorTanpie3_4M2];

displList = [displM4, displM3, displM2];

figure;
plot(displList, tanStrainpie_4)
hold on;
plot(displList, tanStrainpie_2)
plot(displList, tanStrainpie3_4)
xlabel('1/delta');
ylabel('Strain');
title('Strain Rate r\theta at pi/4, pi/2, 3pi/4');
legend('pi/4', 'pi/2', '3pi/4');

figure;
plot(displList, radStrainpie_4)
hold on;
plot(displList, radStrainpie_2)
plot(displList, radStrainpie3_4)
xlabel('1/delta');
ylabel('Strain');
title('Radial Strain Rate rr at pi/4, pi/2, 3pi/4');
legend('pi/4', 'pi/2', '3pi/4');

figure;
plot(spie_4M4, Urpie_4M4, 'r', DisplayName='\theta= pi/4 Mesh 4');
hold on;
plot(spie_4M3, Urpie_4M3, 'b', DisplayName='\theta= pi/4 Mesh 3');
plot(spie_4M2, Urpie_4M2, 'g', DisplayName='\theta= pi/4 Mesh 2');
xlabel('distance from the wall');
ylabel('Ur');
title('Ur at pi/4');
legend;

figure;
plot(spie_4M4, Uthetapie_4M4, 'r', DisplayName='\theta= pi/4 Mesh 4');
hold on;
plot(spie_4M3, Uthetapie_4M3, 'b', DisplayName='\theta= pi/4 Mesh 3');
plot(spie_4M2, Uthetapie_4M2, 'g', DisplayName='\theta= pi/4 Mesh 2');
xlabel('distance from the wall');
ylabel('U\theta');
title('U\theta at pi/4');
legend;

function S = S(x,y)
    S = sqrt(x.^2 + y.^2);
end


function U_theta = U_theta(matrix,theta)
    U_theta = -matrix(:,4).*sin(theta) + matrix(:,4).*cos(theta);
end

function U_r = r(matrix,theta)
    U_r = matrix(:,4).*cos(theta) + matrix(:,5).*sin(theta);
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

function displ = displ(matrix, lay1, lay2)
    displ = sqrt((matrix(3)-matrix(1)^2+(matrix(4)-matrix(2))^2));
    displ = displ/(lay1+lay2);
    displ2 = displ*2;
    displ = sqrt(displ*displ2);

end