//
//  MidiManager.swift
//  MidiStriker
//
//  Created by 除村武志 on 2022/10/22.
//

import Foundation
import CoreMIDI
import os.log

class MIDIManager {
    var sources = [MIDISource]()
    var currentPort: MIDIInputPort?

    private var client = MIDIClientRef()
    
    private var onSourceChanged: () -> Void
    private var onNoteEvent: (NoteEvent) -> Void
    
    init(onSourceChanged: @escaping () -> Void,
         onNoteEvent: @escaping (NoteEvent) -> Void) {
        
        self.onSourceChanged = onSourceChanged
        self.onNoteEvent = onNoteEvent
        
        createMIDIClient()
        findMIDISources()
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
            MIDISource(sourceRef: MIDIGetSource($0))
        }
        
        sources.forEach {
            os_log("Device %s: port %s", $0.modelName, $0.portName)
        }
        onSourceChanged()
    }
    
    func startObserving(source: MIDISource) {
        currentPort = MIDIInputPort(client: client,
                                    source: source,
                                    onReceived: onMIDIEventReceived)
    }

    private func onMIDIStatusChanged(message: UnsafePointer<MIDINotification>) {
        switch message.pointee.messageID {
        case .msgObjectAdded, .msgObjectRemoved:
            os_log("Object added or removed")
            findMIDISources()
        default:
            break
        }
    }
    
    private func onMIDIEventReceived(event: MIDIPacketList) {
        os_log("onMIDIEventReceived")
    }
    
}
