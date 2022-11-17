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
{"mapping": [
{"note": 35, "key": "0"},
{"note": 36, "key": "a"},
{"note": 37, "key": "b"},
{"note": 38, "key": "c"},
{"note": 39, "key": "d"},
{"note": 40, "key": "e"},
{"note": 41, "key": "f"},
{"note": 42, "key": "g"},
{"note": 43, "key": "h"},
{"note": 44, "key": "i"},
{"note": 45, "key": "j"},
{"note": 46, "key": "k"},
{"note": 47, "key": "l"},
{"note": 48, "key": "m"},
{"note": 49, "key": "n"},
{"note": 50, "key": "o"},
{"note": 51, "key": "p"},
{"note": 52, "key": "q"},
{"note": 53, "key": "r"},
{"note": 54, "key": "s"},
{"note": 55, "key": "t"},
{"note": 56, "key": "u"},
{"note": 57, "key": "v"},
{"note": 58, "key": "w"},
{"note": 59, "key": "x"},
{"note": 60, "key": "y"},
{"note": 61, "key": "z"},
{"note": 72, "key": "0"},
{"note": 73, "key": "1"},
{"note": 74, "key": "2"},
{"note": 75, "key": "3"},
{"note": 76, "key": "4"},
{"note": 77, "key": "5"},
{"note": 78, "key": "6"},
{"note": 79, "key": "7"},
{"note": 80, "key": "8"},
{"note": 81, "key": "9"},
{"note": 82, "key": "-"},
{"note": 83, "key": "/"},
{"note": 95, "key": "return"},
{"note": 96, "key": "space"}
]}
"""
    
    private var preferredDeviceName: String? {
        get {
            UserDefaults.standard.string(forKey: "preferredDeviceName")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "preferredDeviceName")
        }
    }
    
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
        updateSource()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func onSourceChanged() {
        updateSource()
    }
    
    private func updateSource() {
        guard let pref = preferredDeviceName,
              let manager = manager else {
            return
        }
        let isFound = manager.selectSourceByName(pref)
        
        if isFound {
            sourceCombo.stringValue = pref
        } else {
            sourceCombo.stringValue = "(Not connected) \(pref)"
        }
    }
    
    func onNoteEventReceived(event: NoteEvent) {
        switch event {
        case .noteOn(let ch, let number, _):
            textField.stringValue = "\(event)"
            if let item = keyMap?.item(forNote: number, channel: ch),
               let keyCode = item.keyCode {
                KeyStrokeGenerator.generateKeyDown(keyCode)
                textField.stringValue += " -> key[\(item.key)]"
            }
        case .noteOff(let ch, let number):
            if let item = keyMap?.item(forNote: number, channel: ch),
               let keyCode = item.keyCode {
                KeyStrokeGenerator.generateKeyUp(keyCode)
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
        preferredDeviceName = source.modelAndPortName
    }
    
    func numberOfItems(in comboBox: NSComboBox) -> Int {
        return manager?.sources.count ?? 0
    }

    func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
        manager?.sources[index].modelAndPortName
    }
}


