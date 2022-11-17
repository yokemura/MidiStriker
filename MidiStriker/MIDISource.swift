//
//  MIDISource.swift
//  MidiStriker
//
//  Created by 除村武志 on 2022/10/22.
//

import Foundation
import CoreMIDI

class MIDISource {
    init(sourceRef: MIDIEndpointRef) {
        self.sourceRef = sourceRef
    }
    
    let sourceRef: MIDIEndpointRef
    
    var modelAndPortName: String {
        modelName + " " + portName
    }
    
    var portName: String {
        var cfStr: Unmanaged<CFString>?
        let err = MIDIObjectGetStringProperty(sourceRef, kMIDIPropertyName, &cfStr)
        if err == noErr, let str = cfStr?.takeRetainedValue() as? String {
            return str
        }
        return "Unnamed Port"
    }
    
    var modelName: String {
        var cfStr: Unmanaged<CFString>?
        let err = MIDIObjectGetStringProperty(sourceRef, kMIDIPropertyModel, &cfStr)
        if err == noErr, let str = cfStr?.takeRetainedValue() as? String {
            return str
        }
        return "Unnamed Model"
    }
}
