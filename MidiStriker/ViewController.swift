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
    var keyMap: KeyMapping?
    
    let mapping = """
{
    "mapping": [
        {"note": 48, "key": "a"},
        {"note": 49, "key": "b"},
        {"note": 50, "key": "space"}
    ]
}
"""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = MIDIManager(onSourceChanged: onSourceChanged,
                              onNoteEvent: onNoteEventReceived)
        
        let decoder = JSONDecoder()
        let data = mapping.data(using: .utf8)!
        
        keyMap = try! decoder.decode(KeyMapping.self, from: data)
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
        case .noteOn(let ch, let number, _):
            if let item = keyMap?.item(forNote: number, channel: ch) {
                KeyStrokeGenerator.generateKeyDown(item.keyCode)
            }
        case .noteOff(let ch, let number):
            if let item = keyMap?.item(forNote: number, channel: ch) {
                KeyStrokeGenerator.generateKeyUp(item.keyCode)
            }
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


