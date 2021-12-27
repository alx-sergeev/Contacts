//
//  ContactAddViewController.swift
//  Contacts
//
//  Created by Сергеев Александр on 07.12.2021.
//

import UIKit

class ContactAddViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var contactName: UITextField!
    @IBOutlet weak var contactLastName: UITextField!
    
    // MARK: - Properties
    weak var delegateList: ContactsListViewControllerDelegate? // Делегат View Controller-а экрана со списком контактов
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Для работы методов протокола-делегата UITextFieldDelegate
        contactName.delegate = self
        contactLastName.delegate = self
        
        // Ввод текста в полях для ввода с заглавной буквы
        contactName.autocapitalizationType = UITextAutocapitalizationType.sentences
        contactLastName.autocapitalizationType = UITextAutocapitalizationType.sentences
        
        // Делаем поле для ввода имени первым ответчиком в Responder Chain (цепочка ответчиков)
        // В процессе чего показывается клавиатура
        contactName.becomeFirstResponder()
    }
    
    // Действие при нажатии на кнопку "Отменить"
    // Закрываем экран
    @IBAction func cancelAddAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    // Скрываем клавиатуру при тапе по экрану
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // Действие при нажатии на кнопку "Готово"
    // Добавляем контакт с помощью делегата экрана со списком контактов
    // Закрываем экран
    @IBAction func addContactAction(_ sender: Any) {
        delegateList?.addContact(contact: Contact(name: contactName.text, lastName: contactLastName.text))

        dismiss(animated: true, completion: nil)
    }
}

// Расширяем тип ContactAddViewController, реализуем методы делегата UITextFieldDelegate
extension ContactAddViewController: UITextFieldDelegate {
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
    // делаем проверку на пустоту
    // И если значения не пустые, то делаем кнопку "Готово" активной
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if contactName.text != "" || contactLastName.text != "" {
            doneButton.isEnabled = true
        } else {
            doneButton.isEnabled = false
        }
    }
}
