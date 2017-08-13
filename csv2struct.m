%This function is defined to convert csv file to structure array
function S = csv2struct(filename)
ds = tabularTextDatastore(filename);
T = read(ds);
S = table2struct(T);
for i = 1:length(S)%give evey city a row number
    S(i).index = i;
end
end
%This is function uses table2struct
%thus table object is the limitation
%that the number of rows should be no larger
%than 20000