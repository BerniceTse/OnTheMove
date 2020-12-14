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
    
    func addItem(item: ItemModel)
    {
        itemsList.append(item)
        itemCount += 1
    }
}
