//
//  ViewController.swift
//  MidiStriker
//
//  Created by 除村武志 on 2022/10/22.
//

import Cocoa
import os.log

class ViewController: NSViewController {
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var sourceCombo: NSComboBox!
    
    var manager: MIDIManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = MIDIManager(onSourceChanged: onSourceChanged,
                              onNoteEvent: onNoteEventReceived)
    }
    
    override func viewDidAppear() {
        textField.stringValue = "ready"
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func onSourceChanged() {
    }
    
    func onNoteEventReceived(event: NoteEvent) {
        textField.stringValue = "noteEvent: \(event)"
        switch event {
        case .noteOn(let ch, let number, let velocity):
            KeyStrokeGenerator.generateKeyDown(14)
        case .noteOff(let ch, let number):
            KeyStrokeGenerator.generateKeyUp(14)
        }
    }
}

extension ViewController: NSComboBoxDelegate, NSComboBoxDataSource, NSComboBoxCellDataSource {
    func comboBoxSelectionDidChange(_ notification: Notification) {
        let index = sourceCombo.indexOfSelectedItem
        os_log("Combo box index = %d", index)
        guard let manager = manager,
              index >= 0, index < manager.sources.count else {
            return
        }
        
        let source = manager.sources[index]
        manager.startObserving(source: source)
    }
    
    func numberOfItems(in comboBox: NSComboBox) -> Int {
        return manager?.sources.count ?? 0
    }

    func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
        manager?.sources[index].modelAndPortName
    }
}


