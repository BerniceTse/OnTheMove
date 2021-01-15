//
//  BoxesModel.swift
//  CSIA
//
//  Created by Bernice Tse on 16/8/2020.
//  Copyright © 2020 Bernice Tse. All rights reserved.
//

class BoxModel
{
    var boxName: String?
    var itemsList:[ItemModel] = []
    var itemCount: Int
    
    init(boxName: String?, itemsList:[ItemModel], itemCount: Int)
    {
        self.boxName = boxName
        self.itemsList = itemsList
        self.itemCount = 0
    }
    
    func setBoxName(newBoxName: String)
    {
        boxName = newBoxName
    }
    func getBoxName() -> String?
    {
        return boxName
    }
    
    func addItem(item: ItemModel)
    {
        itemsList.append(item)
        itemCount += 1
    }
    func deleteItem(item: ItemModel)
    {
        //remove item
        for items in itemsList
        {
            if items.getName() == item.getName()
            {
                let index = itemsList.firstIndex{$0 === item}!
                itemsList.remove(at: index)
            }
        }
    }
    
    func getItem(item:ItemModel) -> ItemModel
    {
        //scroll through itemlist and return item
        for items in itemsList
        {
            if items.getName() == item.getName()
            {
               return items
            }
        }
        
      return item
    }
}
