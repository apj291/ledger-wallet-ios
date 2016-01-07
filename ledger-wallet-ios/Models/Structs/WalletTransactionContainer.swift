//
//  WalletTransactionContainer.swift
//  ledger-wallet-ios
//
//  Created by Nicolas Bigot on 14/12/2015.
//  Copyright © 2015 Ledger. All rights reserved.
//

import Foundation

struct WalletTransactionContainer {
    
    let transaction: WalletTransaction
    let inputs: [WalletTransactionInputType]
    let outputs: [WalletTransactionOutput]

    var allAddresses: [String] {
        var addresses: [String] = []
        
        for input in inputs {
            if let regularInput = input as? WalletTransactionRegularInput, address = regularInput.address where !addresses.contains(address) {
                addresses.append(address)
            }
        }
        for output in outputs {
            if let address = output.address where !addresses.contains(address) {
                addresses.append(address)
            }
        }
        return addresses
    }
    
    var regularInputs: [WalletTransactionRegularInput] {
        return inputs.flatMap({ $0 as? WalletTransactionRegularInput })
    }
    
    // MARK: Initialization
    
    init(transaction: WalletTransaction, inputs: [WalletTransactionInputType], outputs: [WalletTransactionOutput]) {
        self.transaction = transaction
        self.inputs = inputs
        self.outputs = outputs
    }

}

// MARK: - JSONInitializableModel

extension WalletTransactionContainer: JSONInitializableModel {
    
    init?(JSONObject: [String : AnyObject]) {
        guard let
            transaction = WalletTransaction(JSONObject: JSONObject),
        	inputs = JSONObject["inputs"] as? [[String: AnyObject]],
            outputs = JSONObject["outputs"] as? [[String: AnyObject]]
        else {
            return nil
        }
        
        let finalOutputs = WalletTransactionOutput.collectionFromJSONArray(outputs)
        var finalInputs: [WalletTransactionInputType] = []
        for input in inputs {
            if let regularInput = WalletTransactionRegularInput(JSONObject: input) {
                finalInputs.append(regularInput)
            }
            else if let coinbaseInput = WalletTransactionCoinbaseInput(JSONObject: input) {
                finalInputs.append(coinbaseInput)
            }
        }
        
        guard finalOutputs.count > 0 && finalInputs.count > 0 else {
            return nil
        }
    
        self.transaction = transaction
        self.inputs = finalInputs
        self.outputs = finalOutputs
    }
    
}