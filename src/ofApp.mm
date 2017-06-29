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
    
}

//--------------------------------------------------------------
void ofApp::update(){
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
        const Json::Value& trends = result["statuses"];
        //cout << trends.size() << endl;
        
        for (Json::ArrayIndex i = 0; i < trends.size(); ++i){
            std::string date = trends[i]["created_at"].asString();
            //std::string video = trends[i]["extended_entities"].asString();
            std::string message = trends[i]["text"].asString();
            tweetFont.drawString(message, 10, 40*i);
            //tweetFont.drawString(date, 10, 70*i+130);
            
            
        }
    }
    
    
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){

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
