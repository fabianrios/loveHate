//
//  Tweet.mm
//  loveHate
//
//  Created by Fabian Rios on 29.06.17.
//
//

#ifndef Tweet_h
#define Tweet_h

#include <stdio.h>

class Tweet {
    
public:
    
    
    void setup(float _x, float _y, int _dim);
    void update();
    void draw();
    
    // variables
    float x;      // position
    float y;
    float speedY; // speed and direction
    float speedX;
    int dim;      // size
    ofColor color; // color using ofColor type
    
    
    Tweet(); // constructor - used to initialize an object, if no properties are passed the program sets them to the default value
private: // place private functions or variables declarations here
    
}; // don't forget the semicolon!!
#endif /* Tweet_h */
