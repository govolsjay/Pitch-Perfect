//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jay Foster on 3/7/15.
//  Copyright (c) 2015 JFYF. All rights reserved.
//

import UIKit
import AVFoundation

//Declared Globally
var audioRecorder:AVAudioRecorder!
var recordedAudio: RecordedAudio!



class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    override func viewWillAppear(animated: Bool) {
        //hide the stop button
        stopButton.hidden = true;
        recordButton.enabled = true;
    }
    
    
    @IBAction func recordAudio(sender: UIButton) {
    //jay:  show text "recording in progress"
    //jay:  record the users voice
        println("in recordAudio")
        recordingLabel.hidden = false;
        stopButton.hidden = false;
        recordButton.enabled = false;
        
  
        //Jay:  This is the code that sets the file name and directory
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.meteringEnabled = true
        audioRecorder.delegate = self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        }

   
    
    func  audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
        if(flag){
            //jay:  step 1 to save recorded audio
            recordedAudio = RecordedAudio()
            recordedAudio.filePathUrl = recorder.url
            recordedAudio.title = recorder.url.lastPathComponent
            //jay:  step 2 to move to the next scene
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio )
        }else{
            println("Recording was not successful")
            recordButton.enabled = true
            stopButton.hidden = true
            }
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording"){
        let playSoundsVC:PlaySoundsViewControlerViewController = segue.destinationViewController as PlaySoundsViewControlerViewController
        let data = sender as RecordedAudio
        playSoundsVC.receivedAudio = data
        }
    }
    
    
    
    
    @IBAction func stopRecording(sender: UIButton) {
        recordingLabel.hidden = true;
        stopButton.hidden = true;
        //Inside func stopAudio(sender: UIButton)
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        }





}

