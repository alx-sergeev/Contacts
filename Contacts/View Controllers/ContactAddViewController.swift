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
        
        contactName.delegate = self
        contactLastName.delegate = self
        
        contactName.becomeFirstResponder()
    }
    
    @IBAction func cancelAddAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension ContactAddViewController: UITextFieldDelegate {
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
        if contactName.text != "" || contactLastName.text != "" {
            doneButton.isEnabled = true
        } else {
            doneButton.isEnabled = false
        }
    }
}
