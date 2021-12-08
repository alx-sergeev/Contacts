//
//  ContactDetailViewController.swift
//  Contacts
//
//  Created by Сергеев Александр on 08.12.2021.
//

import UIKit

class ContactDetailViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var fullNameLabel: UILabel!
    
    // MARK: - Properties
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
            
            contactEditVC.getContacts = getContacts
            contactEditVC.currentContactId = currentContactId
        default:
            break
        }
    }
    
}
