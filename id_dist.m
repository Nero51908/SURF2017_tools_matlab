% This script takes numerical matrix input
% the matrix should contain cities id and the location info(lat, lng)
% column index: id = 1, lat = 2 , lng = 3
% output will be the distance between two places
% column index: source_id = 1, target_id = 2, distance = 3
% user need to choose between 'a' arrangement mode and 'c' combination mode
%
function matrix_out = id_dist(matrix_in,mode)
    size_in = size(matrix_in);
    earth_radius = 6371000; %meters
    if mode == 'a'
        %arrangement mode, direction matters
        matrix_out = zeros(size_in(1));%initialize matrix
        for i = 1:size_in(1)
            lat1 = matrix_in(i,2);
            lng1 = matrix_in(i,3);
            for j = 1:size_in(1)
                lat2 = matrix_in(j,2);
                lng2 = matrix_in(j,3);
                matrix_out(i,j)= distance(lat1,lng1,lat2,lng2,earth_radius);
            end
        end
    elseif mode == 'c'
        %combination mode, undirected connection
        matrix_out = zeros(size_in(1));%initialize matrix
        for i = 1:size_in(1)
            lat1 = matrix_in(i,2);
            lng1 = matrix_in(i,3);
            for j = i:size_in(1)
                lat2 = matrix_in(j,2);
                lng2 = matrix_in(j,3);
                matrix_out(i,j)= distance(lat1,lng1,lat2,lng2,earth_radius);
            end
        end
    end
end