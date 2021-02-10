//
//  ItemModel.swift
//  CSIA
//
//  Created by Bernice Tse on 16/8/2020.
//  Copyright © 2020 Bernice Tse. All rights reserved.
//


class ItemModel
{
    //model for item with corresponding variables
    var name: String?
    var box: String?
    var room: String?
    var quantity: String?
    var description: String?
      
    //initialization for item model
    init(name: String?, box: String?, room: String?, quantity: String?, description: String?)
       {
           self.name = name
           self.quantity = quantity
           self.box = box
           self.room = room
           self.description = description
       }
    
    //corresponding getter and setter methods
    func setName(newName: String) { name = newName }
    func getName() -> String? { return name }
    func setBox(newBox: String) { box = newBox }
    func getBox() -> String? { return box }
    func setRoom(newRoom: String) { room = newRoom }
    func getRoom() -> String? { return room }
    func setQuantity(newQuantity: String) { quantity = newQuantity }
    func getQuantity() -> String? { return quantity }
    func setDescription(newDescription: String) { description = newDescription }
    func getDescription() -> String? { return description }
}
