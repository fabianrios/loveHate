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
    
    
    void setup(float _x, float _y, int _dim, bool _love, bool _notDying, string _text, string _date);
    void update();
    void draw();
    void present();
    
    // variables
    float x;      // position
    float y;
    float speedY; // speed and direction
    float speedX;
    int dim;      // size
    string text;
    string date;
    bool love;
    int transparent;
    bool notDying;
    int timer;
    ofTrueTypeFont textFont;
    ofColor color; // color using ofColor type
    
    Tweet();
    
};
#endif /* Tweet_h */
