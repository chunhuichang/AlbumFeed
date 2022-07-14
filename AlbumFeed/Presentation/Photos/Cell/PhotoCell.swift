//
//  PhotoCell.swift
//  AlbumFeed
//
//  Created by Jill Chang on 2022/7/14.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage.init(systemName: "person.circle")
        return imgView
    }()
    
    private var viewModel: PhotoCellVM?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [imageView, nameLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 3/4),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoCell {
    private func removeAllBinding() {
        self.viewModel?.entity.removeAllBinding()
    }
    
    public func binding() {
        self.removeAllBinding()
        
        if let vm = self.viewModel {
            vm.entity.binding(listener: { [weak self] (newValue, _) in
                guard let self = self, let entity = newValue else { return }
                DispatchQueue.main.async {
                    self.nameLabel.text = entity.url
                }
            })
        }
    }
}

extension PhotoCell {
    func setupCell(viewModel: PhotoCellVM) {
        self.viewModel = viewModel
        self.binding()
    }
}

public final class PhotoCellVM {
    var entity: Box<PhotoEntity> = Box(nil)
    
    public init(entity: PhotoEntity) {
        self.entity.value = entity
    }
}
