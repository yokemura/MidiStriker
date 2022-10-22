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
    
    var handler: MIDIManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handler = MIDIManager(onSourceChanged: onSourceChanged,
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
        
    }
}

extension ViewController: NSComboBoxDelegate, NSComboBoxDataSource, NSComboBoxCellDataSource {
    func comboBoxSelectionDidChange(_ notification: Notification) {
        let index = sourceCombo.indexOfSelectedItem
        os_log("Combo box index = %d", index)
        guard let handler = handler,
              index >= 0, index < handler.sources.count else {
            return
        }
        
        let source = handler.sources[index]
        handler.startObserving(source: source)
    }
    
    func numberOfItems(in comboBox: NSComboBox) -> Int {
        return handler?.sources.count ?? 0
    }

    func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
        handler?.sources[index].modelAndPortName
    }
}


