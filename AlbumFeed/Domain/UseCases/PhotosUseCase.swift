//
//  PhotosUseCase.swift
//  AlbumFeed
//
//  Created by Jill Chang on 2022/7/14.
//

import Foundation

public protocol PhotosRepository {
    func fetchPhotos(param: [String : Any], with completion: @escaping (Result<[PhotoEntity], Error>) -> Void)
}

public protocol PhotosUseCase {
    // photos?albumId=1
    func fetchPhotos(param: [String : Any], with completion: @escaping (Result<[PhotoEntity], Error>) -> Void)
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

public final class MainPhotosUseCase {
    public let repository: PhotosRepository
    
    public init(repository: PhotosRepository) {
        self.repository = repository
    }
}

extension MainPhotosUseCase: PhotosUseCase {
    public func fetchPhotos(param: [String : Any], with completion: @escaping (Result<[PhotoEntity], Error>) -> Void) {
        self.repository.fetchPhotos(param: param) { result in
            completion(result)
        }
    }
}
