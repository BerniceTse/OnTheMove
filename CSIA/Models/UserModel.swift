//
//  UserModel.swift
//  CSIA
//
//  Created by Bernice Tse on 16/8/2020.
//  Copyright © 2020 Bernice Tse. All rights reserved.
//

class UserModel
{
    var uid: String?
    var username: String?
    var email: String?
    var roomsList: [RoomModel] = []
    var roomCount: Int
    
    init(uid: String?, username: String?, email: String?, roomsList: [RoomModel], roomCount: Int)
    {
        self.uid = uid
        self.username = username
        self.email = email
        self.roomsList = roomsList
        self.roomCount = roomCount
    }
    
    func setUid(newUid: String) { uid = newUid }
    
    func getUid() -> String? { return uid }
    
    func setUsername(newUsername: String) { username = newUsername }
    
    func getUsername() -> String? { return username }
    
    func setEmail(newEmail: String) { email = newEmail }
    
    func getEmail() -> String? { return email }
    
    func addRoom (room: RoomModel)
    {
        roomsList.append(room)
        roomCount += 1
    }
}
