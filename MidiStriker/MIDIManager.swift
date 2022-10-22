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
                                    onReceived: onMIDIMessageReceived)
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
    
    func onMIDIMessageReceived(message: UnsafePointer<MIDIPacketList>, srcConnRefCon: UnsafeMutableRawPointer?) {

        let packetList: MIDIPacketList = message.pointee
        let n = packetList.numPackets
        //os_log("%i MIDI Message(s) Received", n)

        var packet = packetList.packet
        for _ in 0 ..< n {
            // Handle MIDIPacket
            let mes: UInt8 = packet.data.0 & 0xF0
            let ch: UInt8 = packet.data.0 & 0x0F
            if mes == 0x90 && packet.data.2 != 0 {
                // Note On
                let noteNo = packet.data.1
                let velocity = packet.data.2
                DispatchQueue.main.async {
                    self.onNoteEvent(.noteOn(ch: Int(ch), number: Int(noteNo), velocity: Int(velocity)))
                }
            } else if (mes == 0x80 || mes == 0x90) {
                // Note Off
                let noteNo = packet.data.1
                // let velocity = packet.data.2
                DispatchQueue.main.async {
                    self.onNoteEvent(.noteOff(ch: Int(ch), number: Int(noteNo)))
                }
            }
            let packetPtr = MIDIPacketNext(&packet)
            packet = packetPtr.pointee
        }
    }
    
}
