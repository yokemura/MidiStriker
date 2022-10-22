//
//  MidiHandler.swift
//  MidiStriker
//
//  Created by 除村武志 on 2022/10/22.
//

import Foundation
import CoreMIDI
import os.log

class MIDIHandler {
    var sources = [MIDISourceWrapper]()

    private var client = MIDIClientRef()
    
    init() {
        createMIDIClient()
    }
    
    func createMIDIClient() {
        let name = "Client" as CFString
        let err = MIDIClientCreateWithBlock(name, &client, onMIDIStatusChanged)
        if err != noErr {
            os_log(.error, "Failed to create client")
            return
        }
        os_log("MIDIClient created")
    }
    
    func findMIDISources() {
        let numberOfSources = MIDIGetNumberOfSources()
        os_log("%i Device(s) found", numberOfSources)
        
        sources = (0 ..< numberOfSources).map {
            MIDISourceWrapper(sourceRef: MIDIGetSource($0))
        }
        
        sources.forEach {
            os_log("Device %s: port %s", $0.modelName, $0.portName)
        }
    }

    private func onMIDIStatusChanged(message: UnsafePointer<MIDINotification>) {
        os_log("MIDI Status changed!")
    }
    
}
