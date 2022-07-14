//
//  UIViewController.swift
//  AlbumFeed
//
//  Created by Jill Chang on 2022/7/12.
//

import SwiftUI

class AlbumController: UICollectionViewController {
    init() {
        super.init(collectionViewLayout: AlbumController.createLayout())
    }
    
    static func createLayout() -> UICollectionViewLayout {
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
    
    static func createLayoutDiffSection() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            
            var columns = 1
            switch sectionIndex{
            case 1:
                columns = 3
            case 2:
                columns = 5
            default:
                columns = 1
                
            }
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let groupHeight = columns == 1 ?
            NSCollectionLayoutDimension.absolute(44) :
            NSCollectionLayoutDimension.fractionalWidth(0.2)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
            return section
        }
        return layout
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let cellId = "cellId"
}

extension AlbumController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        navigationItem.title = "Album Feed"
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
}

extension AlbumController {
    // section number
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    // item number
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 10
        }
        
        return 50
    }
    
    // item
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            cell.backgroundColor = .systemPink
            return cell
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            cell.backgroundColor = .systemOrange
            return cell
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        typealias UIViewControllerType = UIViewController
        func makeUIViewController(context: Context) -> UIViewController {
            UINavigationController(rootViewController: AlbumController())
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            
        }
    }
}
