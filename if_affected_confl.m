%% This script will sift out all locations covered by recorded conflict
%       each mentioned field in format should be a vector( vertical)
%       id numbers should start from 1 by convention, and it's easy to
%       implement using Trifacta or Excel.
%%input:
%%1. filename of locations dataset like 4000_cities.csv
%       format: [id(A), latitude, longitude] all numeric values
%               [  1  ,     2   ,       3  ]
%%2. filename of recorded conflict region dataset like 127_conflict.csv
%       format: [id(B), latitude, longitude] all numeric values
%%output:
%%a numeric csv file containing information of whether a location on the
%%planet is covered by any input conflict in terms of circular area
%%coverage with conflict areas as centers and a specified radius.
%%output filename will have a prefix of "if_affected_"
%       output format: [covered_id_in_id(A), covered by id(B),
%       distance_to_center]
%% Then the function:
function if_affected_confl(locationfilename,conflictfilename,radiusofarea_km)
% a for loop will be needed for iteration, get the index first
locations = csvread(locationfilename);
conflicts = csvread(conflictfilename);
localen = size(locations);
conflen = size(conflicts);
earth_radius = 6371000;%earth radius in meter
%nominate an output container:
output_temp = zeros(1);
output_index = 1;
%% First step is to check whether the location is contained in output set
for i = 1:localen(1)% i is iterating locations
    for j = 1:conflen(1)% j is iterating recorded conflict areas
        if ~any(i == output_temp(:,1))
            %if current location is not in output set then do this:
            temp_dist = distance(locations(i,2),locations(i,3),conflicts(j,2),conflicts(j,3),earth_radius);
            if temp_dist <= (radiusofarea_km*1000)%convert input radius to meter
                %if current location is inside current area:
                output_temp(output_index,1) = i;
                output_temp(output_index,2) = j;
                output_temp(output_index,3) = temp_dist;
                output_index = output_index + 1;
            end
        end
    end
end
csvwrite(['if_affected_',locationfilename],output_temp);           
end