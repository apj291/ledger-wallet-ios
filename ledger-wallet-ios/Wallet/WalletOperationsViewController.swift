//
//  WalletOperationsViewController.swift
//  ledger-wallet-ios
//
//  Created by Nicolas Bigot on 19/01/2016.
//  Copyright © 2016 Ledger. All rights reserved.
//

import Foundation

class WalletOperationsViewController: BaseViewController {
    
    var walletManager: WalletManagerType?
    var account: WalletAccount?
    private var fetchRequest: WalletFetchRequest<WalletVisibleAccountOperationsFetchRequestProvider>?
    private var operations: [WalletAccountOperationContainer] = []
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateModel()
    }
    
    private func updateModel(wantsNew: Bool = false) {
        walletManager?.fetchRequestBuilder.accountOperationsFetchRequestForAccountAtIndex(account!.index, incrementSize: 20, order: .Descending) { fetchRequest in
            self.fetchRequest = fetchRequest
            self.fetchRequest?.objectsInRange(0 ..< (wantsNew ? self.operations.count + 20 : 20)) { objects in
                self.operations.appendContentsOf(objects!)
                self.tableView.reloadData()
            }
        }
    }
    
}

extension WalletOperationsViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operations.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OperationCell", forIndexPath: indexPath)
        return cell
    }
    
}

extension WalletOperationsViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let operation = operations[indexPath.row]
        cell.textLabel?.text = operation.operationContainer.operation.kind.rawValue + " " + operation.operationContainer.transactionContainer.transaction.receiveAt
        cell.detailTextLabel?.text = String(operation.operationContainer.operation.amount)
        
        if indexPath.row == operations.count - 1 && operations.count < fetchRequest!.numberOfObjects {
            updateModel(true)
        }
    }
    
}