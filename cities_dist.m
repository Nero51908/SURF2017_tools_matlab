%this function will find distance between cities
%it requires
%1. input structure array contains deduplicated city list called
%   "cities_data"
%   with names of cities stored in field city_or_region
%   with latitude information stored in field lat
%   with longitude information stored in field lng
%2. input mode 'a' or 'c' representing arrangement or combination
%output of 'a' mode will be a structure array with one layer of nested struct array
%output of 'c' mode will be just one structure array with row-count the
%same as the number of combinations of the cities.
%(I was using structure array to express a 2-dimenssional matrix)
%a call of cities1(1).cities2(1).distance will bring the calculated
%distance in meters since the function distance() uses meters by default.
function cities1 = cities_dist(cities_data,mode)%'c': combination, 'a': arrangement
earth_radius = 6371000; %meters
rowcount = length(cities_data);
if mode=='a'%each city pair will be considered twice
    %initialize memory space
    cities1(1).cities2(1).cities1_name = '';
    cities1(length(cities_data)).cities2(length(cities_data)).cities1_name = '';
    cities1(1).cities2(1).cities2_name = '';
    cities1(length(cities_data)).cities2(length(cities_data)).cities2_name = '';
    cities1(1).cities2(1).distance = '';
    cities1(length(cities_data)).cities2(length(cities_data)).distance = '';
    for i = 1:rowcount
        lat1 = str2double(cities_data(i).lat);
        lng1 = str2double(cities_data(i).lng);
        for j = 1:rowcount
            lat2 = str2double(cities_data(j).lat);
            lng2 = str2double(cities_data(j).lng);
            cities1(i).cities2(j).cities1_name = cities_data(i).city_or_region;
            cities1(i).cities2(j).cities2_name = cities_data(j).city_or_region;
            cities1(i).cities2(j).distance = distance(lat1,lng1,lat2,lng2,earth_radius);
        end
    end
elseif mode == 'c'
    %combination mode will calculate distance between all C(n,2) pairs of
    %cities, thus the output will only have C(n,2) rows rather than a
    %double decker structure array as in arrangement case. This
    %implementation also gives a prototype of listing arrangement case as
    %one structure for convenience of viewing names and distance.
    %initialize memory space
    rowcount2 = nchoosek(length(cities_data),2);
    cities1(rowcount2).source = '';
    cities1(rowcount2).target = '';
    cities1(rowcount2).distance = '';   
    index = 1;
    for i = 1:rowcount
        %rowcount is the length of cities dataset. i,j will iterate through
        %the dataset cities_data as in 'a' mode by the rule of combination
        lat1 = str2double(cities_data(i).lat);
        lng1 = str2double(cities_data(i).lng);
        for j = (i+1):rowcount
            lat2 = str2double(cities_data(j).lat);
            lng2 = str2double(cities_data(j).lng);
            cities1(index).source = cities_data(i).city_or_region;
            cities1(index).target = cities_data(j).city_or_region;
            cities1(index).distance = distance(lat1,lng1,lat2,lng2,earth_radius);
            index = index + 1;
        end
    end
end
        
 