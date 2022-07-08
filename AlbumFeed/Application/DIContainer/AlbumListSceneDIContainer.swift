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
        // Presentation layer
        let vm = AlbumListViewModel()
        
        let view = AlbumListViewController(viewModel: vm)
        return view
    }
}
