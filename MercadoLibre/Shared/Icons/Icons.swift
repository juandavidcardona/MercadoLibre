//
//  Icons.swift
//  MercadoLibre
//
//  Created by Juan on 22/06/22.
//

import Foundation
import UIKit

enum Icons: String {
    case freeShipping = "free-shipping-icon"
    case location = "location-icon"

    var icon: UIImage? {
        return UIImage(named: self.rawValue)
    }
}
