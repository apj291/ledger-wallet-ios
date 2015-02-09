//
//  PairingTransactionInfo.swift
//  ledger-wallet-ios
//
//  Created by Nicolas Bigot on 09/02/2015.
//  Copyright (c) 2015 Ledger. All rights reserved.
//

import Foundation

class PairingTransactionInfo: Equatable {
    
    let pinCode: String
    let recipientAddress: String
    let changeAmount: Bitcoin.Amount
    let feesAmount: Bitcoin.Amount
    let outputsAmount: Bitcoin.Amount
    
    private let pinBytesLength = 4
    private let feesBytesLength = 8
    private let outputsBytesLength = 8
    private let changeBytesLength = 8
    private let recipientByteLength = 1
    
    init?(decryptedBlob: NSData) {
        // get transaction data
        var offset = 0
        let pinCodeData = decryptedBlob.subdataWithRange(NSMakeRange(offset, pinBytesLength)); offset += pinBytesLength
        let outputsData = decryptedBlob.subdataWithRange(NSMakeRange(offset, outputsBytesLength)); offset += outputsBytesLength
        let feesData = decryptedBlob.subdataWithRange(NSMakeRange(offset, feesBytesLength)); offset += feesBytesLength
        let changeData = decryptedBlob.subdataWithRange(NSMakeRange(offset, changeBytesLength)); offset += changeBytesLength
        let recipientDataLengthData = decryptedBlob.subdataWithRange(NSMakeRange(offset, recipientByteLength)); offset += recipientByteLength
        let recipientBytesLength = Int(UnsafePointer<UInt8>(recipientDataLengthData.bytes).memory)
        let recipientData = decryptedBlob.subdataWithRange(NSMakeRange(offset, recipientBytesLength)); offset += recipientBytesLength
        
        // validate recipient address
        let recipientAddress = Crypto.Data.stringFromData(recipientData)
        if Bitcoin.Address.verifyPublicAddress(recipientAddress) == true {
            self.recipientAddress = recipientAddress
            self.pinCode = Crypto.Data.stringFromData(pinCodeData)
            self.changeAmount = BTCBigNumber(unsignedData: changeData).int64value
            self.feesAmount = BTCBigNumber(unsignedData: feesData).int64value
            self.outputsAmount = BTCBigNumber(unsignedData: outputsData).int64value
        }
        else {
            self.recipientAddress = ""
            self.pinCode = ""
            self.changeAmount = 0
            self.feesAmount = 0
            self.outputsAmount = 0
            return nil
        }
    }
    
}

func ==(lhs: PairingTransactionInfo, rhs: PairingTransactionInfo) -> Bool {
    return true
}