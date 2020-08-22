//
//  AudioManager.swift
//  SampleApp
//
//  Created by sahil.khanna on 8/22/20.
//  Copyright © 2020 sahil.khanna. All rights reserved.
//

import Foundation
import Speech
import AVKit
import AVFoundation

protocol AudioManagerProtocol {
    func didDetectWord(word: String);
}

class AudioManager {
    
    var delegate: AudioManagerProtocol?;
    
    func audioToText(name: String, ext: String, playAlong: Bool = true) {
        let audioFileURL = Bundle.main.url(forResource: name, withExtension: ext);
        
        if (playAlong) {
            playAudio(url: audioFileURL);
        }
                
        let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-UK"));
        let speechURLRecognitionRequest = SFSpeechURLRecognitionRequest(url: audioFileURL!);
        speechURLRecognitionRequest.shouldReportPartialResults = true;
        
        var lastWord = "";
        
        if (speechRecognizer?.isAvailable)! {
            speechRecognizer?.recognitionTask(with: speechURLRecognitionRequest) { result, error in
                guard error == nil else {
                    print("Error: \(error!)");
                    return;
                }
                
                guard let result = result else {
                    print("No result!");
                    return;
                }
                
                if (lastWord != result.bestTranscription.formattedString.components(separatedBy: .whitespaces).last) {
                    lastWord = result.bestTranscription.formattedString.components(separatedBy: .whitespaces).last!;
                    self.delegate?.didDetectWord(word: lastWord);
                }
            }
        }
        else {
            print("Device doesn't support speech recognition")
        }
    }
    
    private func playAudio(url audioFileURL: URL!) {
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
        let avPlayer = AVPlayer(url: audioFileURL);
        avPlayer.volume = 1.0;
        avPlayer.play()
    }
}
