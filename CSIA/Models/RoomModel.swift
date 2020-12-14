//
//  RoomModel.swift
//  CSIA
//
//  Created by Bernice Tse on 17/8/2020.
//  Copyright © 2020 Bernice Tse. All rights reserved.
//

class RoomModel
{
    var roomName: String?
    var boxesList: [BoxModel] = []
    var boxCount : Int
    
    init(roomName: String?, boxesList: [BoxModel], boxCount: Int)
    {
        self.roomName = roomName
        self.boxesList = boxesList
        self.boxCount = 0
    }
    
    func addBox(box: BoxModel)
    {
        boxesList.append(box)
        boxCount += 1
    }
    
}
