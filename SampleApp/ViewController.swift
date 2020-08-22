//
//  ViewController.swift
//  SampleApp
//
//  Created by sahil.khanna on 8/21/20.
//  Copyright © 2020 sahil.khanna. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AudioManagerProtocol {
    @IBOutlet var imageView: UIImageView!;
    @IBOutlet var textView: UITextView!;
    
    // MARK: UIViewController Delegate
    override func viewDidAppear(_ animated: Bool) {
        let audioManager = AudioManager();
        audioManager.delegate = self;
        audioManager.audioToText(name: "ns004", ext: "mp3");
    }
    
    // MARK: AudioManager Delegate
    func didDetectWord(word: String) {
        textView.text.append("\(word) ");
        
        let characters = Array(word.uppercased());
        var imageName = "";
        var delay = 0.0;
        
        Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { (timer) in
            for i in 0...characters.count - 1 {
                delay = delay + 0.25;
                
                let char = characters[i];
                var nextChar = Character(" ");
                if (characters.count < (i + 1)) {
                    nextChar = characters[i + 1];
                }
                
                if ("\(char)\(nextChar)" == "EE") {
                    imageName = "4.png";
                }
                else if ("\(char)\(nextChar)" == "QW") {
                    imageName = "8.png";
                }
                else if ("\(char)\(nextChar)" == "CH") || ("\(char)\(nextChar)" == "SH") || (char == "J") {
                    imageName = "10.png";
                }
                else if ("\(char)\(nextChar)" == "TH") {
                    imageName = "11.png";
                }
                else if (char == "O") {
                    imageName = "1.png";
                }
                else if (char == "B") || (char == "M") || (char == "P") {
                    imageName = "2.png";
                }
                else if (char == "A") || (char == "E") || (char == "I") {
                    imageName = "3.png";
                }
                else if (char == "L") {
                    imageName = "5.png";
                }
                else if (char == "F") || (char == "V") {
                    imageName = "6.png";
                }
                else if (char == "R") {
                    imageName = "7.png";
                }
                else if (char == "C") || (char == "D") || (char == "G") || (char == "K") || (char == "N") || (char == "S") || (char == "T") || (char == "X") || (char == "Y") || (char == "Z") {
                    imageName = "9.png";
                }
                else if (char == "U") {
                    imageName = "12.png";
                }
            }
            self.performSelector(onMainThread: #selector(self.executeChar), with: imageName, waitUntilDone: true);
        }
    }
    
    // MARK: Other Methods
    @objc func executeChar(imageName: String) {
        self.imageView.image = UIImage(named: imageName);
    }
}
