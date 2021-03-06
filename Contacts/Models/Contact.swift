//
//  Contact.swift
//  Contacts
//
//  Created by Сергеев Александр on 07.12.2021.
//

// Модель для работы с контактами
struct Contact: Codable {
    var name: String?
    var lastName: String?
    var fullName: String {
        return "\(name ?? "") \(lastName ?? "")"
    }
}
