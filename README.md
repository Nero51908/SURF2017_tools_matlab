# SURF2017_tools_matlab
MATLAB scripts for our SURF purpose
csv2struct.m should convert csv file to structure array using a table object.
    the use of table object limits this function
    thus in further versions it should be using reading functions instead.
cities_dist.m will calculate distance between cities given a structure array containing latitude and longitude
net_gen.m takes structure array with explicit (not nested strucutre) fields and values as input.
    there should be a distance field in the input structure so that the function will generate edges for network
    according to input distance threshold which determines whether two places are "connected" or not.
For now, all these scripts uses table object which must be avoided in the future.
