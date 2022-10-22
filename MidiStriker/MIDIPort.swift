//
//  MIDIPort.swift
//  MidiStriker
//
//  Created by 除村武志 on 2022/10/22.
//

import Foundation
import CoreMIDI
import os.log

class MIDIInputPort {
    private var portRef = MIDIPortRef()
    private let source: MIDISource
    private let onReceived: (MIDIPacketList) -> Void
    
    init(client: MIDIClientRef, source: MIDISource, onReceived: @escaping (MIDIPacketList) -> Void) {
        self.onReceived = onReceived
        self.source = source
        
        let portName = source.portName as CFString
        let err = MIDIInputPortCreateWithBlock(client, portName, &portRef, onMIDIMessageReceived)
        if err != noErr {
            os_log("Failed to create input port")
            return
        }
        os_log("MIDIInputPort created")
        
        let src = source.sourceRef
        let err2 = MIDIPortConnectSource(portRef, src, nil)
        if err2 != noErr {
            os_log("Failed to connect MIDIEndpoint")
            return
        }
        os_log("MIDIEndpoint connected to InputPort")
        
        func onMIDIMessageReceived(message: UnsafePointer<MIDIPacketList>, srcConnRefCon: UnsafeMutableRawPointer?) {
            os_log("MIDI Message Received")
        }
    }
    
    deinit {
        MIDIPortDisconnectSource(portRef, source.sourceRef)
        MIDIPortDispose(portRef)
        os_log("MIDI Port Disposed")
    }
}
