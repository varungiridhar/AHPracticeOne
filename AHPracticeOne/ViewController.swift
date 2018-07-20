//
//  ViewController.swift
//  AHPracticeOne
//
//  Created by Varun Giridhar on 7/18/18.
//  Copyright © 2018 Varun Giridhar. All rights reserved.
//

import UIKit
import TesseractOCR
class ViewController: UIViewController, G8TesseractDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let input = ""
        var nouns : [String] = []
        var adjectives : [String] = []

        //Tesseract Code
        let tesseract:G8Tesseract = G8Tesseract(language: "eng")
        tesseract.delegate = self as! G8TesseractDelegate
        tesseract.image = UIImage(named: "textone")
        
        
        let options: NSLinguisticTagger.Options = .omitPunctuation
        let schemes = [NSLinguisticTagScheme.tokenType, .lemma, .language, .language, .lexicalClass]
        let tagger = NSLinguisticTagger(tagSchemes: schemes, options: Int(options.rawValue))
        
        let range = NSMakeRange(0, (input as NSString).length)
        tagger.string = input
        
        var parts: [String] = [] // here we put all the parts including spaces and punctuation signs, such that we can reconstruct sentence at any time
        var words: [String] = []
        
        tagger.enumerateTags(
            in: range,
            scheme: NSLinguisticTagScheme.tokenType,
            options: options) {
                
                (tag, tokenRange, _, _) in
                
                let part = (input as NSString).substring(with: tokenRange)
                parts.append(part)
                
                if tag!.rawValue == "Word" {
                    words.append(part)
                }
                
        }
        for index in 0..<words.count{
            var wordide = words[index]
            tagger.string = wordide
            if(tagger.tag(at: 0, scheme: .lexicalClass, tokenRange: nil, sentenceRange: nil)!.rawValue=="Adjective"){
                adjectives.append(wordide)
            }
            if(tagger.tag(at: 0, scheme: .lexicalClass, tokenRange: nil, sentenceRange: nil)!.rawValue=="Noun"){
                nouns.append(wordide)
            }
        }
        
    }
   
    @IBAction func takePhoto(_ sender: Any) {
    }
    @IBAction func savePhoto(_ sender: Any) {
    }
    @IBAction func Gallery(_ sender: Any) {
    }
    
}





