Lf = 4; %fore
Lw = 10; %wake
R = 1; %outer distance of cylinder
H = 4; %height top/bottom
D = 1; %diameter of cylinder
index = 0:63; index = index';

%% Vertices
vertex = [0.5, 0; %cylinder index points 0-7
          sqrt(2)/4, sqrt(2)/4, 
          0, 0.5; 
          -sqrt(2)/4, sqrt(2)/4;
          -0.5, 0;
          -sqrt(2)/4, -sqrt(2)/4;
          0, -0.5;                  
          sqrt(2)/4, -sqrt(2)/4;
          0.5+R, 0; %outer cylinder index points 8-15
          cosd(45)*(0.5+R), cosd(45)*(0.5+R);
          0, 0.5+R;
          -cosd(45)*(0.5+R), cosd(45)*(0.5+R);
          -(0.5+R), 0;
          -cosd(45)*(0.5+R), -cosd(45)*(0.5+R);
          0, -(0.5+R);
          cosd(45)*(0.5+R), -cosd(45)*(0.5+R)
          Lw, 0;
          Lw, cosd(45)*(0.5+R);
          Lw, H;
          cosd(45)*(0.5+R), H;
          0, H;
          -cosd(45)*(0.5+R), H;
          -Lf, H;
          -Lf, cosd(45)*(0.5+R);
          -Lf, 0;
          -Lf, -cosd(45)*(0.5+R);
          -Lf, -H;
          -cosd(45)*(0.5+R), -H;
          0, -H;
          cosd(45)*(0.5+R), -H;
          Lw, -H;
          Lw, -cosd(45)*(0.5+R)];
vertex(:,3) = -5e-2;
for i = 1:32
    vertex(i+32,:) = vertex(i,:);
end
vertex(33:64,3) = 5e-2;

%% blocks use same as in blockMeshDict.example
% hex(:,1) = 0:7;
% hex(:,2) = 8:15;
% hex(:,3) = 9:16; hex(8,3) = 8;
% hex(:,4) = 1:8; hex(8,4) = 0;

% change # of cells in each local direction
% changes made to blockMeshDict.template

%% Edges (arc midpoint)
% arcs col 1&2 are local coordinates, col 3,4,5 are x,y,z
arc =  [0, 1, cosd(22.5)*0.5, sind(22.5)*0.5, -5e-2;
        8, 9, cosd(22.5)*(0.5+R), sind(22.5)*(0.5+R), -5e-2;
        32, 33, cosd(22.5)*0.5, sind(22.5)*0.5, 5e-2;
        40, 41, cosd(22.5)*(0.5+R), sind(22.5)*(0.5+R), 5e-2;
        1, 2, cosd(67.5)*0.5, sind(67.5)*0.5, -5e-2;
        9, 10, cosd(67.5)*(0.5+R), sind(67.5)*(0.5+R), -5e-2;
        33, 34, cosd(67.5)*0.5, sind(67.5)*0.5, 5e-2;
        41, 42, cosd(67.5)*(0.5+R), sind(67.5)*(0.5+R), 5e-2;
        2, 3, cosd(112.5)*0.5, sind(112.5)*0.5, -5e-2;
        10, 11, cosd(112.5)*(0.5+R), sind(112.5)*(0.5+R), -5e-2;
        34, 35, cosd(112.5)*0.5, sind(112.5)*0.5, 5e-2;
        42, 43, cosd(112.5)*(0.5+R), sind(112.5)*(0.5+R), 5e-2;
        3, 4, cosd(157.5)*0.5, sind(157.5)*0.5, -5e-2;
        11, 12, cosd(157.5)*(0.5+R), sind(157.5)*(0.5+R), -5e-2;
        35, 36, cosd(157.5)*0.5, sind(157.5)*0.5, 5e-2;
        43, 44, cosd(157.5)*(0.5+R), sind(157.5)*(0.5+R), 5e-2;
        4, 5, cosd(202.5)*0.5, sind(202.5)*0.5, -5e-2;
        12, 13, cosd(202.5)*(0.5+R), sind(202.5)*(0.5+R), -5e-2;
        36, 37, cosd(202.5)*0.5, sind(202.5)*0.5, 5e-2;
        44, 45, cosd(202.5)*(0.5+R), sind(202.5)*(0.5+R), 5e-2;
        5, 6, cosd(247.5)*0.5, sind(247.5)*0.5, -5e-2;
        13, 14, cosd(247.5)*(0.5+R), sind(247.5)*(0.5+R), -5e-2;
        37, 38, cosd(247.5)*0.5, sind(247.5)*0.5, 5e-2;
        45, 46, cosd(247.5)*(0.5+R), sind(247.5)*(0.5+R), 5e-2;
        6, 7, cosd(292.5)*0.5, sind(292.5)*0.5, -5e-2;
        14, 15, cosd(292.5)*(0.5+R), sind(292.5)*(0.5+R), -5e-2;
        38, 39, cosd(292.5)*0.5, sind(292.5)*0.5, 5e-2;
        46, 47, cosd(292.5)*(0.5+R), sind(292.5)*(0.5+R), 5e-2;
        7, 0, cosd(337.5)*0.5, sind(337.5)*0.5, -5e-2;
        15, 8, cosd(337.5)*(0.5+R), sind(337.5)*(0.5+R), -5e-2;
        39, 32, cosd(337.5)*0.5, sind(337.5)*0.5, 5e-2;
        47, 40, cosd(337.5)*(0.5+R), sind(337.5)*(0.5+R), 5e-2];

%% Boundary Faces
% same as blockMeshDict


