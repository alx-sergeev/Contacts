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
    var currentContact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let contact = currentContact {
            fullNameLabel.text = contact.fullName
        }
    }
    
}
