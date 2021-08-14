//
//  AlbumsCollectionViewCell.swift
//  TestProjectHedgehogTech
//
//  Created by Михаил on 12.08.2021.
//

import UIKit

class AlbumsCollectionViewCell: UICollectionViewCell {

    lazy var albumsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var albumLabel: UILabel = {
       let label = UILabel()
        label.toAutoLayout()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
 
extension AlbumsCollectionViewCell {
    private func setupLayout() {
        contentView.addSubview(albumsImageView)
        contentView.addSubview(albumLabel)
        let constraints = [
            albumsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            albumsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 8),
            albumsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -8),
            albumsImageView.bottomAnchor.constraint(equalTo: albumLabel.topAnchor, constant: -8),
            
            albumLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            albumLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            albumLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
