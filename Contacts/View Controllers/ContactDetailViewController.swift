//
//  ContactDetailViewController.swift
//  Contacts
//
//  Created by Сергеев Александр on 08.12.2021.
//

import UIKit

// Делегат детального экрана контакта
protocol ContactsDetailViewControllerDelegate: AnyObject {
    func editContact(row: Int, name: String, lastName: String)
}

class ContactDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var fullNameLabel: UILabel!
    
    // MARK: - Properties
    weak var delegateList: ContactsListViewControllerDelegate? // Делегат View Controller-а экрана со списком контактов
    var getContacts: [Contact]? // Список контактов
    var currentContactId: Int? // Индекс контакта в массиве
    let segueToContactEdit = "toContactEditVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Прописываем ФИО в label
        if let contactId = currentContactId, let contact = getContacts?[contactId] {
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
            contactEditVC.getContacts = getContacts
            contactEditVC.currentContactId = currentContactId
        default:
            break
        }
    }
    
    // Используем метод жизненного цикла View Controller
    // Когда вьюха захочет закрыться,
    // с помощью механизма делегата передаем данные на экран со списком контактов
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let arContacts = getContacts {
            delegateList?.newContacts(arContacts)
        }
    }
    
}

// Реализуем необходимые методы протокола делегата
extension ContactDetailViewController: ContactsDetailViewControllerDelegate {
    // Изменяет данные контакта
    // и обновляет UI
    func editContact(row: Int, name: String, lastName: String) {
        getContacts?[row].name = name
        getContacts?[row].lastName = lastName
        
        updateUI()
    }
    
    // Метод обновляет UI,
    // а именно ФИО контакта
    func updateUI() {
        if let contactId = currentContactId, let contact = getContacts?[contactId] {
            fullNameLabel.text = contact.fullName
        }
    }
}
