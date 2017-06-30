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

void Tweet::setup(float _x, float _y, int _dim, bool _love){
    x = _x;      // give some random positioning
    y = _y;
    dim = _dim;
    love = _love;
    
    speedX = ofRandom(-10,30);
    speedY = ofRandom(-10,30);
    
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
    
    x+=speedX;
    y+=speedY;
    
}

void Tweet::draw(){
    ofSetColor(color);
    ofDrawCircle(x, y, dim);
}

void Tweet::die(){
    // it should go to the center first
    dim = ofGetHeight();
    x = 0;
    y = 0;
    //this.erase(i);
}
