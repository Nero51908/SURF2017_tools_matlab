%% This scrip will take csv file with lat, lng, id(numeric) as input
%%manipulating circlem.m script by https://uk.mathworks.com/matlabcentral/fileexchange/48122-circlem
%%the result should be a file providing circles(actually 100 edges polygon) calculated by user
%%specified centre and redius.

%% Read input csv file
function circles_on_map_sph(filename,radius_km)
worldmap('world')
csv_content = csvread(filename);%read csv as array [id, lat, lng]
array_size = size(csv_content);
output_array = zeros(array_size(1)*100,4);%[id,circle_latitude,circle_longitude,connection_order]
for i = 1:array_size(1)%iterate the location array
    [~,circle_lat,circle_lng] = circlem(csv_content(i,2),csv_content(i,3),radius_km);
    output_array((i-1)*100+1:i*100,1) = csv_content(i,1);%assigning output id
    output_array((i-1)*100+1:i*100,2:3) = [circle_lat,circle_lng];%assigning circle path
    output_array((i-1)*100+1:i*100,4) = (1:100)';

end
csvwrite(['with_circles_' filename],output_array);
end