//
//  ContactAddViewController.swift
//  Contacts
//
//  Created by Сергеев Александр on 07.12.2021.
//

import UIKit

class ContactAddViewController: UIViewController {
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var contactName: UITextField!
    @IBOutlet weak var contactLastName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactName.becomeFirstResponder()
    }
    
    @IBAction func cancelAddAction(_ sender: Any) {
        dismiss(animated: true)
    }
}
