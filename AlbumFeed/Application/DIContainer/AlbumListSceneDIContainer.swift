//
//  AlbumListSceneDIContainer.swift
//  AlbumFeed
//
//  Created by Jill Chang on 2022/7/8.
//

import UIKit

// make DIContainer or ViewController
public protocol AlbumListCoordinatorDependencies  {
    func makeAlbumListViewController(param: AlbumListCoordinator.Params?) -> UIViewController
}

public final class AlbumListSceneDIContainer {
    struct Dependencies {
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Flow Coordinators
    func makeLoginCoordinator(navigationController: UINavigationController) -> AlbumListCoordinator {
        return AlbumListCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension AlbumListSceneDIContainer: AlbumListCoordinatorDependencies {
    public func makeAlbumListViewController(param: AlbumListCoordinator.Params?) -> UIViewController {
        // Mock
        let repository = AlbumListMockRepository()
        
        // Domain layer
        let usecase = MainAlbumListUseCase(repository: repository)
        
        // Presentation layer
        let vm = AlbumListViewModel(usecase)
        
        let view = AlbumListViewController(viewModel: vm)
        return view
    }
}

// Mock AlbumListRepository
final class AlbumListMockRepository: AlbumListRepository {
    func fetchAllUsers(with completion: @escaping (Result<[UserEntity], Error>) -> Void) {
        guard let entity = self.userEntitys else {
            completion(.failure(NSError(domain: "Error", code: 0)))
            return
        }
        completion(.success(entity))
    }
    
    func fetchAlbums(param: [String : Any], with completion: @escaping (Result<[AlbumEntity], Error>) -> Void) {
        guard let entity = self.albumEntitys else {
            completion(.failure(NSError(domain: "Error", code: 0)))
            return
        }
        completion(.success(entity))
    }
    
    public var userEntitys: [UserEntity]?
    public var albumEntitys: [AlbumEntity]?
    
    init() {
        userEntitys = [UserEntity(id: 1, name: "Leanne Graham", username: "Bret"),
                       UserEntity(id: 2, name: "Ervin Howell", username: "Ervin Howell"),
                       UserEntity(id: 3, name: "Clementine Bauch", username: "Samantha"),
                       UserEntity(id: 4, name: "Patricia Lebsack", username: "Karianne"),
                       UserEntity(id: 5, name: "Chelsey Dietrich", username: "Kamren"),
                       UserEntity(id: 6, name: "Mrs. Dennis Schulist", username: "Leopoldo_Corkery"),
                       UserEntity(id: 7, name: "Kurtis Weissnat", username: "Elwyn.Skiles"),
                       UserEntity(id: 8, name: "Nicholas Runolfsdottir V", username: "Maxime_Nienow"),
                       UserEntity(id: 9, name: "Glenna Reichert", username: "Delphine"),
                       UserEntity(id: 10, name: "Clementina DuBuque", username: "Moriah.Stanton")]
        albumEntitys = [AlbumEntity(userID: 1, id: 1, title: "quidem molestiae enim"),
                        AlbumEntity(userID: 1, id: 2, title: "sunt qui excepturi placeat culpa"),
                        AlbumEntity(userID: 1, id: 3, title: "omnis laborum odio"),
                        AlbumEntity(userID: 1, id: 4, title: "non esse culpa molestiae omnis sed optio"),
                        AlbumEntity(userID: 1, id: 5, title: "eaque aut omnis a"),
                        AlbumEntity(userID: 1, id: 6, title: "natus impedit quibusdam illo est"),
                        AlbumEntity(userID: 1, id: 7, title: "quibusdam autem aliquid et et quia"),
                        AlbumEntity(userID: 1, id: 8, title: "qui fuga est a eum"),
                        AlbumEntity(userID: 1, id: 9, title: "saepe unde necessitatibus rem"),
                        AlbumEntity(userID: 1, id: 10, title: "distinctio laborum qui"),
        ]
    }
}
