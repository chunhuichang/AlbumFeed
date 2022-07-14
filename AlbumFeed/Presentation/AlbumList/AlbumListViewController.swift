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
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.register(UserCell.self, forCellWithReuseIdentifier: "\(UserCell.self)")
        view.register(AlbumCell.self, forCellWithReuseIdentifier: "\(AlbumCell.self)")
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
        self.viewModel.input.triggerInit()
    }
}

// MARK: UI Setting
private extension AlbumListViewController {
    private func setupUI() {
        self.view.backgroundColor = .white
        
        
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
        let output = self.viewModel.output
        
        output.userData.binding {[weak self] _, _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        output.albumData.binding {[weak self] _, _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

// MARK: CollectionView delgate
extension AlbumListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView, let cellVM = self.viewModel.output.albumData.value?[indexPath.row] {
            print("entity click:\(cellVM.title)")
            self.viewModel.input.showAlbumPhotos(entity: cellVM)
        }
    }
}

// MARK: CollectionView data source
extension AlbumListViewController: UICollectionViewDataSource {
    // section number
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    // item number
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.viewModel.output.userData.value?.count ?? 0
        }
        
        return self.viewModel.output.albumData.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(UserCell.self)", for: indexPath) as? UserCell,
                  let cellVM = self.viewModel.output.userData.value?[indexPath.row] else {
                      return UICollectionViewCell()
                  }
            
            let vm = UserCellVM(entity: cellVM)
            cell.setupCell(viewModel: vm)
            return cell
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(AlbumCell.self)", for: indexPath) as? AlbumCell,
                  let cellVM = self.viewModel.output.albumData.value?[indexPath.row] else {
                      return UICollectionViewCell()
                  }
            
            let vm = AlbumCellVM(entity: cellVM)
            cell.setupCell(viewModel: vm)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

// MARK: CollectionView CompositionalLayout
private extension AlbumListViewController {
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                // Item
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalWidth(0.25))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets.trailing = 16
                item.contentInsets.bottom = 16
                
                // Group
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(80))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                section.contentInsets.top = 16
                section.orthogonalScrollingBehavior = .continuous
                
                return section
            } else {
                // Item
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets.bottom = 16
                
                // Group
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                section.contentInsets.top = 16
                section.contentInsets.trailing = 16
                
                return section
            }
        }
        return layout
    }
}
