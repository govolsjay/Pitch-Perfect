//
//  PlaySoundsViewControlerViewController.swift
//  Pitch Perfect
//
//  Created by Jay Foster on 3/7/15.
//  Copyright (c) 2015 JFYF. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewControlerViewController: UIViewController {

    var audioPlayer:AVAudioPlayer?    //Jay:  These four variables will be used in our class to work the audio file
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl,  error: nil)
        audioPlayer?.enableRate = true;
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        }
    


    
    @IBAction func playSlowSound(sender: UIButton) {   //Jay:  This works the snail button to play at a rate of 0.5 - slow
        println("slow button")
        if let sound = audioPlayer {
                audioPlayer?.stop()
                sound.prepareToPlay()
                audioPlayer?.rate=0.5
                audioPlayer?.volume = 1.0
                sound.play()
                }
        }
        
    
    
    @IBAction func playFastSound(sender: UIButton) {  //Jay:  This works the rabbit button to play at a rate of 2.0 - fast
        println("fast button")
        if let sound = audioPlayer {
            audioPlayer?.stop()
            sound.prepareToPlay()
            audioPlayer?.rate=2.0
            audioPlayer?.volume = 1.0
            sound.play()
            }
    }

    
    
    @IBAction func playEcho(sender: UIButton) {   //Jay:  This works the cave button to play an echo/reverb - works with function below
        playAudioWithReverb(150)
        println("reverb")
    }
    
    
    @IBAction func darthVador(sender: AnyObject) {   //Jay:  This works with the Darth Vador button to play a pitch of -1000 - works with the function below
        playAudioWithVariablePitch(-1000)
        println("darth")
    }
    
    
    
    @IBAction func playChipmunkAudio(sender: AnyObject) {   //Jay:  This works with the chipmunk button to play a pitch of 1000 - works with the function below
        playAudioWithVariablePitch(1000)
        println("chipmunk")
    }
    
    
    @IBAction func stopPlayback(sender: AnyObject) {  //Jay:  This controls the stop button
        audioPlayer?.stop()
        audioEngine.stop()
    }
    
    
    
    func playAudioWithVariablePitch(pitch: Float){   //Jay:  this is the code that uses the AVAudioPlayerNode to give us pitch capabilities
            audioPlayer?.stop()
            audioEngine.stop()
            audioEngine.reset()
          
            var audioPlayerNode = AVAudioPlayerNode()
            audioEngine.attachNode(audioPlayerNode)
     
            var changePitchEffect = AVAudioUnitTimePitch()
            changePitchEffect.pitch = pitch
            audioEngine.attachNode(changePitchEffect)
        
            audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
            audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
            audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
            audioEngine.startAndReturnError(nil)
            
            audioPlayerNode.play()
            }
    
    

    func playAudioWithReverb(reverb: Float){   //Jay:  This is the code that uses the AVAudioUnitReverb capability
            audioPlayer?.stop()
            audioEngine.stop()
            audioEngine.reset()
        
            var audioPlayerNode = AVAudioPlayerNode()
            audioEngine.attachNode(audioPlayerNode)
        
            var changeReverb = AVAudioUnitReverb()
            changeReverb.wetDryMix = reverb
            audioEngine.attachNode(changeReverb)
        
            audioEngine.connect(audioPlayerNode, to: changeReverb, format: nil)
            audioEngine.connect(changeReverb, to: audioEngine.outputNode, format: nil)
            audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
            audioEngine.startAndReturnError(nil)
        
            audioPlayerNode.play()
            }


    

    
    


}






