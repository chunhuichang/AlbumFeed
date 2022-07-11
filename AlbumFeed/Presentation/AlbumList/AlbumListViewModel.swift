//
//  AlbumListViewModel.swift
//  AlbumFeed
//
//  Created by Jill Chang on 2022/7/8.
//

import Foundation

// Input
public protocol AlbumListVMInput {
    func triggerInit()
    // clickUser
    // clickAlbum
}

// Output
public protocol AlbumListVMOutput {
    var userData: Box<[UserEntity]> { get }
    var albumData: Box<[AlbumEntity]> { get }
    var alertMessage: Box<(title: String, message: String)> { get }
}

// Manager
public protocol AlbumListVMManager {
    var coordinatorDelegate: AlbumListCoordinatorDelegate? { get set }
    var input: AlbumListVMInput { get }
    var output: AlbumListVMOutput { get }
}

public final class AlbumListViewModel: AlbumListVMInput, AlbumListVMOutput, AlbumListVMManager {
    public var coordinatorDelegate: AlbumListCoordinatorDelegate?
    
    var usecase: AlbumListUseCase?
    
    public init(_ usecase: AlbumListUseCase) {
        self.usecase = usecase
    }
    
    public var input: AlbumListVMInput {
        return self
    }
    public var output: AlbumListVMOutput {
        return self
    }
    
    //output
    public var userData: Box<[UserEntity]>  = Box(nil)
    public var albumData: Box<[AlbumEntity]>  = Box(nil)
    public var alertMessage: Box<(title: String, message: String)> = Box(nil)
}

// input
extension AlbumListViewModel {
    public func triggerInit() {
        
        self.usecase?.fetchAllUsers() { result in
            switch result {
            case .success(let entity):
                self.userData.value = entity
            case.failure(let error):
                self.alertMessage.value = (title: "Error", message: error.localizedDescription)
            }
        }
        
    }
    
    private func triggerAlbumData(userId id: Int) {
        // albums?userId=1
        var param = [String: String]()
        param["userId"] = String(id)
        self.usecase?.fetchAlbums(param: param) { result in
            switch result {
            case .success(let entity):
                self.albumData.value = entity
            case.failure(let error):
                self.alertMessage.value = (title: "Error", message: error.localizedDescription)
            }
        }
        
    }
}
