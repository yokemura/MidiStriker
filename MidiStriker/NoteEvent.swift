//
//  NoteEvent.swift
//  MidiStriker
//
//  Created by 除村武志 on 2022/10/22.
//

import Foundation

enum NoteEvent {
    case noteOn(number: Int, velocity: Int)
    case noteOff(number: Int)
}
