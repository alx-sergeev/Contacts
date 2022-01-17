//
//  ViewController.swift
//  Contacts
//
//  Created by Сергеев Александр on 07.12.2021.
//

import UIKit

// Делегат списка контактов
protocol ContactsListViewControllerDelegate: AnyObject {
    func addContact(contact: Contact)
}

class ContactsListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private let cellName = "contactCell"
    private let segueToContactAdd = "toContactAddVC"
    private let segueToContactDetail = "toContactDetail"
    private let storageManager = StorageManager.shared
    private lazy var getContacts = storageManager.getContacts() // Список контактов
    private var currentContactId: Int? // Индекс контакта в массиве

    override func viewDidLoad() {
        super.viewDidLoad()

        // Для реализации механизма делегата,
        // указываем что текущий View Controller реализует протоколы UITableViewDataSource, UITableViewDelegate
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // Добавляем элемент навигации для перехода в режим редактирования и выход из него
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    // Передаем данные вперед
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case segueToContactAdd: // На экран с добавлением контакта
            guard let navigationController = segue.destination as? UINavigationController else { return }
            guard let contactAddVC = navigationController.viewControllers.first as? ContactAddViewController else { return }
            
            contactAddVC.delegateList = self
        case segueToContactDetail: // На экран с детальной контакта
            guard let contactDetailVC = segue.destination as? ContactDetailViewController else { return }
            
            contactDetailVC.currentContactId = currentContactId
        default:
            break
        }
    }
}

extension ContactsListViewController: UITableViewDataSource, UITableViewDelegate {
    // Количество строк в таблице
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getContacts.count
    }
    
    // Конфигурация каждой строки в таблице
    // Выводим полное ФИО
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)
        var cellConfiguration = cell.defaultContentConfiguration()
        
        cellConfiguration.text = getContacts[indexPath.row].fullName
        
        cell.contentConfiguration = cellConfiguration
        
        return cell
    }
    
    // Функционал при клике на строку
    // Переход на экран детальной контакта
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        currentContactId = indexPath.row
        
        performSegue(withIdentifier: segueToContactDetail, sender: nil)
    }
    
    // Добавляем функционал перехода в режим редактирования для таблицы
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        self.tableView.setEditing(editing, animated: animated)
    }
    
    // Стилизация иконки слева от строки в режиме редактирования
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    // Функционал при клике на иконку слева от строки в режиме редактирования
    // Удаляем контакт
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let _ = storageManager.deleteContact(at: indexPath.row)
            
            updateUI()
        }
    }
    
    // Функционал Drag&Drop для строк в режиме редактирования таблицы
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let currentContact = storageManager.deleteContact(at: sourceIndexPath.row) else { return }
        
        let _ = storageManager.addContact(contact: currentContact, at: destinationIndexPath.row)
    }
}

extension ContactsListViewController: ContactsListViewControllerDelegate {
    func addContact(contact: Contact) {
        let _ = storageManager.addContact(contact: contact)
        
        updateUI()
    }
    
    func updateUI() {
        getContacts = storageManager.getContacts()
        
        self.tableView.reloadData()
        
    }
}
