//
//  Character+Extension.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/11.
//

import UIKit

enum Character: Int {
    case green = 1
    case yellowGreen = 2
    case orange = 3
    case blue = 4
    case purple = 5
    case skyblue = 6
    case yellow = 7
    case white = 8
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
        case .skyblue:
            return UIImage(named: "colorSkybluePhase\(phase)Size\(size)")
        case .yellow:
            return UIImage(named: "colorYellowPhase\(phase)Size\(size)")
        case .white:
            return UIImage(named: "colorWhitePhase\(phase)Size\(size)")
        }
    }
}
