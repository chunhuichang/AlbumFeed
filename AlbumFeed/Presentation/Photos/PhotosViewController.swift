//
//  PhotosViewController.swift
//  AlbumFeed
//
//  Created by Jill Chang on 2022/7/14.
//

import UIKit

class PhotosViewController: UIViewController {
    public var viewModel: PhotosVMManager
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.register(PhotoCell.self, forCellWithReuseIdentifier: "\(PhotoCell.self)")
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    init(viewModel: PhotosVMManager) {
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
private extension PhotosViewController {
    private func setupUI() {
        self.view.backgroundColor = .lightGray
        
        
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
private extension PhotosViewController {
    private func UIBinding() {
        let output = self.viewModel.output
        
        output.photoData.binding {[weak self] _, _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

// MARK: CollectionView delgate
extension PhotosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView, let cellVM = self.viewModel.output.photoData.value?[indexPath.row] {
            print("entity click:\(cellVM.id)")
        }
    }
}

// MARK: CollectionView data source
extension PhotosViewController: UICollectionViewDataSource {
    // item number
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.output.photoData.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PhotoCell.self)", for: indexPath) as? PhotoCell,
                  let cellVM = self.viewModel.output.photoData.value?[indexPath.row] else {
                      return UICollectionViewCell()
                  }
            
            let vm = PhotoCellVM(entity: cellVM)
            cell.setupCell(viewModel: vm)
            return cell
    }
}

// MARK: CollectionView CompositionalLayout
private extension PhotosViewController {
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets.bottom = 16
            
            // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.leading = 16
            section.contentInsets.top = 16
            section.contentInsets.trailing = 16
            
            return section
        }
        return layout
    }
}
