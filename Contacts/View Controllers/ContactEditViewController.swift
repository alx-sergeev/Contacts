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
    weak var delegateDetail: ContactsDetailViewControllerDelegate? // Делегат View Controller-а экрана со списком контактов
    let storageManager = StorageManager.shared
    lazy var getContacts = storageManager.getContacts() // Список контактов
    var currentContactId: Int? // Индекс контакта в массиве
    var oldName: String? // Предыдущее содержимое поля Имя
    var oldLastName: String? // Предыдущее содержимое поля Фамилия
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Подставляем данные в поля Имя, Фамилия
        if let contactId = currentContactId {
            let contact = getContacts[contactId]
            
            oldName = contact.name
            contactName.text = contact.name
            
            oldLastName = contact.lastName
            contactLastName.text = contact.lastName
        }
        
        // Для работы методов протокола-делегата UITextFieldDelegate
        contactName.delegate = self
        contactLastName.delegate = self
    }

    // Закрываем экран при клике на кнопку "Отменить"
    @IBAction func cancelEditAction(_ sender: Any) {
        dismiss(animated: false)
    }
    
    // Действие при клике на кнопку "Готово"
    // Изменяем данные текущего контакта с помощью делегата, закрываем экран
    @IBAction func editContactAction(_ sender: Any) {
        guard let rowId = currentContactId else { return }
        guard let name = contactName.text, let lastName = contactLastName.text else { return }
        
        delegateDetail?.editContact(at: rowId, name: name, lastName: lastName)

        dismiss(animated: true, completion: nil)
    }
}

// Расширяем тип ContactEditViewController, реализуем методы делегата UITextFieldDelegate
extension ContactEditViewController: UITextFieldDelegate {
    // Обработка кнопки "Ввод" или "return"
    // При нажатии переходим в следующее поле для ввода
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
    
    // При изменении в полях для ввода,
    // делаем проверку на отличие от прежних значений и на пустоту
    // И если значения отличаются и они не пустые, то делаем кнопку "Готово" активной
    func textFieldDidChangeSelection(_ textField: UITextField) {
        doneButton.isEnabled = false
        
        guard contactName.text != oldName || contactLastName.text != oldLastName else { return }
        guard contactName.text != "" || contactLastName.text != "" else { return }
        
        doneButton.isEnabled = true
    }
}
