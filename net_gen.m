% this is a distance filter
%1. input distance information stored in structure array
%2. input distance for connection threshold
%3. input char to present the unit 'm' or 'km' of distance, by default it should be meter.
%this function will contruct another structure array of connection internally
%then it will perform struct2table and write table into a csv file named outputnet.csv
function tempstruct = net_gen(distance,threshold,unit)
%initialize memory space
index = 1;
inputrows = length(distance);
tempstruct(100).source = '';
tempstruct(100).target = '';
if unit == 'km'
    threshold = 1000*threshold;
elseif unit == 'm'||isempty(unit)
else
    fprintf('distance unit is invalid\n');
end
for i = 1:length(distance)
    if distance(i).distance <= threshold
        %if distance is less or equal to the distance threshold
        %the two cities or regions are considered connected
        tempstruct(index).source = distance(i).source;
        tempstruct(index).target = distance(i).target;
        index = index + 1;
    end
end
temptable = struct2table(tempstruct);
writetable(temptable,'output_edges.csv')
end
