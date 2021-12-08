//
//  ContactDetailViewController.swift
//  Contacts
//
//  Created by Сергеев Александр on 08.12.2021.
//

import UIKit

protocol ContactsDetailViewControllerDelegate: AnyObject {
    func editContact(row: Int, name: String, lastName: String)
}

class ContactDetailViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var fullNameLabel: UILabel!
    
    // MARK: - Properties
    weak var delegateList: ContactsListViewControllerDelegate?
    var getContacts: [Contact]?
    var currentContactId: Int?
    let segueToContactEdit = "toContactEditVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let contactId = currentContactId, let contact = getContacts?[contactId] {
            fullNameLabel.text = contact.fullName
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case segueToContactEdit:
            guard let navigationController = segue.destination as? UINavigationController else { return }
            guard let contactEditVC = navigationController.viewControllers.first as? ContactEditViewController else { return }
            
            contactEditVC.delegateDetail = self
            contactEditVC.getContacts = getContacts
            contactEditVC.currentContactId = currentContactId
        default:
            break
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let arContacts = getContacts {
            delegateList?.newContacts(arContacts)
        }
    }
    
}

extension ContactDetailViewController: ContactsDetailViewControllerDelegate {
    func editContact(row: Int, name: String, lastName: String) {
        getContacts?[row].name = name
        getContacts?[row].lastName = lastName
        
        updateUI()
    }
    
    func updateUI() {
        if let contactId = currentContactId, let contact = getContacts?[contactId] {
            fullNameLabel.text = contact.fullName
        }
    }
}
