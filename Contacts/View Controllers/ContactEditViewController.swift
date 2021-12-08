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
    weak var delegateDetail: ContactsDetailViewControllerDelegate?
    
    var getContacts: [Contact]?
    var currentContactId: Int?
    var oldName: String?
    var oldLastName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let contactId = currentContactId, let contact = getContacts?[contactId] {
            oldName = contact.name
            contactName.text = contact.name
            
            oldLastName = contact.lastName
            contactLastName.text = contact.lastName
        }
        
        contactName.delegate = self
        contactLastName.delegate = self
    }

    @IBAction func cancelEditAction(_ sender: Any) {
        dismiss(animated: false)
    }
    
    
    @IBAction func editContactAction(_ sender: Any) {
        guard let rowId = currentContactId else { return }
        
        delegateDetail?.editContact(row: rowId, name: contactName.text ?? "", lastName: contactLastName.text ?? "")
        dismiss(animated: true, completion: nil)
    }
}

extension ContactEditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case contactName:
            contactLastName.becomeFirstResponder()
        case contactLastName:
            contactName.becomeFirstResponder()
        default:
            break
        }
        
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        doneButton.isEnabled = false
        
        guard contactName.text != oldName || contactLastName.text != oldLastName else { return }
        guard contactName.text != "" || contactLastName.text != "" else { return }
        
        doneButton.isEnabled = true
    }
}
