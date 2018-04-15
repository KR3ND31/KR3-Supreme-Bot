//
//  OptionViewController.swift
//  KR3 Supreme Bot
//
//  Created by Дмитрий Антоник on 01.04.2018.
//  Copyright © 2018 KR3ND31. All rights reserved.
//

import Foundation
import UIKit
import RSSelectionMenu

class OptionViewController: UIViewController, UITextFieldDelegate{
    
    
    @IBAction func button_save(_ sender: Any) {
        
       
    }
    
    @IBAction func button_clear(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.input_name.delegate = self
//        self.input_email.delegate = self
//        self.input_tel.delegate = self
//        self.input_address1.delegate = self
//        self.input_address2.delegate = self
//        self.input_address3.delegate = self
//        self.input_city.delegate = self
//        self.input_postcode.delegate = self
//        self.input_number.delegate = self
//        self.input_month.delegate = self
//        self.input_year.delegate = self
//        self.input_cvv.delegate = self
        
//        ScrollView.contentSize.height = 1000
//
//        self.input_name.delegate = self
//
//        if let name = UserDefaults.standard.object(forKey: "Name") as? String
//        {
//            input_name.text = name
//
//        }
//        if let email = UserDefaults.standard.object(forKey: "Email") as? String
//        {
//            input_email.text = email
//
//        }
//        if let tel = UserDefaults.standard.object(forKey: "Tel") as? String
//        {
//            input_tel.text = tel
//
//        }
//        if let address1 = UserDefaults.standard.object(forKey: "Address1") as? String
//        {
//            input_address1.text = address1
//
//        }
//        if let address2 = UserDefaults.standard.object(forKey: "Address2") as? String
//        {
//            input_address2.text = address2
//
//        }
//        if let address3 = UserDefaults.standard.object(forKey: "Address3") as? String
//        {
//            input_address3.text = address3
//
//        }
//        if let city = UserDefaults.standard.object(forKey: "City") as? String
//        {
//            input_city.text = city
//
//        }
//        if let postcode = UserDefaults.standard.object(forKey: "Postcode") as? String
//        {
//            input_postcode.text = postcode
//
//        }
//        if let number = UserDefaults.standard.object(forKey: "Number") as? String
//        {
//            input_number.text = number
//
//        }
//        if let month = UserDefaults.standard.object(forKey: "Month") as? String
//        {
//            input_month.text = month
//
//        }
//        if let year = UserDefaults.standard.object(forKey: "Year") as? String
//        {
//            input_year.text = year
//
//        }
//        if let cvv = UserDefaults.standard.object(forKey: "CVV") as? String
//        {
//            input_cvv.text = cvv
//
//        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

class OptionTableController: UITableViewController{
    
    @IBOutlet weak var input_name: UITextField!
    @IBOutlet weak var input_email: UITextField!
    @IBOutlet weak var input_tel: UITextField!
    
    @IBOutlet weak var input_address1: UITextField!
    @IBOutlet weak var input_address2: UITextField!
    @IBOutlet weak var input_address3: UITextField!
    @IBOutlet weak var input_city: UITextField!
    @IBOutlet weak var input_postcode: UITextField!
    @IBOutlet weak var label_country: UILabel!
    
    @IBOutlet weak var label_type: UILabel!
    @IBOutlet weak var input_number: UITextField!
    @IBOutlet weak var label_mounth: UILabel!
    @IBOutlet weak var label_year: UILabel!
    @IBOutlet weak var label_CVV: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Properties
    
    let countryData = ["UK",
                       "UK (N. IRELAND)",
                       "AUSTRIA",
                       "BELARUS",
                       "BELGIUM",
                       "BULGARIA",
                       "CROATIA",
                       "CZECH REPUBLIC",
                       "DENMARK",
                       "ESTONIA",
                       "FINLAND",
                       "FRANCE",
                       "GERMANY",
                       "GREECE",
                       "HUNGARY",
                       "ICELAND",
                       "IRELAND",
                       "ITALY",
                       "LATVIA",
                       "LITHUANIA",
                       "LUXEMBOURG",
                       "MONACO",
                       "NETHERLANDS",
                       "NORWAY",
                       "POLAND",
                       "PORTUGAL",
                       "ROMANIA",
                       "RUSSIA",
                       "SLOVAKIA",
                       "SLOVENIA",
                       "SPAIN",
                       "SWEDEN",
                       "SWITZERLAND",
                       "TURKEY"]
    
    let TypeData = ["Visa", "Mastercard"]
    
    let MounthData = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    
    let YearData = ["2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025", "2026", "2027", "2028"]
    
    var simpleSelectedArray = [String]()
    
    func showAsFormSheetWithSearch(DataList: Array<String>, Label: UILabel, placeHolder: String) {
        
        // Show menu with datasource array - PresentationStyle = Formsheet & SearchBar
        
        let selectionMenu = RSSelectionMenu(dataSource: DataList) { (cell, object, indexPath) in
            cell.textLabel?.text = object
        }
        
        // show selected items
        selectionMenu.setSelectedItems(items: simpleSelectedArray) { (text, selected, selectedItems) in
            self.simpleSelectedArray = selectedItems
            print(selectedItems)
            Label.text = selectedItems[0]
        }
        
        // show searchbar with placeholder text and barTintColor
        // Here you'll get search text - when user types in seachbar
        
        selectionMenu.showSearchBar(withPlaceHolder: placeHolder, tintColor: UIColor.white.withAlphaComponent(0.3)) { (searchText) -> ([String]) in
            
            // return filtered array based on any condition
            // here let's return array where firstname starts with specified search text
            
            return DataList.filter({ $0.lowercased().hasPrefix(searchText.lowercased()) })
        }
        
        // show as formsheet
        selectionMenu.show(style: .Formsheet, from: self)
    }
    
}

extension OptionTableController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        let label = cell?.detailTextLabel
        
        if indexPath.section == 1 {
            
            switch indexPath.row {
                
                case 5:
                    showAsFormSheetWithSearch(DataList: countryData, Label: label!, placeHolder: "Select Country")
                    break
                
                default:
                    break
                
            }
            return
        }
        
        if indexPath.section == 2 {
            
            switch indexPath.row {
                
                case 0:
                    showAsFormSheetWithSearch(DataList: TypeData, Label: label!, placeHolder: "Select Type")
                    break
                
                case 2:
                    showAsFormSheetWithSearch(DataList: MounthData, Label: label!, placeHolder: "Select Mounth")
                    break
                
                case 3:
                    showAsFormSheetWithSearch(DataList: YearData, Label: label!, placeHolder: "Select Year")
                    break
                
                default:
                    break
            }
            return
        }
        
    }
}
