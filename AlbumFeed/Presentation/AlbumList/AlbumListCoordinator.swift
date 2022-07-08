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
        navigationController?.pushViewController(vc, animated: false)
    }
}

extension AlbumListCoordinator: AlbumListCoordinatorDelegate {
}

extension AlbumListCoordinator: AlbumListDelegate {}
