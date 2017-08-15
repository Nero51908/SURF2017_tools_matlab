
function id_proto(filename,threshold,unit,mode)
temp_out = zeros(4);%source target distance direction(di:1,un:0)
index = 1;%initialize temp_out index (row number)
if unit == 'km'
    threshold = threshold * 1000; %convert to meter for distance comparison
elseif unit == 'm'
else
    fprinf("only 'm' or 'km' is acceptable");
end
raw = csvread(filename);
distance = id_dist(raw,mode);
size_dist = size(distance);%row column
if mode == 'a'
    for i = 1 : size_dist(1)
        for j = 1 : size_dist(1)
            if distance(i,j)~= 0 && distance(i,j) <= threshold
                temp_out(index,:) = [i,j,distance(i,j),1];%directed network
                index = 1+index;
            end
        end
    end
    
elseif mode == 'c'
    for i = 1 : size_dist(1)
        for j = i : size_dist(1)
            if distance(i,j)~= 0 && distance(i,j)<=threshold
                temp_out(index,:) = [i,j,distance(i,j),0];%undirected network
                index = 1+index;
            end
        end
    end
else
    fprintf("input mode should be 'a' or 'c'");
end
csvwrite(['cooked_' filename],temp_out);
end