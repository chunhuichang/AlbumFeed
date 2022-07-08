//
//  AlbumListViewController.swift
//  AlbumFeed
//
//  Created by Jill Chang on 2022/7/8.
//

import UIKit

class AlbumListViewController: UIViewController {
    public var viewModel: AlbumListVMManager
    
    init(viewModel: AlbumListVMManager) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.UIBinding()
    }
}

// MARK: UI Setting
private extension AlbumListViewController {
    private func setupUI() {
        self.view.backgroundColor = .red
    }    
}

// MARK: UI Binding
private extension AlbumListViewController {
    private func UIBinding() {
    }
}
