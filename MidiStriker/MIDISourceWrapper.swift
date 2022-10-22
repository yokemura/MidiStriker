//
//  MIDISourceWrapper.swift
//  MidiStriker
//
//  Created by 除村武志 on 2022/10/22.
//

import Foundation
import CoreMIDI

struct MIDISourceWrapper {
    let sourceRef: MIDIEndpointRef
    
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
