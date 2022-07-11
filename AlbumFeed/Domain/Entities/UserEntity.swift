//
//  UserEntity.swift
//  AlbumFeed
//
//  Created by Jill Chang on 2022/7/8.
//

import Foundation

public struct UserEntity {
    public init(id: Int, name: String, username: String) {
        self.id = id
        self.name = name
        self.username = username
    }
    
    let id: Int
    let name: String
    let username: String
}

public struct AlbumEntity {
    public init(userID: Int, id: Int, title: String, thumbnailURL: String? = nil, photoNumber: Int = 0) {
        self.userID = userID
        self.id = id
        self.title = title
        self.thumbnailURL = thumbnailURL
        self.photoNumber = photoNumber
    }
    
    let userID: Int
    let id: Int
    let title: String
    let thumbnailURL: String?
    let photoNumber: Int
}

public struct PhotoEntity {
    public init(id: Int, albumID: Int, url: String, thumbnailURL: String) {
        self.id = id
        self.albumID = albumID
        self.url = url
        self.thumbnailURL = thumbnailURL
    }
    
    let id: Int
    let albumID: Int
    let url: String
    let thumbnailURL: String
}
