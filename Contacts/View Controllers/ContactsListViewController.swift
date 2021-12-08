//
//  ViewController.swift
//  Contacts
//
//  Created by Сергеев Александр on 07.12.2021.
//

import UIKit

protocol ContactsListViewControllerDelegate: AnyObject {
    func addContact(name: String, lastName: String)
    
    func editContact(row: Int, name: String, lastName: String)
}

class ContactsListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    let cellName = "contactCell"
    let segueToContactAdd = "toContactAddVC"
    let segueToContactDetail = "toContactDetail"
    var getContacts = Contact.getContacts()
    var currentContactId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case segueToContactAdd:
            guard let navigationController = segue.destination as? UINavigationController else { return }
            guard let contactAddVC = navigationController.viewControllers.first as? ContactAddViewController else { return }
            
            contactAddVC.delegate = self
        case segueToContactDetail:
            guard let contactDetailVC = segue.destination as? ContactDetailViewController else { return }
            
            contactDetailVC.getContacts = getContacts
            contactDetailVC.currentContactId = currentContactId
        default:
            break
        }
    }

}

extension ContactsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)
        var cellConfiguration = cell.defaultContentConfiguration()
        
        cellConfiguration.text = getContacts[indexPath.row].fullName
        
        cell.contentConfiguration = cellConfiguration
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        currentContactId = indexPath.row
        
        performSegue(withIdentifier: segueToContactDetail, sender: nil)
    }
}

extension ContactsListViewController: ContactsListViewControllerDelegate {
    func addContact(name: String, lastName: String) {
        getContacts.append(Contact(name: name, lastName: lastName))

        self.tableView.reloadData()
    }
    
    func editContact(row: Int, name: String, lastName: String) {
        getContacts[row].name = name
        getContacts[row].lastName = lastName
        
        self.tableView.reloadData()
    }
}
