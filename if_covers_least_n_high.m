%% This function calculates whether a conflict area contains at least n high centrality point.
%%input:id should start from 1.
%%1. filename of locations with high centrality like high_centrality_245_4000_matlabin.csv
%       format: [id(A), latitude, longitude, betweenness centrality] all numeric values
%               [  1  ,     2   ,       3  ,            4          ]
%%2. filename of recorded conflict region dataset like 127_conflict.csv
%       format: [id(B), latitude, longitude] all numeric values
%%output:
%       format: [id(conflict id, unique), whether it satisfies input
%       criteria]
function if_covers_least_n_high(locationfilename,conflictfilename,radius_km,centrality_thresh,n)
locations = csvread(locationfilename);
conflicts = csvread(conflictfilename);
earth_radius = 6371000;
%I will need the size of arrays for iteration.
%firstly, say I have these many conflict centers with radius of buffer radius(input)
con_size = size(conflicts);
%and I have these many location data on the map
loc_size = size(conflicts);
%iterate conflict points to check whether there are at least n points from
%conflictfilename file covered by each buffer circle. I will thereby use 1
%or 0 to represent the results.
temp_output = zeros(con_size(1),2);%output initialization: no conflict area covers enough points at the beginning.
for i = 1:con_size(1)%iterate conflict points
    n_counter = 0;%this is the counter for number of high centrality points being covered.
    for j = 1:loc_size(1)
        if locations(j,4) >= centrality_thresh%filterout low centrality locations.
            temp_dist = distance(conflicts(i,2),conflicts(i,3),locations(j,2),locations(j,3),earth_radius);
            if temp_dist <= radius_km*1000%if this location is covered by a circular buffer
                n_counter = n_counter+1;%if so, increase the counter. if not, do nothing.
            end
            if n_counter >= n%if the count of high centrality points satisties input criteria n
                temp_output(i,:)=[i,1];%if so, assign temp_output line i with id(i) and TRUE(1)
                break%break this for loop, go with the next conflict point (id i + 1).
            elseif j == loc_size(1)%iteration ends but n is not satisfied.
                temp_output(i,:)=[i,0];%if elseif case, assign line i with id(i) and FALSE(0)
            end 
        end
    end
end   
csvwrite(['conf_cvrs_' num2str(n) '_radius_' num2str(radius_km) '.csv'],temp_output);
number_of_hits = nnz(temp_output(:,2));
fprintf(['Output file [%s] should be generated.\n%d conflict points hit your target.\nCoverage radius:' num2str(radius_km) 'km\n' 'Each circle contains at least ' num2str(n) ' high centrality points\n'],['conf_cvrs_' num2str(n) '_radius_' num2str(radius_km) '.csv'],number_of_hits);
end%end of function