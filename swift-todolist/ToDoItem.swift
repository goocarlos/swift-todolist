//
//  ToDoItem.swift
//  swift-todolist
//
//  Created by 张路宇 on 14/11/5.
//  Copyright (c) 2014年 Lxnit. All rights reserved.
//

import Foundation

class ToDoItem{
    
    var itemName:String?
    var completed:Bool = false
    let creationDate:NSDate?
    var completionDate:NSDate?
    
    init(){
        
    }
    
    func markAsCompleted(isCompleted:Bool){
        
        self.completed = isCompleted
        
        self.setCompletionDate()
        
    }
    
    private func setCompletionDate(){
        
        if(self.completed){
            self.completionDate = NSDate()
        } else {
            self.completionDate = nil
        }
        
    }
}