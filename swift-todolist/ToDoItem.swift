//
//  ToDoItem.swift
//  swift-todolist
//
//  Created by 张路宇 on 14/11/7.
//  Copyright (c) 2014年 Lxnit. All rights reserved.
//

import Foundation
import CoreData

@objc(ToDoItem)
class ToDoItem: NSManagedObject {

    @NSManaged var completed: NSNumber
    @NSManaged var completionDate: NSDate?
    @NSManaged var creationDate: NSDate
    @NSManaged var itemName: String!

    class func createInManagedObjectContext(moc: NSManagedObjectContext, itemName: String) -> ToDoItem {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("ToDoItem", inManagedObjectContext: moc) as ToDoItem
        newItem.itemName = itemName        
        return newItem
    }

    
    func markAsCompleted(isCompleted:Bool){
        
        self.completed = isCompleted
        self.setCompletionDate()
        
    }
    
    private func setCompletionDate(){
        
        if(self.completed == 1){
            self.completionDate = NSDate()
        } else {
            self.completionDate = nil
        }
        
    }
}
