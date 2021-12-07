//
//  ViewController.swift
//  Contacts
//
//  Created by Сергеев Александр on 07.12.2021.
//

import UIKit

class ContactsListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    let cellName = "contactCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
    }

}

extension ContactsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)
        var cellConfiguration = cell.defaultContentConfiguration()
        
        cellConfiguration.text = "Contact"
        
        cell.contentConfiguration = cellConfiguration
        
        return cell
    }
}

