//
//  BrowserViewController.swift
//  KR3 Supreme Bot
//
//  Created by Дмитрий Антоник on 01.04.2018.
//  Copyright © 2018 KR3ND31. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import SwiftSoup

struct SupremeItems : Codable {
    struct Products_and_categories : Codable {
        struct Categoty : Codable {
            let name : String?
            let id : Int?
            let new_item : Bool?
            let category_name : String?
        }
        let new : [Categoty]
    }
    let products_and_categories: Products_and_categories
    let release_date: String?
    let release_week: String?
}

struct ItemInfo : Codable {
    struct Styles : Codable {
        struct Sizes : Codable {
            let name : String?
            let id : Int?
            let stock_level: Int?
        }
        let sizes : [Sizes]
        let id : Int?
        let name : String?
       
    }
    let styles: [Styles]
}

class BrowserViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBAction func button_reload(_ sender: Any) {
        webView.reload()
    }
    
    @IBAction func startButton(_ sender: Any) {
        
        let url = URL(string: "http://www.supremenewyork.com/mobile_stock.json")
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            let decoder = JSONDecoder()
            let data = try! decoder.decode(SupremeItems.self , from: data!)
            print(data)
            
            data.products_and_categories.new.forEach{ item in
                
                list.forEach{ finditem in
                    
                    let itemKeyword : String = finditem["Keyword"]!.lowercased()
                    
                    let regexpItemKeyword = self.create_RegExp(keyword: itemKeyword)
                    
                    if item.name?.lowercased().range(of: regexpItemKeyword, options: .regularExpression, range: nil, locale: nil) != nil {
                        
                        print("Item with finding item found")

                        let url = URL(string: "http://www.supremenewyork.com/shop/\(item.id!).json")
                        
                        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
                            
                            let data = try! decoder.decode(ItemInfo.self , from: data!)
                            
                            data.styles.forEach{ style in
                                
                                let itemStyle : String = finditem["Style"]!.lowercased()
                                
                                let regexpItemStyle = self.create_RegExp(keyword: itemStyle)
                                
                                if style.name?.lowercased().range(of: regexpItemStyle, options: .regularExpression, range: nil, locale: nil) != nil {
                                    
                                    style.sizes.forEach{ size in // перебор сайзов
                                        if (size.stock_level! > 0){ // Если в наличии
                                            
                                            let itemSize : String = finditem["Size"]!.lowercased()
                                            if (itemSize == size.name?.lowercased()){
                                                print("Item with finding size founded")
                                                
                                                let myURL = URL(string: "http://www.supremenewyork.com/mobile/#products/\(item.id!)/\(style.id!)")
                                                let myRequest = URLRequest(url: myURL!)
                                                self.webView.load(myRequest)
                                                
                                            }
                                        }
                                    }
                                    
                                }
                            }
                            
                        }
                        task.resume()
                        
                    }else{
                        print("Its item not finding")
                    }
                    
               }
            }
        }
        task.resume()
    }
    @IBAction func fillButton(_ sender: Any) {
        
        if let name = UserDefaults.standard.object(forKey: "Name") as? String
        {
            webView.evaluateJavaScript("document.getElementById('order_billing_name').value = '\(name)'", completionHandler: {(res, error) -> Void in})
            
        }
        if let email = UserDefaults.standard.object(forKey: "Email") as? String
        {
            webView.evaluateJavaScript("document.getElementById('order_email').value = '\(email)'", completionHandler: {(res, error) -> Void in})
            
        }
        if let tel = UserDefaults.standard.object(forKey: "Tel") as? String
        {
            webView.evaluateJavaScript("document.getElementById('order_tel').value = '\(tel)'", completionHandler: {(res, error) -> Void in})
            
        }
        if let address1 = UserDefaults.standard.object(forKey: "Address1") as? String
        {
            webView.evaluateJavaScript("document.getElementById('order_billing_address').value = '\(address1)'", completionHandler: {(res, error) -> Void in})
            
        }
        if let address2 = UserDefaults.standard.object(forKey: "Address2") as? String
        {
            webView.evaluateJavaScript("document.getElementById('order_billing_address_2').value = '\(address2)'", completionHandler: {(res, error) -> Void in})
            
        }
        if let address3 = UserDefaults.standard.object(forKey: "Address3") as? String
        {
            webView.evaluateJavaScript("document.getElementById('order_billing_address_3').value = '\(address3)'", completionHandler: {(res, error) -> Void in})
            
        }
        if let city = UserDefaults.standard.object(forKey: "City") as? String
        {
            webView.evaluateJavaScript("document.getElementById('order_billing_city').value = '\(city)'", completionHandler: {(res, error) -> Void in})
            
        }
        if let postcode = UserDefaults.standard.object(forKey: "Postcode") as? String
        {
            webView.evaluateJavaScript("document.getElementById('order_billing_zip').value = '\(postcode)'", completionHandler: {(res, error) -> Void in})
            
        }
        webView.evaluateJavaScript("document.getElementById('order_billing_country').value = 'RU'; document.getElementById('order_billing_country').dispatchEvent(new Event('change'))", completionHandler: {(res, error) -> Void in})
        webView.evaluateJavaScript("document.getElementById('credit_card_type').value = 'master'; document.getElementById('credit_card_type').dispatchEvent(new Event('change'))", completionHandler: {(res, error) -> Void in})
        if let number = UserDefaults.standard.object(forKey: "Number") as? String
        {
            webView.evaluateJavaScript("document.getElementById('credit_card_n').value = '\(number)'", completionHandler: {(res, error) -> Void in})
            
        }
        if let month = UserDefaults.standard.object(forKey: "Month") as? String
        {
            webView.evaluateJavaScript("document.getElementById('credit_card_month').value = '\(month)'; document.getElementById('credit_card_month').dispatchEvent(new Event('change'))", completionHandler: {(res, error) -> Void in})
            
        }
        if let year = UserDefaults.standard.object(forKey: "Year") as? String
        {
            webView.evaluateJavaScript("document.getElementById('credit_card_year').value = '\(year)'; document.getElementById('credit_card_year').dispatchEvent(new Event('change'))", completionHandler: {(res, error) -> Void in})
            
        }
        if let cvv = UserDefaults.standard.object(forKey: "CVV") as? String
        {
            webView.evaluateJavaScript("document.getElementById('credit_card_cvv').value = '\(cvv)'", completionHandler: {(res, error) -> Void in})
            
        }
        webView.evaluateJavaScript("document.getElementById('order_terms').checked = true", completionHandler: {(res, error) -> Void in})
    }
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "http://www.supremenewyork.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func jsonStringify(jsonObject: AnyObject) -> String {
        
        var jsonString: String = ""
        
        switch jsonObject {
            
        case _ as [String: AnyObject] :
            
            let tempObject: [String: AnyObject] = jsonObject as! [String: AnyObject]
            jsonString += "{"
            for (key , value) in tempObject {
                if jsonString.count > 1 {
                    jsonString += ","
                }
                jsonString += "\"" + String(key) + "\":"
                jsonString += jsonStringify(jsonObject: value)
            }
            jsonString += "}"
            
        case _ as [AnyObject] :
            
            jsonString += "["
            for i in 0..<jsonObject.count {
                if i > 0 {
                    jsonString += ","
                }
                jsonString += jsonStringify(jsonObject: jsonObject[i])
            }
            jsonString += "]"
            
        case _ as String :
            
            jsonString += ("\"" + String(describing: jsonObject) + "\"")
            
        case _ as NSNumber :
            
            if jsonObject.isEqual(NSNumber(value: true)) {
                jsonString += "true"
            } else if jsonObject.isEqual(NSNumber(value: false)) {
                jsonString += "false"
            } else {
                return String(describing: jsonObject)
            }
            
        case _ as NSNull :
            
            jsonString += "null"
            
        default :
            
            jsonString += ""
        }
        return jsonString
    }
    
    
    func create_RegExp(keyword : String) -> String{
        var Reg = ".*?"
        //перебор строки
        for char in keyword {
            Reg = "\(Reg)\(char).*?"
        }
        print(Reg)
        return Reg
    }
    
    
}
