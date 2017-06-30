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
    textFont.load("OpenSansEmoji.ttf", 22);
    
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
        y += 60;
        x += 60;
        float distance = ofDist(ofGetWidth()/2,ofGetHeight(), x, y);
        float hateDistance = ofDist(ofGetWidth(),ofGetHeight(), x, y);
        
        if (distance < dim || hateDistance < dim) {
            if(timer < 300){
                dim = 800;
                timer+=1;
            }else{
                timer = 0;
                dim = 60;
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
        float hateDistance = ofDist(ofGetWidth(),ofGetHeight(), x, y);
        if (distance < dim || hateDistance < dim) {
            //cout << timer << endl;
            if(timer < 300){
                float textSize = textFont.stringWidth(text);
                textFont.drawString(text, x-(textSize/2), y-50);
            }
        }
    }
}

void Tweet::present(){
    
    // stop the previous animation
    notDying = true;
}
