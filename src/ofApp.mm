#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofSetOrientation(OF_ORIENTATION_90_LEFT); //Set iOS to Orientation
    ofSetCircleResolution(80);
    //ofBlendMode(OF_BLENDMODE_ALPHA);    
    ofSetBackgroundColor(40,40,40);
    mainFont.load("OpenSans-Bold.ttf", 64);
    sound1.load("pop.mp3");
    sound2.load("tat.mp3");
    
    // get data created twitter API
    std::string url = "https://whispering-mesa-52741.herokuapp.com/twitter/search/love%20-hate%20-RT%20filter:native_video/en/52.4722208,13.3349867,100km";
    
    std::string hateurl = "https://whispering-mesa-52741.herokuapp.com/twitter/search/hate%20-love%20-RT%20filter:native_video/en/52.4722208,13.3349867,100km";
    
    // Now parse the JSON
    bool parsingHate = hate.open(hateurl);
    bool parsingSuccessful = result.open(url);
    
    
    if (!parsingSuccessful || !parsingHate){
        ofLogNotice("ofApp::setup")  << "Failed to parse JSON" << endl;
    }
    
    int whichone = ofRandom(1,7);
    
    myVideo.load("love"+std::to_string(whichone)+".mp4");
    myVideoHate.load("hate"+ofToString(whichone)+".mp4");
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
        std::string date = hateTweets[i]["created_at"].asString();
        std::string message = hateTweets[i]["text"].asString();
        Tweet hateTempTweet;
        hateTempTweet.setup(0,0, 60, false, false, message, date);
        myTweet.push_back(hateTempTweet);
    }
    
}

//--------------------------------------------------------------
void ofApp::update(){
    cout << ofGetOrientation() << endl;
    if (ofGetOrientation() == 3) touchable = true;
    
    for (int i = 0; i<myTweet.size(); i++) {
        myTweet[i].update();
    }
    
    // video
    myVideo.update();
    myVideoHate.update();
}

//--------------------------------------------------------------
void ofApp::draw(){
    
    if(touchable){
    // scene preparation
    ofSetColor(150);
    ofDrawLine(ofGetWidth()/2, 0, ofGetWidth()/2, ofGetHeight());
    
    float ratio = myVideo.getWidth()/myVideo.getHeight();
    myVideo.draw(0,0,ofGetWidth()/2,(ofGetWidth()/2)/ratio);
    myVideoHate.draw(ofGetWidth()/2,0,ofGetWidth()/2,ofGetWidth()/2/ratio);
    
    
    if (result.isMember("errors")){
        ofDrawBitmapString(result.getRawString(), 10, 14);
    }
    
    mainFont.drawString("LOVE", (ofGetWidth()/2)/2-70, 100);
    mainFont.drawString("HATE", ofGetWidth()-((ofGetWidth()-ofGetWidth()/2)/2)-70, 100);
    
    for (int i = 0 ; i<myTweet.size(); i++) {
        myTweet[i].draw();
    }
    }
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    for (int i =0; i < myTweet.size(); i++) {
        float distance = ofDist(touch.x,touch.y, myTweet[i].x, myTweet[i].y);
        if (distance < myTweet[i].dim) {
            myTweet[i].present();
        }
    }
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    if(touch.y > ofGetHeight()-100){
        if (touch.x < ofGetWidth()/2){
            mySpeed = ofMap(touch.x,0,ofGetWidth()/2,0,2);
            myVideo.setSpeed(mySpeed);
        }else{
            mySpeedHate = ofMap(touch.x,ofGetWidth()/2,ofGetWidth(),0,2);
            myVideoHate.setSpeed(mySpeedHate);
        }
    }
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){
    if(touch.x < ofGetWidth()/2){
        myVideo.setPaused(!myVideo.isPaused());
        sound1.play();
    }
    if(touch.x > ofGetWidth()/2){
        myVideoHate.setPaused(!myVideoHate.isPaused());
        sound2.play();
    }
    
//    for (int i =0; i < myTweet.size(); i++) {
//        float distance = ofDist(touch.x,touch.y, myTweet[i].x, myTweet[i].y);
//        if (distance < myTweet[i].dim) {
//            myTweet.erase(myTweet.begin()+i);
//        }
//    }
    
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
