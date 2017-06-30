#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofSetOrientation(OF_ORIENTATION_90_LEFT); //Set iOS to Orientation
    ofSetCircleResolution(80);
    ofSetBackgroundColor(40,40,40);
    tweetFont.loadFont("OpenSansEmoji.ttf", 16, true, true);
    
    
    
    // get data created twitter API
    std::string url = "https://whispering-mesa-52741.herokuapp.com/twitter/search/love%20-hate%20-RT%20filter:native_video/en/52.4722208,13.3349867,10km";
    
    std::string hateurl = "https://whispering-mesa-52741.herokuapp.com/twitter/search/hate%20-love%20-RT%20filter:native_video/en/52.4722208,13.3349867,10km";
    
    // Now parse the JSON
    bool parsingSuccessful = result.open(url);
    bool parsingHate = hate.open(hateurl);
    
    if (!parsingSuccessful || !parsingHate){
        ofLogNotice("ofApp::setup")  << "Failed to parse JSON" << endl;
    }
    
    myVideo.load("love1.mp4");
    myVideoHate.load("hate1.mp4");
    mySpeed = 1;
    mySpeedHate = 1;
    
    const Json::Value& tweets = result["statuses"];
    const Json::Value& hateTweets = hate["statuses"];
    
    for (int i = 0; i < tweets.size(); i++){
        Tweet tempTweet;							// create the ball object
        tempTweet.setup(0,0, 40, true);	// setup its initial state
        myTweet.push_back(tempTweet);
    }
    
    for (int i = 0; i < hateTweets.size(); i++){
        Tweet tempTweet;
        tempTweet.setup(0,0, 40, false);
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
    //tweetFont.drawStringAsShapes("<3 -<", 100, 100);
    //tweetFont.drawString("🐯a😎	😏a", 100, 200);
    
    // scene preparation
    ofSetColor(150);
    ofDrawLine(ofGetWidth()/2, 0, ofGetWidth()/2, ofGetHeight());
    
    float ratio = myVideo.getWidth()/myVideo.getHeight();
    myVideo.draw(0,0,ofGetWidth()/2,(ofGetWidth()/2)/ratio);
    myVideoHate.draw(ofGetWidth()/2,0,ofGetWidth()/2,ofGetWidth()/2/ratio);
    
    if (result.isMember("errors")){
        ofDrawBitmapString(result.getRawString(), 10, 14);
    }
    else if (result.isObject()){
        ofSetColor(200,200,200);
        //cout << trends.size() << endl;
        
        const Json::Value& trends = result["statuses"];
        const Json::Value& haters = hate["statuses"];
        
        for (Json::ArrayIndex i = 0; i < trends.size(); i++){
            std::string date = trends[i]["created_at"].asString();
            std::string message = trends[i]["text"].asString();
            tweetFont.drawString(message, 10, 80*i);
            tweetFont.drawString(date, 10, (80*i)+30);
        }
        
        for (Json::ArrayIndex i = 0; i < haters.size(); i++){
            std::string date = haters[i]["created_at"].asString();
            std::string message = haters[i]["text"].asString();
            tweetFont.drawString(message, ofGetWidth()/2, 80*i);
            tweetFont.drawString(date, ofGetWidth()/2, (80*i)+30);
        }
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
        if (distance < myTweet[i].dim) {
//            myTweet.erase(myTweet.begin()+i);
              myTweet[i].die();
        }
    }
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    cout << touch.x << endl;
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
