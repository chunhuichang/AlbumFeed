//
//  AlbumListCoordinator.swift
//  AlbumFeed
//
//  Created by Jill Chang on 2022/7/8.
//

import UIKit

// Current Coordinator send to prev Coordinator
public protocol AlbumListDelegate: AnyObject {}

// Current Coordinator go to next Coordinator
public protocol AlbumListCoordinatorDelegate: AnyObject {
    func showAlbumPhotos(entity: AlbumEntity)
}

public final class AlbumListCoordinator {
    public struct Params {}
    
    private weak var navigationController: UINavigationController?
    private let dependencies: AlbumListCoordinatorDependencies
    
    public init(navigationController: UINavigationController, dependencies: AlbumListCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    public func start() {
        guard let vc = dependencies.makeAlbumListViewController(param: nil) as? AlbumListViewController else {
            fatalError("Casting to ViewController fail")
        }
        vc.viewModel.coordinatorDelegate = self
        navigationController?.pushViewController(vc, animated: false)
    }
}

extension AlbumListCoordinator: AlbumListCoordinatorDelegate {
    public func showAlbumPhotos(entity: AlbumEntity) {
        let DIContainer = dependencies.makePhotosSceneDIContainer()
        let coordinator = DIContainer.makePhotosCoordinator(navigationController: navigationController, param: PhotosCoordinator.Params())
        coordinator.start()
    }
}

extension AlbumListCoordinator: AlbumListDelegate {}
