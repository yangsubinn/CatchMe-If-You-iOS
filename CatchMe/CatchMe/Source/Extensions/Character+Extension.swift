//
//  Character+Extension.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/11.
//

import UIKit

enum Character {
    case blue
    case green
    case orange
    case purple
    case yellowGreen
}

extension Character {
    func getCharacterImage(phase: Int, size: Int) -> UIImage? {
        switch self {
        case .blue:
            return UIImage(named: "colorBluePhase\(phase)Size\(size)")
        case .green:
            return UIImage(named: "colorGreenPhase\(phase)Size\(size)")
        case .orange:
            return UIImage(named: "colorOrangePhase\(phase)Size\(size)")
        case .purple:
            return UIImage(named: "colorPurplePhase\(phase)Size\(size)")
        case .yellowGreen:
            return UIImage(named: "colorYellowgreeenPhase\(phase)Size\(size)")
        }
    }
}
