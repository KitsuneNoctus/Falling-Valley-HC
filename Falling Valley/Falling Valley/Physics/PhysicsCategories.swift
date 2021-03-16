//
//  PhysicsCategories.swift
//  Falling Valley
//
//  Created by Henry Calderon on 3/15/21.
//

import Foundation

struct PhysicsCategory {
    static let None:      UInt32 = 0          // 0000000
    static let Climber:      UInt32 = 0b1        // 0000001
    static let Obstacle:    UInt32 = 0b10       // 0000010
    static let Juts:      UInt32 = 0b100      // 0000100
    static let Edge:      UInt32 = 0b1000     // 0001000
}
