//
//  Localization.swift
//  ledger-wallet-ios
//
//  Created by Nicolas Bigot on 12/01/2015.
//  Copyright (c) 2015 Ledger. All rights reserved.
//

import Foundation

func localizedString(key: String) -> String {
    if key.hasPrefix("_") {
        return key
    }
    return NSLocalizedString(key, comment: "")
}