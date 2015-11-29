//
//  EurekaTableCellModel.swift
//  NJIT Student Guide
//
//  Created by Mac on 10/7/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import Foundation
class BooksTableCellModel {
    
    var userName = [String]()
    var bookName = [String]()
    var bookDescription = [String]()
    
    func BooksTableCellModel() {
        
    }
    
    func getUserName(index: Int) ->String! {
        
        return userName[index]
        
    }
    func getbookName(index: Int) ->String! {
        
        return bookName[index]
        
    }
    func getBookDescription(index: Int) ->String! {
        
        return bookDescription[index]
        
    }
    
    func setProfileName() {
        
    }
    func setFoundItemName() {
        
    }
    func setItemDescription() {
        
    }
    func setItemImages() {
        
    }
    func get_data_from_url()
    {
    }
}
