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
    
    
    void setup(float _x, float _y, int _dim, bool _love);
    void update();
    void draw();
    
    // variables
    float x;      // position
    float y;
    float speedY; // speed and direction
    float speedX;
    int dim;      // size
    bool love;
    
    ofColor color; // color using ofColor type
    
    
    Tweet();
    
};
#endif /* Tweet_h */
