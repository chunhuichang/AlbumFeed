//
//  AlbumListViewModel.swift
//  AlbumFeed
//
//  Created by Jill Chang on 2022/7/8.
//

import Foundation

// Input
public protocol AlbumListVMInput {
}

// Output
public protocol AlbumListVMOutput {
}

// Manager
public protocol AlbumListVMManager {
    var input: AlbumListVMInput { get }
    var output: AlbumListVMOutput { get }
}

public final class AlbumListViewModel: AlbumListVMInput, AlbumListVMOutput, AlbumListVMManager {
    public init() {
    }
    
    public var input: AlbumListVMInput {
        return self
    }
    public var output: AlbumListVMOutput {
        return self
    }
}

// input
extension AlbumListViewModel {
}
