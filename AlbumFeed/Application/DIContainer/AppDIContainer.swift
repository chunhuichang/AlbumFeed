//
//  AppDIContainer.swift
//  AlbumFeed
//
//  Created by Jill Chang on 2022/7/8.
//

import UIKit

public final class AppDIContainer {
    // MARK: - DIContainers of scenes
    func makeLoginSceneDIContainer() -> AlbumListSceneDIContainer {
        let dependencies = AlbumListSceneDIContainer.Dependencies()
        return AlbumListSceneDIContainer(dependencies: dependencies)
    }
}
