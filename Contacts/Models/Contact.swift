//
//  Contact.swift
//  Contacts
//
//  Created by Сергеев Александр on 07.12.2021.
//

// Модель для работы с контактами
struct Contact {
    var name: String?
    var lastName: String?
    var fullName: String {
        return "\(name ?? "") \(lastName ?? "")"
    }
}

extension Contact {
    // Получаем список контактов, по умолчанию пустой массив
    static func getContacts() -> [Contact] {
        return []
    }
}
