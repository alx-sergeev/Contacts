//
//  ViewController.swift
//  Contacts
//
//  Created by Сергеев Александр on 07.12.2021.
//

import UIKit

protocol ContactsListViewControllerDelegate: AnyObject {
    func addContact(name: String, lastName: String)
}

class ContactsListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    let cellName = "contactCell"
    let segueToContactAdd = "toContactAddVC"
    var getContacts = Contact.getContacts()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == segueToContactAdd else { return }
        guard let navigationController = segue.destination as? UINavigationController else { return }
        guard let contactAddVC = navigationController.viewControllers.first as? ContactAddViewController else { return }
        
        contactAddVC.delegate = self
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
    }
}

extension ContactsListViewController: ContactsListViewControllerDelegate {
    func addContact(name: String, lastName: String) {
        getContacts.append(Contact(name: name, lastName: lastName))

        self.tableView.reloadData()
    }
}
