close all;
clear;
clc;
pkg load arduino
board = arduino("/dev/ttyUSB1"); %solo para linux se usa esta direccion /dev/ttyUSB0

% Menú
disp("Bienvenido al Menú:");
disp("1. La opción 1 es el cubo");
disp("2. La opción 2 es la piramide");
disp("3. La opción 3 es el tetraedro");
disp("4. La opción 4 elipsoide");
disp("4. La opción 5 vaper");
disp("6. Salir");

opcion = input("Ingrese una opción: ");

% Evaluar la opción seleccionada
switch opcion
    case 1
      disp("Ha seleccionado la Opción 1 Cubo");
                  figure;
              t = linspace(0,1,200);

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

              % Definir los ángulos de rotación del cubo en los ejes X, Y y Z
              theta_x = 0;
              theta_y = 0;
              theta_z = 0;

              % Dibujar el cubo
              while true

                 % Rotar el cubo

                 v = readAnalogPin(board, "A0");%eje
                 v1 = readAnalogPin(board, "A1");%eje
                 v2 = readAnalogPin(board, "A2");%eje
                 clc
                 k= v ;
                 k1= v1 ;
                 k2= v2 ;
                 kDouble = double(k);
                 kDouble1 = double(k1);
                 kDouble2 = double(k2);

                % Rotar el cubo en los ejes X, Y y Z
                theta_x = (kDouble * 0.0062) %theta_x + 0.01; % Ángulo de rotación en el eje X
                theta_y = kDouble1 * 0.0062; %theta_y + 0.02; % Ángulo de rotación en el eje Y
                theta_z = kDouble2 * 0.0062; %theta_z + 0.03; % Ángulo de rotación en el eje Z

                % Matrices de rotación para cada eje
                R_x = [1 0 0; 0 cos(theta_x) -sin(theta_x); 0 sin(theta_x) cos(theta_x)];
                R_y = [cos(theta_y) 0 sin(theta_y); 0 1 0; -sin(theta_y) 0 cos(theta_y)];
                R_z = [cos(theta_z) -sin(theta_z) 0; sin(theta_z) cos(theta_z) 0; 0 0 1];

                % Aplicar rotaciones a los vértices del cubo
                vertices_rotados = vertices * R_x * R_y * R_z;

                % Dibujar el cubo
                clf;
                patch('Vertices',  vertices_rotados, 'Faces', caras(6,:), 'FaceColor', colores(1,:));
                patch('Vertices',  vertices_rotados, 'Faces', caras(2,:), 'FaceColor', colores(2,:));
                patch('Vertices',  vertices_rotados, 'Faces', caras(3,:), 'FaceColor', colores(3,:));
                patch('Vertices', vertices_rotados, 'Faces', caras(4,:), 'FaceColor', colores(4,:));
                patch('Vertices', vertices_rotados, 'Faces', caras(5,:), 'FaceColor', colores(5,:));
                patch('Vertices', vertices_rotados, 'Faces', caras(1,:), 'FaceColor', colores(6,:));
                axis([-4 4 -4 4 -4 4]);
                view(3);
                xlabel('Eje-X');
                ylabel('Eje-Y');
                zlabel('Eje-Z');
                drawnow;
              end
    case 2
        disp("Ha seleccionado la Opción 2 Piramide");
                      vertices = [0 0 0; 1 0 0; 1 1 0; 0 1 0; 0.5 0.5 1];

              % Crear las caras de la pirámide (índices de los vértices)
              caras = [2 3 4; 1 2 5; 2 3 5; 3 4 5; 4 1 5; 1 2 3]; % Agregar una nueva cara para formar el cuadrado en la base

              % Crear las coordenadas de los colores para cada cara
              colores = [1 0 0; 0 1 0; 0 0 1; 1 1 0; 0 1 1; 1 0 0]; % Agregar un color para la nueva cara

              % Mostrar la pirámide
              figure;
              hold on;
              p1 = patch('Vertices', vertices, 'Faces', caras, 'FaceVertexCData', colores, 'FaceColor', 'flat');

              % Definir las caras y vértices adicionales para el parche del cuadrado de la base
              caras_parche = [1 3 4 2]; % Definir las caras del cuadrado
              vertices_parche = vertices(caras_parche, :); % Obtener los vértices correspondientes a las caras del cuadrado

              % Crear las coordenadas de los colores para el parche
              colores_parche = [1 0 0]; % Definir un color para el cuadrado

              p2 = patch('Vertices', vertices_parche, 'Faces', caras_parche, 'FaceVertexCData', colores_parche, 'FaceColor', 'flat');

              axis([-4 4 -4 4 -4 4]);
              xlabel('Eje X');
              ylabel('Eje Y');
              zlabel('Eje Z');
              title('Pirámide en 3D');

              % Definir los ángulos de rotación iniciales en los ejes X, Y y Z
              theta_x = 0;
              theta_y = 0;
              theta_z = 0;

              while true
                   %v0 = readAnalogPin(board, "A0");%botones
                 v = readAnalogPin(board, "A0");%eje
                 v1 = readAnalogPin(board, "A1");%eje
                 v2 = readAnalogPin(board, "A2");%eje
                 clc
                 k= v;
                 k1= v1;
                 k2= v2;
                 kDouble = double(k);
                 kDouble1 = double(k1);
                 kDouble2 = double(k2);
                % Rotar el cubo en los ejes X, Y y Z
                theta_x = (kDouble * 0.0062) %theta_x + 0.01; % Ángulo de rotación en el eje X
                theta_y = kDouble1 * 0.0062; %theta_y + 0.02; % Ángulo de rotación en el eje Y
                theta_z = kDouble2 * 0.0062; %theta_z + 0.03; % Ángulo de rotación en el eje Z

                  % Matrices de rotación para cada eje
                  R_x = [1 0 0; 0 cos(theta_x) -sin(theta_x); 0 sin(theta_x) cos(theta_x)];
                  R_y = [cos(theta_y) 0 sin(theta_y); 0 1 0; -sin(theta_y) 0 cos(theta_y)];
                  R_z = [cos(theta_z) -sin(theta_z) 0; sin(theta_z) cos(theta_z) 0; 0 0 1];

                  % Aplicar rotaciones a los vértices de la pirámide
                  vertices_rotados = vertices * R_x * R_y * R_z;

                  % Aplicar rotaciones a los vértices del parche
                  vertices_parche_rotados = vertices_parche * R_x * R_y * R_z;

                  % Actualizar los vértices de la figura
                  set(p1, 'Vertices', vertices_rotados);

                  % Actualizar los vértices del parche
                  set(p2, 'Vertices', vertices_parche_rotados);

                  % Actualizar la visualización
                  drawnow;
              end

    case 3
        disp("Ha seleccionado la Opción 3 Tetraedro");
            vertices = [0 0 0; 1 0 0; 0.5 1 0; 0.5 0.5 1];

            % Crear las caras de la pirámide (índices de los vértices)
            caras = [1 2 3; 1 3 4; 1 4 2; 2 4 3];

            % Crear las coordenadas de los colores para cada cara
            colores = [1 0 0; 0 1 0; 0 0 1; 1 1 0];

            % Mostrar la pirámide
            figure;
            hold on;
            p = patch('Vertices', vertices, 'Faces', caras, 'FaceVertexCData', colores, 'FaceColor', 'flat');
            axis([-4 4 -4 4 -4 4]);
            xlabel('Eje X');
            ylabel('Eje Y');
            zlabel('Eje Z');
            title('Pirámide en 3D');

            % Definir los ángulos de rotación iniciales en los ejes X, Y y Z
            theta_x = 0;
            theta_y = 0;
            theta_z = 0;

            while true
                 % Rotar el cubo

               v = readAnalogPin(board, "A0");%eje
               v1 = readAnalogPin(board, "A1");%eje
               v2 = readAnalogPin(board, "A2");%eje
               clc

               kDouble = double(v);
               kDouble1 = double(v1);
               kDouble2 = double(v2);

              % Rotar el cubo en los ejes X, Y y Z
              theta_x = (kDouble * 0.0062) %theta_x + 0.01; % Ángulo de rotación en el eje X
              theta_y = kDouble1 * 0.0062; %theta_y + 0.02; % Ángulo de rotación en el eje Y
              theta_z = kDouble2 * 0.0062; %theta_z + 0.03; % Ángulo de rotación en el eje Z

                % Matrices de rotación para cada eje
                R_x = [1 0 0; 0 cos(theta_x) -sin(theta_x); 0 sin(theta_x) cos(theta_x)];
                R_y = [cos(theta_y) 0 sin(theta_y); 0 1 0; -sin(theta_y) 0 cos(theta_y)];
                R_z = [cos(theta_z) -sin(theta_z) 0; sin(theta_z) cos(theta_z) 0; 0 0 1];

                % Aplicar rotaciones a los vértices de la pirámide
                vertices_rotados = vertices * R_x * R_y * R_z;

                % Actualizar los vértices de la figura
                set(p, 'Vertices', vertices_rotados);

                % Actualizar la visualización
                drawnow;
            end
    case 4
        disp("Ha seleccionado la Opción 4 Elipsoide");
        a = 5; % Semieje en x
          b = 3; % Semieje en y
          c = 2; % Semieje en z

          % Crear datos del elipsoide
          theta = linspace(0, 2*pi, 100); % Ángulo theta
          phi = linspace(0, pi, 50); % Ángulo phi

          % Calcular las coordenadas del elipsoide
          x = a * sin(phi') * cos(theta);
          y = b * sin(phi') * sin(theta);
          z = c * cos(phi') * ones(size(theta));

          % Definir los ángulos de rotación en los ejes x, y, z
          alpha = 0; % Ángulo de rotación en x
          beta = 0; % Ángulo de rotación en y
          gamma = 0; % Ángulo de rotación en z

          % Crear una figura en 3D
          figure;

          % Girar el elipsoide en los tres ejes

          while true
            %v0 = readAnalogPin(board, "A0");%botones
            v = readAnalogPin(board, "A0");%eje
            v1 = readAnalogPin(board, "A1");%eje
            v2 = readAnalogPin(board, "A2");%eje
            kDouble = double(v);
            kDouble1 = double(v1);
            kDouble2 = double(v2);
            % Calcular los ángulos de rotación en los ejes x, y, z
            alpha = kDouble * 0.006; % Ángulo de rotación en x
            beta = kDouble1 * 0.006; % Ángulo de rotación en y
            gamma = kDouble2 * 0.006; % Ángulo de rotación en z

            % Matrices de rotación para cada eje
            Rx = [1 0 0; 0 cos(alpha) -sin(alpha); 0 sin(alpha) cos(alpha)]; % Matriz de rotación en x
            Ry = [cos(beta) 0 sin(beta); 0 1 0; -sin(beta) 0 cos(beta)]; % Matriz de rotación en y
            Rz = [cos(gamma) -sin(gamma) 0; sin(gamma) cos(gamma) 0; 0 0 1]; % Matriz de rotación en z

            % Aplicar las rotaciones a las coordenadas del elipsoide
            coords = Rz * Ry * Rx * [x(:)'; y(:)'; z(:)']; % Aplicar las tres rotaciones
            x_rot = reshape(coords(1, :), size(x));
            y_rot = reshape(coords(2, :), size(y));
            z_rot = reshape(coords(3, :), size(z));

            % Limpiar la figura y dibujar el elipsoide rotado
            clf;
            surf(x_rot, y_rot, z_rot);
            xlabel('X');
            ylabel('Y');
            zlabel('Z');
            title('Elipsoide Rotando');
            %axis equal;
            axis([-7 7 -7 7 -7 7]);
            view(3);
            drawnow;
          end% Realizar acciones correspondientes a la Opción 4
        % Coordenadas de los vértices del rectángulo
      x = [0 1 1 0 0];
      y = [0 0 0.5 0.5 0];

      % Dibujar el rectángulo
      figure;
       plot(x, y, 'm-', 'LineWidth', 2);
      axis([-4 4 -4 4 -4 4]);
      xlabel('X');
      ylabel('Y');
      title('Rectángulo');
    case 5
        disp("Ha seleccionado la Opción 5 Vaper");
            radius1 = 3;    % Radio del primer cilindro
            height1 = 20;    % Altura del primer cilindro
            radius2 = 1;  % Radio del segundo cilindro
            height2 = 7;    % Altura del segundo cilindro
            slices = 200;   % Número de divisiones alrededor del cilindro

            % Definir los colores para cada cilindro
            color1 = [0 0.8 1];  % Celeste
            color2 = [1 0.5 0];   % Naranja

            % Definir los parámetros del primer cilindro
            theta = linspace(0, 2*pi, slices);  % Ángulos en el plano XY
            z = linspace(0, height1, slices+1);  % Posiciones a lo largo del eje Z (incluyendo el extremo superior)

            % Inicializar las matrices para las coordenadas del primer cilindro
            X1 = zeros(slices+1, slices);
            Y1 = zeros(slices+1, slices);
            Z1 = zeros(slices+1, slices);

            % Generar las coordenadas del primer cilindro
            for i = 1:slices
                X1(:, i) = radius1 * cos(theta(i));
                Y1(:, i) = radius1 * sin(theta(i));
                Z1(:, i) = z;
            end

            % Definir los parámetros del segundo cilindro
            z2 = linspace(height1, height1+height2, slices+1);  % Posiciones a lo largo del eje Z para el segundo cilindro

            % Inicializar las matrices para las coordenadas del segundo cilindro
            X2 = zeros(slices+1, slices);
            Y2 = zeros(slices+1, slices);
            Z2 = zeros(slices+1, slices);

            % Generar las coordenadas del segundo cilindro
           for i = 1:slices
                X2(:, i) = radius2 * cos(theta(i));
                Y2(:, i) = radius2 * sin(theta(i));
                Z2(:, i) = z2;
           end

            % Crear la figura
            figure;
            hold on;

            % Dibujar los cilindros con las tapas en 3D
            while true
                 %v0 = readAnalogPin(board, "A0"); %botones
                 v = readAnalogPin(board, "A0");%eje
                 v1 = readAnalogPin(board, "A1");%eje
                 v2 = readAnalogPin(board, "A2");%eje
                 clc
                 k= double(v);
                 k1= double(v1);
                 k2= double(v2);

                % Rotar los cilindros en los ejes X, Y y Z
                theta_x =  k * 0.0062;%idx * 0.01; % Ángulo de rotación en el eje X
                theta_y = k1 * 0.0062; %idx * 0.02; % Ángulo de rotación en el eje Y
                clc
                theta_z = k2 * 0.007%idx * 0.03; % Ángulo de rotación en el eje Z

                % Matrices de rotación para cada eje
                R_x = [1 0 0; 0 cos(theta_x) -sin(theta_x); 0 sin(theta_x) cos(theta_x)];
                R_y = [cos(theta_y) 0 sin(theta_y); 0 1 0; -sin(theta_y) 0 cos(theta_y)];
                R_z = [cos(theta_z) -sin(theta_z) 0; sin(theta_z) cos(theta_z) 0; 0 0 1];

                % Aplicar rotaciones a las coordenadas de los cilindros
                points1_rotated = R_x * R_y * R_z * [X1(:)'; Y1(:)'; Z1(:)'];
                points2_rotated = R_x * R_y * R_z * [X2(:)'; Y2(:)'; Z2(:)'];

                % Obtener las coordenadas rotadas
                X1_rotated = reshape(points1_rotated(1, :), size(X1));
                Y1_rotated = reshape(points1_rotated(2, :), size(Y1));
                Z1_rotated = reshape(points1_rotated(3, :), size(Z1));

                X2_rotated = reshape(points2_rotated(1, :), size(X2));
                Y2_rotated = reshape(points2_rotated(2, :), size(Y2));
                Z2_rotated = reshape(points2_rotated(3, :), size(Z2));

                % Graficar los cilindros con las tapas en 3D
                clf;
                hold on;
                surf(X1_rotated, Y1_rotated, Z1_rotated, 'FaceColor', color1);
                surf(X2_rotated, Y2_rotated, Z2_rotated, 'FaceColor', color2);
                axis([-25 25 -25 25 -25 25]);
                view(3);
                xlabel('Eje X');
                ylabel('Eje Y');
                zlabel('Eje Z');
                title('Cilindros con Tapas 3D');

                % Agregar las tapas como parches (polígonos)
                patch(X1_rotated(1, :), Y1_rotated(1, :), Z1_rotated(1, :), color1);
                patch(X1_rotated(end, :), Y1_rotated(end, :), Z1_rotated(end, :), color1);
                patch(X2_rotated(1, :), Y2_rotated(1, :), Z2_rotated(1, :), color2);
                patch(X2_rotated(end, :), Y2_rotated(end, :), Z2_rotated(end, :), color2);

                drawnow;
            end

    case 6
        disp("¡Hasta luego!");
    otherwise
        disp("Opción inválida. Por favor, seleccione una opción válida.");
end

