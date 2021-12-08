//
//  Contact.swift
//  Contacts
//
//  Created by Сергеев Александр on 07.12.2021.
//

struct Contact {
    var name: String?
    var lastName: String?
    var fullName: String {
        return "\(name ?? "") \(lastName ?? "")"
    }
}

extension Contact {
    static func getContacts() -> [Contact] {
        return []
    }
}
