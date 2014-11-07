//
//  ToDoListTableViewController.swift
//  swift-todolist
//
//  Created by 张路宇 on 14/11/5.
//  Copyright (c) 2014年 Lxnit. All rights reserved.
//

import UIKit
import CoreData

class ToDoListTableViewController: UITableViewController {
    
    var toDoItems:Array<ToDoItem> = []

    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext{
            return managedObjectContext
        } else{
            return nil
        }
        }()
    
    func loadInitialData(){

        let item1 = ToDoItem.createInManagedObjectContext(self.managedObjectContext!, itemName: "Buy Milk")
        let item2 = ToDoItem.createInManagedObjectContext(self.managedObjectContext!, itemName: "Buy eggs")
        let item3 = ToDoItem.createInManagedObjectContext(self.managedObjectContext!, itemName: "Read a book")
        let item4 = ToDoItem.createInManagedObjectContext(self.managedObjectContext!, itemName: "5")
        let item5 = ToDoItem.createInManagedObjectContext(self.managedObjectContext!, itemName: "4")
        let item6 = ToDoItem.createInManagedObjectContext(self.managedObjectContext!, itemName: "3")
        
    }
    
    func fetchToDo() {
        let fetchRequest = NSFetchRequest(entityName: "ToDoItem")
        
        // 排序
        let sortDescriptor = NSSortDescriptor(key: "itemName", ascending: true)

        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [ToDoItem] {
            self.toDoItems = fetchResults
        }
    }
    
    func save() {
        var error : NSError?
        if(managedObjectContext!.save(&error) ) {
            println(error?.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 首次初始化数据, TODO: 如果数据为空
        // self.loadInitialData()
        
        // 非首次加载数据
        self.fetchToDo()

        // TODO: 查看 User Data
        // TODO: 删除数据

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction func unwindToList(segue: UIStoryboardSegue){
        var source: AddToDoItemViewController = segue.sourceViewController as AddToDoItemViewController
        var item = source.toDoItem
        
        if(item != nil){
            self.toDoItems.append(item)
            self.fetchToDo()
            
            if let newItemIndex = find(toDoItems, item) {
                // Create an NSIndexPath from the newItemIndex
                let newToDoItemIndexPath = NSIndexPath(forRow: newItemIndex, inSection: 0)
                // Animate in the insertion of this row
                self.tableView.insertRowsAtIndexPaths([ newToDoItemIndexPath ], withRowAnimation: .Automatic)
            }
            
            self.save()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.toDoItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListPrototypeCell", forIndexPath: indexPath) as UITableViewCell
        
        var toDoItem = self.toDoItems[indexPath.row];
        
        cell.textLabel.text = toDoItem.itemName
        
        if(toDoItem.completed == 1){
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else{
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        var tappedItem = self.toDoItems[indexPath.row];
        
        let toDoItem = self.toDoItems[indexPath.row]
        let alert = UIAlertView(title: toDoItem.itemName, message: toDoItem.itemName, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "OK")
        alert.show()
        
        // TODO: 1
        tappedItem.completed = 1
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
