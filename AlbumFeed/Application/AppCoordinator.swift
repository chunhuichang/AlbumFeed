//
//  AppCoordinator.swift
//  AlbumFeed
//
//  Created by Jill Chang on 2022/7/8.
//

import UIKit

public final class AppCoordinator {
    private let navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    public init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    public func start() {
        let DIContainer = appDIContainer.makeLoginSceneDIContainer()
        let coordinator = DIContainer.makeLoginCoordinator(navigationController: navigationController)
        coordinator.start()
    }
}
