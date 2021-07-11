//
//  Character+Enum.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/11.
//

import Foundation

enum Character {
    case blue
    case green
    case orange
    case purple
    case yellowGreen
}

extension Character {
    func getCharacterImage(phase: Int, size: Int) -> String {
        switch self {
        case .blue:
            return "colorBluePhase\(phase)Size\(size)"
        case .green:
            return "colorGreenPhase\(phase)Size\(size)"
        case .orange:
            return "colorOrangePhase\(phase)Size\(size)"
        case .purple:
            return "colorPurplePhase\(phase)Size\(size)"
        case .yellowGreen:
            return "colorYellowgreeenPhase\(phase)Size\(size)"
        }
    }
}
