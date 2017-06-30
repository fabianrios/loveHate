//
//  Tweet.mm
//  loveHate
//
//  Created by Fabian Rios on 29.06.17.
//
//

#include "ofxiOS.h"
#include "Tweet.h"


Tweet::Tweet(){
};

void Tweet::setup(float _x, float _y, int _dim, bool _love, bool _notDying, string _text, string _date){
    x = _x;      // give some random positioning
    y = _y;
    dim = _dim;
    love = _love;
    notDying = _notDying;
    text = _text;
    date = _date;
    textFont.load("OpenSansEmoji.ttf", 28);
    
    speedX = ofRandom(10);
    speedY = ofRandom(10);
    timer = 0;
    color.set(ofRandom(255),ofRandom(255),ofRandom(255));
}

void Tweet::update(){
    int boundary_w = ofGetWidth()-(dim/2);
    int start_boundary_w = (ofGetWidth()/2)+(dim/2);
    
    
    
        if (love){
            boundary_w = (ofGetWidth()/2)-(dim/2);
            start_boundary_w = (dim/2);
        }
    
        if(x < start_boundary_w){
            x = start_boundary_w;
            speedX *= -1;
        }else if(x > boundary_w){
            x = boundary_w;
            speedX *= -1;
        }
    
        if(y < dim/2){
            y = dim/2;
            speedY *= -1;
        } else if(y > ofGetHeight()-(dim/2)){
            y = ofGetHeight()-(dim/2);
            speedY *= -1;
        }
        
    
    
    if(!notDying){
        x+=speedX;
        y+=speedY;
    }else{
        y += 20;
        x += 20;
        float distance = ofDist(ofGetWidth()/2,ofGetHeight(), x, y);
        if (distance < dim) {
            if(timer < 300){
                dim = 500;
                timer+=1;
            }else{
                dim = 40;
                notDying = false;
            }
        }
    }
    
}

void Tweet::draw(){
    ofSetColor(color);
    ofDrawCircle(x, y, dim);
    ofSetColor(255);
    if(notDying){
        float distance = ofDist(ofGetWidth()/2,ofGetHeight(), x, y);
        if (distance < dim) {
            cout << timer << endl;
            if(timer < 300){
                textFont.drawString(text, x, y);
            }
        }
    }
}

void Tweet::present(){
    
    // stop the previous animation
    notDying = true;
}
