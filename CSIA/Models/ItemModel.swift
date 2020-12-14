//
//  ItemModel.swift
//  CSIA
//
//  Created by Bernice Tse on 16/8/2020.
//  Copyright © 2020 Bernice Tse. All rights reserved.
//


class ItemModel
{
    var name: String?
    var box: BoxModel;
    var room: RoomModel;
    var quantity: Int?
    var description: String?
       
    init(name: String?, box: BoxModel, room: RoomModel, quantity: Int?, description: String?)
       {
           self.name = name
           self.quantity = quantity
           self.box = box
           self.room = room
           self.description = description
       }
    
//    var name: String {
//        get {
//            //code to execute
//            return name
//        }
//        set(newValue) {
//            //code to execute
//        }
//    }
}
