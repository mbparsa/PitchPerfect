//
//  RecordSoundViewController.swift
//  Pitch
//
//  Created by mbparsa on 2/15/20.
//  Copyright © 2020 mbparsa. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isHidden = true
        


    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startRecording.imageView?.contentMode = .scaleAspectFit
        stopRecordingButton.imageView?.contentMode = .scaleAspectFit
    }
    
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var startRecording: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    
    @IBAction func Recording(_ sender: Any) {
        configureUI(shallRecord:true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedWave.wav"
        let pathArray = [dirPath,recordingName]
        let filePath = URL(string:pathArray.joined(separator: "/"))
    
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate=self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        configureUI(shallRecord:false)
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else{
            print("recording failed")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let playSoundViewController = segue.destination as! PlaySoundViewController
            let recordedAudio = sender as! URL
            playSoundViewController.recordedAudioURL = recordedAudio
        }
    }
    
    // MARK: ConfigureUI to toggle recording
    
    func configureUI(shallRecord:Bool){
        switch shallRecord {
        case true:
            recordingLabel.text = "Recording in Progress"
            startRecording.isEnabled = !shallRecord
            stopRecordingButton.isHidden = !shallRecord
        case false:
            recordingLabel.text = "Tap to Record"
            stopRecordingButton.isHidden = !shallRecord
            startRecording.isEnabled = !shallRecord
        }
    }
    
}

