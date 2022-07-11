//
//  UserCell.swift
//  AlbumFeed
//
//  Created by Jill Chang on 2022/7/11.
//

import UIKit

class UserCell: UICollectionViewCell {
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
    
    private var viewModel: UserCellVM?
    
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

extension UserCell {
    private func removeAllBinding() {
        self.viewModel?.entity.removeAllBinding()
    }
    
    public func binding() {
        self.removeAllBinding()
        
        if let vm = self.viewModel {
            vm.entity.binding(listener: { [weak self] (newValue, _) in
                guard let self = self, let entity = newValue else { return }
                DispatchQueue.main.async {
                    self.nameLabel.text = entity.username
                }
            })
        }
    }
}

extension UserCell {
    func setupCell(viewModel: UserCellVM) {
        self.viewModel = viewModel
        self.binding()
    }
}

public final class UserCellVM {
    var entity: Box<UserEntity> = Box(nil)
    
    public init(entity: UserEntity) {
        self.entity.value = entity
    }
}
