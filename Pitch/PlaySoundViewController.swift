//
//  PlaySoundViewController.swift
//  Pitch
//
//  Created by mbparsa on 3/3/20.
//  Copyright © 2020 mbparsa. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {

    @IBOutlet weak var Snail: UIButton!
    @IBOutlet weak var Rabit: UIButton!
    @IBOutlet weak var Low: UIButton!
    @IBOutlet weak var Revert: UIButton!
    @IBOutlet weak var Echo: UIButton!
    @IBOutlet weak var High: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case Snail = 0, Rabit, High, Low,Echo, Revert
    }
    
    override func viewWillAppear(_ animated: Bool) {
       configureUI(.notPlaying)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Snail.imageView?.contentMode = .scaleAspectFit
        Rabit.imageView?.contentMode = .scaleAspectFit
        High.imageView?.contentMode = .scaleAspectFit
        Low.imageView?.contentMode = .scaleAspectFit
        Revert.imageView?.contentMode = .scaleAspectFit
        Echo.imageView?.contentMode = .scaleAspectFit
        setupAudio()
    }
    
    @IBAction func PlaySound(_ sender: UIButton){
        switch(ButtonType(rawValue: sender.tag)!) {
        case .Snail:
            playSound(rate:0.5)
        case .Rabit:
            playSound(rate:1.5)
        case .High:
            playSound(pitch:1000)
        case .Low:
            playSound(pitch: -1000)
            
        case .Echo:
            playSound(echo:true)
        case .Revert:
            playSound(reverb:true)
        
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender : AnyObject){
        stopAudio()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
