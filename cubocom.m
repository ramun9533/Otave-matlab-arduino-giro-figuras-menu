clear
clc
pkg load arduino
board = arduino("/dev/ttyUSB1"); %solo para linux se usa esta direccion /dev/ttyUSB0
 %Crear una figura vacía
figure;
t = linspace(0,1,100)
% Definir los vértices del cubo
vertices = [1 1 1; -1 1 1; -1 -1 1; 1 -1 1; 1 1 -1; -1 1 -1; -1 -1 -1; 1 -1 -1];

% Definir las caras del cubo (índices de los vértices)
caras = [1 2 3 4; 1 2 6 5; 2 3 7 6; 3 4 8 7; 4 1 5 8; 5 6 7 8];
colores = [ 1 0 0;  % rojo
 0 1 0;  % verde
 0 0 1;  % azul
 1 1 0;  % amarillo
 1 0 1;  % magenta
 0 1 1 ];  % cian
% Definir el ángulo de rotación del cubo
theta = 0;
%v = readAnalogPin(board, "A1");
% Dibujar el cubo
%while true
for idx=1:400
   % Rotar el cubo
   v = readAnalogPin(board, "A1");
   k= v*0.01024;
  theta = k; %Variable de giro
  R = [cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];
  vertices_rotados = vertices * R;

  % Dibujar el cubo
  clf;
  %patch('Vertices', vertices_rotados, 'Faces', caras, 'FaceColor', 'g', 'EdgeColor', 'k');
  patch('Vertices',  vertices_rotados, 'Faces', caras(1,:), 'FaceColor', colores(1,:));
  patch('Vertices',  vertices_rotados, 'Faces', caras(2,:), 'FaceColor', colores(2,:));
  patch('Vertices',  vertices_rotados, 'Faces', caras(3,:), 'FaceColor', colores(3,:));
  patch('Vertices', vertices_rotados, 'Faces', caras(4,:), 'FaceColor', colores(4,:));
  patch('Vertices', vertices_rotados, 'Faces', caras(5,:), 'FaceColor', colores(5,:));
  patch('Vertices', vertices_rotados, 'Faces', caras(6,:), 'FaceColor', colores(6,:));

% Configura la vista del cubo
  axis([-4 4 -4 4 -4 4]);
  view(3);
  xlabel('Eje-X')
  ylabel('Eje-Y')
  zlabel('Eje-Z')
  drawnow;
end
