//
//  AddToDoItemViewController.swift
//  swift-todolist
//
//  Created by 张路宇 on 14/11/5.
//  Copyright (c) 2014年 Lxnit. All rights reserved.
//

import UIKit

class AddToDoItemViewController: UIViewController {
    
    var toDoItem:ToDoItem!

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (sender as? UIBarButtonItem != self.doneButton){
            return
        }
        
        if(countElements(self.textField.text) > 0 ){
            self.toDoItem = ToDoItem()
            self.toDoItem.itemName = self.textField.text
            self.toDoItem.completed = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
