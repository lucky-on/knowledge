// MaxPointsOnLine.cpp

// Given n points on a 2D plane, find the maximum number of points that lie on the same straight line.

/**
 * Definition for a point.
 * struct Point {
 *     int x;
 *     int y;
 *     Point() : x(0), y(0) {}
 *     Point(int a, int b) : x(a), y(b) {}
 * };
 */

class Solution {
public:
    int maxPoints(vector<Point> &points) {
        
        int res=0;
        
        for(int i=0; i < points.size(); i++){
            int same = 1;
            unordered_map<double,int> hash;
 
            for(int j = i+1; j < points.size(); j++){

                // two points are on the same position
                if(points[i].x == points[j].x && points[i].y == points[j].y)    same++;             
                // two points are on the same horizontal line
                else if(points[i].x == points[j].x)                             hash[INT_MAX]++;    
                 // otherwise two points are on different positions by X and need to calculate slope = dy/dx
                else    hash[double(points[i].y - points[j].y) / double(points[i].x - points[j].x)]++;
            }
            
            // now we need to find the max number of points with are on the same line with point "points[i]"
            int localMax = 0;
            for(auto const &it : hash){
                if(it.second > localMax) localMax = it.second;
            }
            
            localMax += same;           // add same points with points[i]
            res = max(localMax, res);   // keep global maximun in result variable
        }
        
        return res;
    }
};
