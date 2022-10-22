//
//  ViewController.swift
//  MidiStriker
//
//  Created by 除村武志 on 2022/10/22.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var textField: NSTextField!
    
    let handler = MIDIHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear() {
        textField.stringValue = "ready"
        
        handler.findMIDISources()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}



