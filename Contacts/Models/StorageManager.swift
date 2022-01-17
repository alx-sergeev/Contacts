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
    private let contactKey = "contacts"
    private let userDefaults = UserDefaults.standard
    
    // Получаем список контактов
    func getContacts() -> [Contact] {
        guard let data = userDefaults.value(forKey: contactKey) as? Data,
              let contacts = try? JSONDecoder().decode([Contact].self, from: data) else { return [] }
        
        return contacts
    }
    
    // Добавляем контакт
    func addContact(contact: Contact, at index: Int? = nil) -> Bool {
        var contacts = getContacts()
        
        if let index = index {
            contacts.insert(contact, at: index)
        } else {
            contacts.append(contact)
        }
        
        guard let data = try? JSONEncoder().encode(contacts) else { return false }
        userDefaults.set(data, forKey: contactKey)
        
        return true
    }
    
    // Удаляем контакт
    func deleteContact(at index: Int) -> Contact? {
        var contacts = getContacts()
        let currentContact = contacts.remove(at: index)
        guard let data = try? JSONEncoder().encode(contacts) else { return nil }
        
        userDefaults.set(data, forKey: contactKey)
        
        return currentContact
    }
    
    // Изменяет фио контакта
    func editContact(at index: Int, name: String, lastName: String) -> Bool {
        var contacts = getContacts()
        contacts[index].name = name
        contacts[index].lastName = lastName
        
        guard let data = try? JSONEncoder().encode(contacts) else { return false }
        
        userDefaults.set(data, forKey: contactKey)
        
        return true
    }
}
