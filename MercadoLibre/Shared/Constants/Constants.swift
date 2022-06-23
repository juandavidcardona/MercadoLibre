//
//  Constants.swift
//  MercadoLibre
//
//  Created by Juan on 22/06/22.
//

import UIKit

enum Constants {
    static let emptyString = ""
    
    enum Animation: TimeInterval {
        case generalAnimateDuration = 0.3
    }
    
    enum CornerRadius: CGFloat {
        case small = 6
        case medium = 10
        case large = 25
    }

    enum BorderWidth: CGFloat {
        case small = 0.7
        case medium = 1
        case large = 2
    }
}
