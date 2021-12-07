//
//  ContactAddViewController.swift
//  Contacts
//
//  Created by Сергеев Александр on 07.12.2021.
//

import UIKit

class ContactAddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = "Testtt"
    }
    
    @IBAction func cancelAddAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
