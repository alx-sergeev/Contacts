//
//  ContactEditViewController.swift
//  Contacts
//
//  Created by Сергеев Александр on 08.12.2021.
//

import UIKit

class ContactEditViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var contactName: UITextField!
    @IBOutlet weak var contactLastName: UITextField!
    
    // MARK: - Properties
    var getContacts: [Contact]?
    var currentContactId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let contactId = currentContactId, let contact = getContacts?[contactId] {
            contactName.text = contact.name
            contactLastName.text = contact.lastName
        }
    }

    @IBAction func cancelEditAction(_ sender: Any) {
        dismiss(animated: false)
    }
}
