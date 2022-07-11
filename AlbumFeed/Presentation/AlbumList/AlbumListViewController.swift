//
//  AlbumListViewController.swift
//  AlbumFeed
//
//  Created by Jill Chang on 2022/7/8.
//

import UIKit

class AlbumListViewController: UIViewController {
    public var viewModel: AlbumListVMManager
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(UserCell.self, forCellWithReuseIdentifier: "\(UserCell.self)")
//        view.register(AlbumCell.self, forCellWithReuseIdentifier: "\(AlbumCell.self)")
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
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
        
        
        [collectionView].forEach { [superView = self.view] in
            superView?.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
        ])
    }    
}

// MARK: UI Binding
private extension AlbumListViewController {
    private func UIBinding() {
    }
}

// MARK: CollectionView delgate
extension AlbumListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView, let cellVM = self.viewModel.output.userData.value?[indexPath.row] {
            print("entity click:\(cellVM.username)")
        }
    }
}

// MARK: CollectionView data source
extension AlbumListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.output.userData.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(UserCell.self)", for: indexPath) as? UserCell,
                  let cellVM = self.viewModel.output.userData.value?[indexPath.row] else {
                return UICollectionViewCell()
            }
            
            let vm = UserCellVM(entity: cellVM)
            cell.setupCell(viewModel: vm)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
