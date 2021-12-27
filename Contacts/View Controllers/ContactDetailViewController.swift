//
//  ContactDetailViewController.swift
//  Contacts
//
//  Created by Сергеев Александр on 08.12.2021.
//

import UIKit

// Делегат детального экрана контакта
protocol ContactsDetailViewControllerDelegate: AnyObject {
    func editContact(at index: Int, name: String, lastName: String)
}

class ContactDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var fullNameLabel: UILabel!
    
    // MARK: - Properties
    let storageManager = StorageManager.shared
    lazy var getContacts = storageManager.getContacts() // Список контактов
    var currentContactId: Int? // Индекс контакта в массиве
    let segueToContactEdit = "toContactEditVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Прописываем ФИО в label
        if let contactId = currentContactId {
            let contact = getContacts[contactId]
            
            fullNameLabel.text = contact.fullName
        }
    }
    
    // Передаем данные на следующий экран
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case segueToContactEdit: // Экран редактирования контакта
            guard let navigationController = segue.destination as? UINavigationController else { return }
            guard let contactEditVC = navigationController.viewControllers.first as? ContactEditViewController else { return }

            contactEditVC.delegateDetail = self
            contactEditVC.currentContactId = currentContactId
        default:
            break
        }
    }
}

extension ContactDetailViewController: ContactsDetailViewControllerDelegate {
    func editContact(at index: Int, name: String, lastName: String) {
        let _ = storageManager.editContact(at: index, name: name, lastName: lastName)
        
        updateUI()
    }
    
    // Метод обновляет UI,
    // а именно ФИО контакта
    func updateUI() {
        getContacts = StorageManager.shared.getContacts()
        
        if let contactId = currentContactId {
            let contact = getContacts[contactId]
            
            fullNameLabel.text = contact.fullName
        }
    }
}
