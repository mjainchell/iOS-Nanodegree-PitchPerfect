//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Mark Jainchell on 5/15/17.
//  The majority of the code for this app is provided through the Udacity lesson PitchPerfect, as part of the iOS Nanodegree
//  https://www.udacity.com/
//  The alert functionality was inspired by an answer on:
//  Stack Overflow: http://stackoverflow.com/questions/24195310/how-to-add-an-action-to-a-uialertview-button-using-swift-ios

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    let recordingErrorAlert = UIAlertController(title: "Recording Error", message: "Recording was not successful!", preferredStyle: .alert)
    let tryAgainAction = UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default)
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Buttons scaled as suggested by Udacity Code Review
        scaleTheButtons(recordButton, stopRecordingButton)
    }
    
    func recordingLabelAndButtonAppearanceRecordingStatus(_ appIsRecording: Bool) {
        // Refactoring completed as suggested by Udacity Code Review
        recordingLabel.text = appIsRecording ? "Recording in Progress..." : "Tap to Record"
        stopRecordingButton.isEnabled = appIsRecording
        recordButton.isEnabled = !appIsRecording
    }

    @IBAction func recordAudio(_ sender: Any) {
        recordingLabelAndButtonAppearanceRecordingStatus(true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        recordingLabelAndButtonAppearanceRecordingStatus(false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            // Alert, instead of Print statement as suggested by Udacity Code Review
            showAlert(recordingErrorAlert, tryAgainAction)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

