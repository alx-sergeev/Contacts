//
//  StorageManager.swift - объект по работе с контактами при помощи UserDefaults
//  Contacts
//
//  Created by Сергеев Александр on 25.12.2021.
//

import Foundation

class StorageManager {
    private init() {}
    
    static let shared = StorageManager()
    
    // MARK: - Properties
    let contactKey = "contacts"
    let userDefaults = UserDefaults.standard
    
    // Добавляем контакт
    func addContact(contact: Contact) {
        var contacts = getContacts()
        contacts.append(contact)
        
        userDefaults.set(contacts, forKey: contactKey)
    }
    
    // Удаляем контакт
    func deleteContact(at index: Int) {
        var contacts = getContacts()
        contacts.remove(at: index)
        
        userDefaults.set(contacts, forKey: contactKey)
    }
    
    // Получаем список контактов
    func getContacts() -> [Contact] {
        if let contacts = userDefaults.value(forKey: contactKey) as? [Contact] {
            return contacts
        }
        
        return []
    }
}
