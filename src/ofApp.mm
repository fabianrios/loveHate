#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofSetOrientation(OF_ORIENTATION_90_LEFT); //Set iOS to Orientation
    ofSetCircleResolution(80);
    ofSetBackgroundColor(40,40,40);
    tweetFont.loadFont("OpenSansEmoji.ttf", 16, true, true);
    presenting = false;
    
    // get data created twitter API
    std::string url = "https://whispering-mesa-52741.herokuapp.com/twitter/search/love%20-hate%20-RT%20filter:native_video/en/52.4722208,13.3349867,10km";
    
    std::string hateurl = "https://whispering-mesa-52741.herokuapp.com/twitter/search/hate%20-love%20-RT%20filter:native_video/en/52.4722208,13.3349867,10km";
    
    // Now parse the JSON
    bool parsingSuccessful = result.open(url);
    bool parsingHate = hate.open(hateurl);
    
    if (!parsingSuccessful || !parsingHate){
        ofLogNotice("ofApp::setup")  << "Failed to parse JSON" << endl;
    }
    
    myVideo.load("love2.mp4");
    myVideoHate.load("hate1.mp4");
    mySpeed = 1;
    mySpeedHate = 1;
    
    const Json::Value& tweets = result["statuses"];
    const Json::Value& hateTweets = hate["statuses"];
    
    for (int i = 0; i < tweets.size(); i++){
        std::string date = tweets[i]["created_at"].asString();
        std::string message = tweets[i]["text"].asString();
        Tweet tempTweet;							// create the ball object
        tempTweet.setup(0,0, 60, true, false, message, date);	// setup its initial state
        myTweet.push_back(tempTweet);
    }
    
    for (int i = 0; i < hateTweets.size(); i++){
        std::string date = tweets[i]["created_at"].asString();
        std::string message = tweets[i]["text"].asString();
        Tweet tempTweet;
        tempTweet.setup(0,0, 60, false, false, message, date);
        myTweet.push_back(tempTweet);
    }
    
}

//--------------------------------------------------------------
void ofApp::update(){
    
    for (int i = 0; i<myTweet.size(); i++) {
        myTweet[i].update();
    }
    
    // video
    myVideo.update();
    myVideoHate.update();
}

//--------------------------------------------------------------
void ofApp::draw(){
    
    // scene preparation
    ofSetColor(150);
    ofDrawLine(ofGetWidth()/2, 0, ofGetWidth()/2, ofGetHeight());
    
    float ratio = myVideo.getWidth()/myVideo.getHeight();
    myVideo.draw(0,0,ofGetWidth()/2,(ofGetWidth()/2)/ratio);
    myVideoHate.draw(ofGetWidth()/2,0,ofGetWidth()/2,ofGetWidth()/2/ratio);
    
    if (result.isMember("errors")){
        ofDrawBitmapString(result.getRawString(), 10, 14);
    }
    
    for (int i = 0 ; i<myTweet.size(); i++) {
        myTweet[i].draw();
    }
    
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
        for (int i =0; i < myTweet.size(); i++) {
            float distance = ofDist(touch.x,touch.y, myTweet[i].x, myTweet[i].y);
            if(myTweet[i].notDying){
                presenting = true;
            }
            if (distance < myTweet[i].dim) {
                if(!presenting){
                    myTweet[i].present();
                }
            }
        }
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
//    cout << touch.x << endl;
//    if (touch.x < ofGetWidth()/2){
//        mySpeed = ofMap(touch.x,0,ofGetWidth()/2,0,2);
//        myVideo.setSpeed(mySpeed);
//    }else{
//        mySpeedHate = ofMap(touch.x,ofGetWidth()/2,ofGetWidth(),0,2);
//        myVideoHate.setSpeed(mySpeedHate);
//    }
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){
    if(touch.x < ofGetWidth()/2) myVideo.setPaused(!myVideo.isPaused());
    if(touch.x > ofGetWidth()/2) myVideoHate.setPaused(!myVideoHate.isPaused());
    
    for (int i =0; i < myTweet.size(); i++) {
        float distance = ofDist(touch.x,touch.y, myTweet[i].x, myTweet[i].y);
        if (distance < myTweet[i].dim) {
            myTweet.erase(myTweet.begin()+i);
        }
    }
    
}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}
