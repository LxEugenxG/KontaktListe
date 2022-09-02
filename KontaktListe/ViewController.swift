//
//  ViewController.swift
//  KontaktListe
//
//  Created by Eugen Ganske on 01.09.22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var ContactsList_TableView: UITableView!
    
    var list = ["hallo", "world", "test"]
    var lostList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ContactsList_TableView.dataSource = self
        ContactsList_TableView.delegate = self
 
        }

    @IBAction func addBtnContacts(_ sender: Any) {
        

        let alert = UIAlertController(title: "Kontakt Hinzufügen", message: "", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            self.list.append(textField!.text!)
            self.ContactsList_TableView.reloadData()
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        

    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            if indexPath.section == 0 {
                list.remove(at: indexPath.row)
            }else{
                lostList.remove(at: indexPath.row)
            }
            
            
            ContactsList_TableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    
    
    
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return list.count
        }else {
            return lostList.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ContactsList_TableView.dequeueReusableCell(withIdentifier: "list_item", for: indexPath)
        var content = cell.defaultContentConfiguration()
        if indexPath.section == 0 {
            content.text = list[indexPath.row]
        }else {
            content.text = lostList[indexPath.row]
            
        }
        cell.contentConfiguration = content
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Kontakte"
        }else {return "Verpasster Anruf"}
    }
    
    //indexpath enthält informationen über die betrachtete zelle, z.b indexpath.row, indexpath section.
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
print("wo ist meine loslist")
        // Only move cell from the 1st section
        if indexPath.section == 0 {

            // Append the selected element to the second array
            lostList.append(list[indexPath.row])

            // Remove the selected element from the first array
            list.remove(at: indexPath.row)

            tableView.reloadData()
        }
    }
    
    
    
}

