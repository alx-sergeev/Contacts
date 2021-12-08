//
//  ViewController.swift
//  Contacts
//
//  Created by Сергеев Александр on 07.12.2021.
//

import UIKit

protocol ContactsListViewControllerDelegate: AnyObject {
    func addContact(name: String, lastName: String)
    
    func newContacts(_ newArray: [Contact])
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
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case segueToContactAdd:
            guard let navigationController = segue.destination as? UINavigationController else { return }
            guard let contactAddVC = navigationController.viewControllers.first as? ContactAddViewController else { return }
            
            contactAddVC.delegateList = self
        case segueToContactDetail:
            guard let contactDetailVC = segue.destination as? ContactDetailViewController else { return }
            
            contactDetailVC.delegateList = self
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
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        self.tableView.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            getContacts.remove(at: indexPath.row)
            
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let currentContact = getContacts.remove(at: sourceIndexPath.row)
        
        getContacts.insert(currentContact, at: destinationIndexPath.row)
    }
}

extension ContactsListViewController: ContactsListViewControllerDelegate {
    func addContact(name: String, lastName: String) {
        getContacts.append(Contact(name: name, lastName: lastName))

        self.tableView.reloadData()
    }
    
    func newContacts(_ newArray: [Contact]) {
        getContacts = newArray
        
        self.tableView.reloadData()
    }
}
