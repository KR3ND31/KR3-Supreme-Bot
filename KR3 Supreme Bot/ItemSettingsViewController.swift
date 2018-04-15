//
//  ItemSettingsViewController.swift
//  KR3 Supreme Bot
//
//  Created by Дмитрий Антоник on 03.04.2018.
//  Copyright © 2018 KR3ND31. All rights reserved.
//

import Foundation
import UIKit
import RSSelectionMenu

var list = [["Category" : "Jackets", "Size" : "large", "Keyword" : "nf parka", "Style" : "Red"]]


class ItemSettingsViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    
    
    var simpleSelectedArray = [String]()
    @IBOutlet weak var input_category: UITextField!
    @IBOutlet weak var input_size: UITextField!
    @IBOutlet weak var input_keyword: UITextField!
    @IBOutlet weak var input_style: UITextField!
    @IBOutlet weak var ItemsTableView: UITableView!
    @IBOutlet weak var CategoryTableView: UITableView!
    
    
    
    
    
    @IBAction func button_add(_ sender: Any) {
        list.append(["Category" : input_category.text!, "Size" : input_size.text!, "Keyword" : input_keyword.text!, "Style" : input_style.text!])
        ItemsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var Count : Int = 0
        
        if (tableView == ItemsTableView){
            Count = list.count
        }
        
        if (tableView == CategoryTableView){
            //Count = categoryList.count
        }
        
        return (Count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "")
        
        if (tableView == ItemsTableView){
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "ItemCell")
            cell.textLabel?.text = list[indexPath.row]["Keyword"]
        }
        
        if (tableView == CategoryTableView){
            //cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CategoryCell")
            //cell.textLabel?.text = categoryList[indexPath.row]
        }
        
        return(cell)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            list.remove(at: indexPath.row)
            ItemsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.input_category.delegate = self
        self.input_size.delegate = self
        self.input_keyword.delegate = self
        self.input_style.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
