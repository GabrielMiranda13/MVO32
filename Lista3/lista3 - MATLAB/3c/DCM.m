function C = DCM(i_dir,angle_rad)

% DCM: direction cosine matrix (matriz de cossenos diretores)

switch i_dir
    case 1
        C = [
            1 0 0
            0 cos(angle_rad) sin(angle_rad)
            0 -sin(angle_rad) cos(angle_rad)
            ];
    case 2
        C = [
            cos(angle_rad) 0 -sin(angle_rad)
            0 1 0
            sin(angle_rad) 0 cos(angle_rad)
            ];
    case 3
        C = [
            cos(angle_rad) sin(angle_rad) 0
            -sin(angle_rad) cos(angle_rad) 0
            0 0 1
            ];
       
end

end
