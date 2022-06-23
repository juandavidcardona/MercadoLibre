//
//  Strings.swift
//  MercadoLibre
//
//  Created by Juan on 22/06/22.
//

import Foundation

enum Strings: String {
    
    case generalErrorTitle = "GENERAL_ERROR_TITLE"
    case generalErrorMessage = "GENERAL_ERROR_MESSAGE"
    case generalFreeShipping = "GENERAL_FREE_SHIPPING"
    
    // this could be moved to another file.
    case welcomeMessage = "HOME_WELCOME_MESSAGE"
    case searchPlaceholder = "HOME_SEARCH_PLACEHOLDER"
    case sortRelevant = "HOME_SORT_RELEVANT_TITLE"
    case sortLowerPrice = "HOME_SORT_LOWER_PRICE_TITLE"
    case sortHeighterPrice = "HOME_SORT_HIGHTER_PRICE_TITLE"
    
    var localized: String {
        NSLocalizedString(
            self.rawValue,
            tableName: "Strings",
            bundle: Bundle.main, value: Constants.emptyString,
            comment: Constants.emptyString)
    }
}
