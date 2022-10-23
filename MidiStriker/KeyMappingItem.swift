//
//  KeyMappingItem.swift
//  MidiStriker
//
//  Created by 除村武志 on 2022/10/23.
//

import Foundation
import Carbon.HIToolbox
import Sauce

struct KeyMappingItem: Codable {
    // MIDI info to convert from
    let channel: Int?
    let note: Int
    
    // Converted keystroke
    let key: String // human-friendly value
    let modifiers: [String]? // human-friendly value
}

extension KeyMappingItem {
    var keyCode: CGKeyCode? {
        switch key.lowercased() {
        case "a": return Sauce.shared.keyCode(for: .a)
        case "b": return Sauce.shared.keyCode(for: .b)
        case "c": return Sauce.shared.keyCode(for: .c)
        case "d": return Sauce.shared.keyCode(for: .d)
        case "e": return Sauce.shared.keyCode(for: .e)
        case "f": return Sauce.shared.keyCode(for: .f)
        case "g": return Sauce.shared.keyCode(for: .g)
        case "h": return Sauce.shared.keyCode(for: .h)
        case "i": return Sauce.shared.keyCode(for: .i)
        case "j": return Sauce.shared.keyCode(for: .j)
        case "k": return Sauce.shared.keyCode(for: .k)
        case "l": return Sauce.shared.keyCode(for: .l)
        case "m": return Sauce.shared.keyCode(for: .m)
        case "n": return Sauce.shared.keyCode(for: .n)
        case "o": return Sauce.shared.keyCode(for: .o)
        case "p": return Sauce.shared.keyCode(for: .p)
        case "q": return Sauce.shared.keyCode(for: .q)
        case "r": return Sauce.shared.keyCode(for: .r)
        case "s": return Sauce.shared.keyCode(for: .s)
        case "t": return Sauce.shared.keyCode(for: .t)
        case "u": return Sauce.shared.keyCode(for: .u)
        case "v": return Sauce.shared.keyCode(for: .v)
        case "w": return Sauce.shared.keyCode(for: .w)
        case "x": return Sauce.shared.keyCode(for: .x)
        case "y": return Sauce.shared.keyCode(for: .y)
        case "z": return Sauce.shared.keyCode(for: .z)
        case "0": return Sauce.shared.keyCode(for: .zero)
        case "1": return Sauce.shared.keyCode(for: .one)
        case "2": return Sauce.shared.keyCode(for: .two)
        case "3": return Sauce.shared.keyCode(for: .three)
        case "4": return Sauce.shared.keyCode(for: .four)
        case "5": return Sauce.shared.keyCode(for: .five)
        case "6": return Sauce.shared.keyCode(for: .six)
        case "7": return Sauce.shared.keyCode(for: .seven)
        case "8": return Sauce.shared.keyCode(for: .eight)
        case "9": return Sauce.shared.keyCode(for: .nine)
        case "return": return Sauce.shared.keyCode(for: .return)
        case "tab": return Sauce.shared.keyCode(for: .tab)
        case "space": return Sauce.shared.keyCode(for: .space)
        case "delete": return Sauce.shared.keyCode(for: .delete)
        case "escape": return Sauce.shared.keyCode(for: .escape)
        case "f17": return Sauce.shared.keyCode(for: .f17)
        case "f18": return Sauce.shared.keyCode(for: .f18)
        case "f19": return Sauce.shared.keyCode(for: .f19)
        case "f20": return Sauce.shared.keyCode(for: .f20)
        case "f5": return Sauce.shared.keyCode(for: .f5)
        case "f6": return Sauce.shared.keyCode(for: .f6)
        case "f7": return Sauce.shared.keyCode(for: .f7)
        case "f3": return Sauce.shared.keyCode(for: .f3)
        case "f8": return Sauce.shared.keyCode(for: .f8)
        case "f9": return Sauce.shared.keyCode(for: .f9)
        case "f11": return Sauce.shared.keyCode(for: .f11)
        case "f13": return Sauce.shared.keyCode(for: .f13)
        case "f16": return Sauce.shared.keyCode(for: .f16)
        case "f14": return Sauce.shared.keyCode(for: .f14)
        case "f10": return Sauce.shared.keyCode(for: .f10)
        case "f12": return Sauce.shared.keyCode(for: .f12)
        case "f15": return Sauce.shared.keyCode(for: .f15)
        case "help": return Sauce.shared.keyCode(for: .help)
        case "home": return Sauce.shared.keyCode(for: .home)
        case "pageup": return Sauce.shared.keyCode(for: .pageUp)
        case "forwarddelete": return Sauce.shared.keyCode(for: .forwardDelete)
        case "f4": return Sauce.shared.keyCode(for: .f4)
        case "end": return Sauce.shared.keyCode(for: .end)
        case "f2": return Sauce.shared.keyCode(for: .f2)
        case "pagedown": return Sauce.shared.keyCode(for: .pageDown)
        case "f1": return Sauce.shared.keyCode(for: .f1)
        case "leftarrow": return Sauce.shared.keyCode(for: .leftArrow)
        case "rightarrow": return Sauce.shared.keyCode(for: .rightArrow)
        case "downarrow": return Sauce.shared.keyCode(for: .downArrow)
        case "uparrow": return Sauce.shared.keyCode(for: .upArrow)
        case "eisu": return Sauce.shared.keyCode(for: .eisu)
        case "kana": return Sauce.shared.keyCode(for: .kana)
        case "keypadclear": return Sauce.shared.keyCode(for: .keypadClear)
        case "keypadenter": return Sauce.shared.keyCode(for: .keypadEnter)
        case "rightbracket": return Sauce.shared.keyCode(for: .rightBracket)
        case "leftbracket": return Sauce.shared.keyCode(for: .leftBracket)
        case "quote": return Sauce.shared.keyCode(for: .quote)
        case "semicolon": return Sauce.shared.keyCode(for: .semicolon)
        case "backslash": return Sauce.shared.keyCode(for: .backslash)
        case "comma": return Sauce.shared.keyCode(for: .comma)
        case "slash": return Sauce.shared.keyCode(for: .slash)
        case "period": return Sauce.shared.keyCode(for: .period)
        case "grave": return Sauce.shared.keyCode(for: .grave)
        case "yen": return Sauce.shared.keyCode(for: .yen)
        case "underscore": return Sauce.shared.keyCode(for: .underscore)
        case "atsign": return Sauce.shared.keyCode(for: .atSign)
        case "caret": return Sauce.shared.keyCode(for: .caret)
        case "colon": return Sauce.shared.keyCode(for: .colon)
        case "section": return Sauce.shared.keyCode(for: .section)
        case "minus": return Sauce.shared.keyCode(for: .minus)
        case "keypadplus": return Sauce.shared.keyCode(for: .keypadPlus)
        case "]": return Sauce.shared.keyCode(for: .rightBracket)
        case "[": return Sauce.shared.keyCode(for: .leftBracket)
        case "'": return Sauce.shared.keyCode(for: .quote)
        case ";": return Sauce.shared.keyCode(for: .semicolon)
        case "\\": return Sauce.shared.keyCode(for: .backslash)
        case ",": return Sauce.shared.keyCode(for: .comma)
        case "/": return Sauce.shared.keyCode(for: .slash)
        case ".": return Sauce.shared.keyCode(for: .period)
        case "_": return Sauce.shared.keyCode(for: .underscore)
        case "@": return Sauce.shared.keyCode(for: .atSign)
        case "^": return Sauce.shared.keyCode(for: .caret)
        case "-": return Sauce.shared.keyCode(for: .minus)
        case "+": return Sauce.shared.keyCode(for: .keypadPlus)
        default: return nil
        }
    }
}
