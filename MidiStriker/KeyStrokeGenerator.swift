//
//  KeyStrokeGenerator.swift
//  MidiStriker
//
//  Created by 除村武志 on 2022/10/23.
//

import Foundation

class KeyStrokeGenerator {
    static func generate(_ key: CGKeyCode, keyDown: Bool, modifierFlags: CGEventFlags) {
        let source = CGEventSource(stateID: .hidSystemState)
        let event = CGEvent(keyboardEventSource: source, virtualKey: key, keyDown: keyDown)
        event?.flags = modifierFlags
        event?.post(tap: .cghidEventTap)
    }
    
    static func generateKeyDown(_ key: CGKeyCode, modifierFlags: CGEventFlags = []) {
        generate(key, keyDown: true, modifierFlags: modifierFlags)
    }
    
    static func generateKeyUp(_ key: CGKeyCode, modifierFlags: CGEventFlags = []) {
        generate(key, keyDown: false, modifierFlags: modifierFlags)
    }
    
    static func keyDownAndUp(_ key: CGKeyCode, modifierFlags: CGEventFlags = []) {
        generateKeyDown(key, modifierFlags: modifierFlags)
        generateKeyUp(key, modifierFlags: modifierFlags)
    }
}
