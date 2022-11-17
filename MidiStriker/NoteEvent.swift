//
//  NoteEvent.swift
//  MidiStriker
//
//  Created by 除村武志 on 2022/10/22.
//

import Foundation

enum NoteEvent: CustomStringConvertible {
    case noteOn(ch: Int, number: Int, velocity: Int)
    case noteOff(ch: Int, number: Int)
    
    var description: String {
        switch self {
        case .noteOn(let ch, let number, let velocity):
            return "NoteON ch: \(ch), number: \(number), velocity: \(velocity)"
        case .noteOff(let ch, let number):
            return "NoteOFF ch: \(ch), number: \(number)"
        }
    }
}
