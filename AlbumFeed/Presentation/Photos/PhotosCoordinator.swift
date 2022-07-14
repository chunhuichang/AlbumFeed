//
//  PhotosCoordinator.swift
//  AlbumFeed
//
//  Created by Jill Chang on 2022/7/14.
//

import UIKit

// Current Coordinator send to prev Coordinator
public protocol PhotosDelegate: AnyObject {}

// Current Coordinator go to next Coordinator
public protocol PhotosCoordinatorDelegate: AnyObject {
}

public final class PhotosCoordinator {
    public struct Params {}
    
    private weak var navigationController: UINavigationController?
    private let dependencies: PhotosCoordinatorDependencies
    
    public init(navigationController: UINavigationController?, dependencies: PhotosCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    public func start() {
        guard let vc = dependencies.makePhotosViewController(param: nil) as? PhotosViewController else {
            fatalError("Casting to ViewController fail")
        }
        navigationController?.pushViewController(vc, animated: false)
    }
}

extension PhotosCoordinator: PhotosCoordinatorDelegate {
}

extension PhotosCoordinator: PhotosDelegate {}
