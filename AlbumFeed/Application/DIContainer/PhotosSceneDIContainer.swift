//
//  PhotosSceneDIContainer.swift
//  AlbumFeed
//
//  Created by Jill Chang on 2022/7/14.
//

import UIKit

// make DIContainer or ViewController
public protocol PhotosCoordinatorDependencies  {
    func makePhotosViewController(param: PhotosCoordinator.Params?) -> UIViewController
}

public final class PhotosSceneDIContainer {
    struct Dependencies {
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Flow Coordinators
    func makePhotosCoordinator(navigationController: UINavigationController?, param: PhotosCoordinator.Params?) -> PhotosCoordinator {
        return PhotosCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension PhotosSceneDIContainer: PhotosCoordinatorDependencies {
    public func makePhotosViewController(param: PhotosCoordinator.Params? = nil) -> UIViewController {
        // Mock
        let repository = PhotosMockRepository()
        
        // Domain layer
        let usecase = MainPhotosUseCase(repository: repository)
        
        // Presentation layer
        let vm = PhotosViewModel(usecase)
        
        let view = PhotosViewController(viewModel: vm)
        return view
    }
}


// Mock PhotosRepository
final class PhotosMockRepository: PhotosRepository {
    public func fetchPhotos(param: [String : Any], with completion: @escaping (Result<[PhotoEntity], Error>) -> Void) {
        guard let entity = self.photoEntitys else {
            completion(.failure(NSError(domain: "Error", code: 0)))
            return
        }
        completion(.success(entity))
    }
    
    public var photoEntitys: [PhotoEntity]?
    
    init() {
        photoEntitys = [PhotoEntity(id: 1, albumID: 1, url: "", thumbnailURL: ""),
                        PhotoEntity(id: 2, albumID: 1, url: "", thumbnailURL: ""),
                        PhotoEntity(id: 3, albumID: 1, url: "", thumbnailURL: ""),
                        PhotoEntity(id: 4, albumID: 1, url: "", thumbnailURL: ""),
                        PhotoEntity(id: 5, albumID: 1, url: "", thumbnailURL: ""),
                        PhotoEntity(id: 6, albumID: 1, url: "", thumbnailURL: ""),
                        PhotoEntity(id: 7, albumID: 1, url: "", thumbnailURL: ""),
                        PhotoEntity(id: 8, albumID: 1, url: "", thumbnailURL: ""),
                        PhotoEntity(id: 9, albumID: 1, url: "", thumbnailURL: ""),
                        PhotoEntity(id: 10, albumID: 1, url: "", thumbnailURL: ""),
                        PhotoEntity(id: 11, albumID: 1, url: "", thumbnailURL: ""),
                        PhotoEntity(id: 12, albumID: 1, url: "", thumbnailURL: ""),
                        PhotoEntity(id: 13, albumID: 1, url: "", thumbnailURL: ""),
                        PhotoEntity(id: 14, albumID: 1, url: "", thumbnailURL: ""),
                        PhotoEntity(id: 15, albumID: 1, url: "", thumbnailURL: ""),
                        PhotoEntity(id: 16, albumID: 1, url: "", thumbnailURL: ""),
                        PhotoEntity(id: 17, albumID: 1, url: "", thumbnailURL: ""),
                        PhotoEntity(id: 18, albumID: 1, url: "", thumbnailURL: ""),
                        PhotoEntity(id: 19, albumID: 1, url: "", thumbnailURL: ""),
                        PhotoEntity(id: 20, albumID: 1, url: "", thumbnailURL: "")
        ]
    }
}
