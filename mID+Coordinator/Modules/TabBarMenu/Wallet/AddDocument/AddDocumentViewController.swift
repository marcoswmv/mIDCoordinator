//
//  AddDocumentViewController.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 09/04/2024.
//

import UIKit

extension AddDocumentViewController {
    enum Action {
        case finish
    }
}

final class AddDocumentViewController: RootViewController {
    
    var performAction: ((AddDocumentViewController.Action) -> Void)?
    
    deinit {
        print("\(self) deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Adicionar Documento"
    }
    
    @IBAction func didPressFinish(_ sender: UIButton) {
        performAction?(.finish)
    }
}
