#pragma once

#include "ofxiOS.h"
#include "ofxJSON.h"
#include "ofxTrueTypeFontUC.h"
#include "ofxJSON.h"
#include "Tweet.h"

class ofApp : public ofxiOSApp {
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
    
        // variables and definitions
        ofxTrueTypeFontUC tweetFont;
        ofxJSONElement result;
        ofxJSONElement hate;
        ofVideoPlayer myVideo;
        ofVideoPlayer myVideoHate;
        float mySpeed;
        float mySpeedHate;
    
        vector <Tweet> myTweet;
        bool touchable;

};


