//
//  PhotosViewModel.swift
//  AlbumFeed
//
//  Created by Jill Chang on 2022/7/14.
//

import Foundation

// Input
public protocol PhotosVMInput {
    func triggerInit()
    // clickUser
    // clickAlbum
}

// Output
public protocol PhotosVMOutput {
    var photoData: Box<[PhotoEntity]> { get }
    var alertMessage: Box<(title: String, message: String)> { get }
}

// Manager
public protocol PhotosVMManager {
    var coordinatorDelegate: PhotosCoordinatorDelegate? { get set }
    var input: PhotosVMInput { get }
    var output: PhotosVMOutput { get }
}

public final class PhotosViewModel: PhotosVMInput, PhotosVMOutput, PhotosVMManager {
    public var coordinatorDelegate: PhotosCoordinatorDelegate?
    
    var usecase: PhotosUseCase?
    
    public init(_ usecase: PhotosUseCase) {
        self.usecase = usecase
    }
    
    public var input: PhotosVMInput {
        return self
    }
    public var output: PhotosVMOutput {
        return self
    }
    
    //output
    public var photoData: Box<[PhotoEntity]> = Box(nil)
    public var alertMessage: Box<(title: String, message: String)> = Box(nil)
}

// input
extension PhotosViewModel {
    public func triggerInit() {
        
        var param = [String: String]()
        self.usecase?.fetchPhotos(param: param) { result in
            switch result {
            case .success(let entity):
                self.photoData.value = entity
            case.failure(let error):
                self.alertMessage.value = (title: "Error", message: error.localizedDescription)
            }
        }
        
    }
}
