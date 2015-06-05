//
//  DetailViewController.swift
//  TodoList
//
//  Created by qingjiezhao on 6/4/15.
//  Copyright (c) 2015 qingjiezhao. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController , UITextFieldDelegate{
    
    
    var todo : TodoModel?
    
    
    @IBOutlet weak var child: UIButton!
    @IBOutlet weak var phone: UIButton!
    @IBOutlet weak var shoppingcart: UIButton!
    @IBOutlet weak var travel: UIButton!
    @IBOutlet weak var todoItem: UITextField!
    @IBOutlet weak var todoDate: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoItem.delegate = self
        
        if todo == nil{
            child.selected = true
            navigationController?.title = "Add Todo"
        }else{
            navigationController?.title = "Edit Todo"
            if todo?.image == "child-selected"{
                child.selected = true
            }else if todo?.image == "shopping-cart-selected"{
                phone.selected = true
            }else if todo?.image == "phone-selected"{
                shoppingcart.selected = true
            }else if todo?.image == "travel-selected"{
                travel.selected = true
            }
            todoItem.text = todo?.title
            todoDate.setDate((todo?.date)!, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetButtons(){
        child.selected = false;
        phone.selected = false;
        shoppingcart.selected = false;
        travel.selected = false;
        
    }
    
    
    @IBAction func childTapped(sender: AnyObject) {
        resetButtons()
        
        child.selected = true;
    }
    
    @IBAction func phoneTapped(sender: AnyObject) {
        resetButtons()
        
        phone.selected = true;
    }
    
    @IBAction func shoppingTapped(sender: AnyObject) {
        resetButtons()
        
        shoppingcart.selected = true;
    }

    @IBAction func travelTappled(sender: AnyObject) {
        resetButtons()
        
        travel.selected = true;
    }
    
    @IBAction func okTapped(sender: AnyObject) {
        
        var image = ""
        if child.selected{
            image = "child-selected"
        }else if phone.selected{
            image = "phone-selected"
        }else if shoppingcart.selected{
            image = "shoppingcart-selected"
        }else if travel.selected{
            image = "travel-selected"
        }
        
        if todo == nil{
            let uuid = UIDevice.currentDevice().identifierForVendor.UUIDString
            todo  = TodoModel(id:uuid,image:image,title:todoItem.text,date:todoDate.date)
            todos.append(todo!)
        }else{
            todo?.image = image
            todo?.title = todoItem.text
            todo?.date = todoDate.date
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        todoItem.resignFirstResponder()
    }
}
