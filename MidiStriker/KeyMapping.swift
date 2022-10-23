//
//  KeyMapping.swift
//  MidiStriker
//
//  Created by 除村武志 on 2022/10/23.
//

import Foundation

struct KeyMapping: Codable {
    let mapping: [KeyMappingItem]
    
    func item(forNote: Int, channel: Int) -> KeyMappingItem? {
        mapping.first { item in
            if let channel = item.channel {
                return item.note == forNote && item.channel == channel
            } else {
                return item.note == forNote
            }
        }
    }
}
