//
//  AlbumListUseCase.swift
//  AlbumFeed
//
//  Created by Jill Chang on 2022/7/8.
//

import Foundation

public protocol AlbumListRepository {
    func fetchAllUsers(with completion: @escaping (Result<[UserEntity], Error>) -> Void)
    func fetchAlbums(param: [String : Any], with completion: @escaping (Result<[AlbumEntity], Error>) -> Void)
}

public protocol AlbumListUseCase {
    // users
    func fetchAllUsers(with completion: @escaping (Result<[UserEntity], Error>) -> Void)
    /*
     {
         "id": 1,
         "name": "Leanne Graham",
         "username": "Bret",
         "email": "Sincere@april.biz",
         "address": {
           "street": "Kulas Light",
           "suite": "Apt. 556",
           "city": "Gwenborough",
           "zipcode": "92998-3874",
           "geo": {
             "lat": "-37.3159",
             "lng": "81.1496"
           }
         }
     */
    
    // albums?userId=1
    func fetchAlbums(param: [String : Any], with completion: @escaping (Result<[AlbumEntity], Error>) -> Void)
    /*
     {
       "userId": 1,
       "id": 1,
       "title": "quidem molestiae enim"
     }
     */
}

public final class MainAlbumListUseCase {
    public let repository: AlbumListRepository
    
    public init(repository: AlbumListRepository) {
        self.repository = repository
    }
}

extension MainAlbumListUseCase: AlbumListUseCase {
    public func fetchAllUsers(with completion: @escaping (Result<[UserEntity], Error>) -> Void) {
        self.repository.fetchAllUsers { result in
            completion(result)
        }
    }
    
    public func fetchAlbums(param: [String : Any], with completion: @escaping (Result<[AlbumEntity], Error>) -> Void) {
        self.repository.fetchAlbums(param: param) { result in
            completion(result)
        }
    }
}


public protocol AlbumPhotoRepository {
    func fetchPhotos(param: [String : Any], with completion: @escaping (Result<[AlbumEntity], Error>) -> Void)
}

public protocol AlbumPhotoUseCase {
    // photos?albumId=1
    func fetchPhotos(param: [String : Any], with completion: @escaping (Result<[AlbumEntity], Error>) -> Void)
    /*
     {
         "albumId": 1,
         "id": 1,
         "title": "accusamus beatae ad facilis cum similique qui sunt",
         "url": "https://via.placeholder.com/600/92c952",
         "thumbnailUrl": "https://via.placeholder.com/150/92c952"
       }
     */
}

public final class MainAlbumPhotoUseCase {
    public let repository: AlbumPhotoRepository
    
    public init(repository: AlbumPhotoRepository) {
        self.repository = repository
    }
}

extension MainAlbumPhotoUseCase: AlbumPhotoUseCase {
    public func fetchPhotos(param: [String : Any], with completion: @escaping (Result<[AlbumEntity], Error>) -> Void) {
        self.repository.fetchPhotos(param: param) { result in
            completion(result)
        }
    }
}
