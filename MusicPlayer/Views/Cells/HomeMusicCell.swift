//
//  TableViewCell.swift
//  MusicPlayer
//
//  Created by Sigit on 14/11/26.
//

import UIKit

class HomeMusicCell: UITableViewCell {
    static let identifier = "HomeMusicCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        initConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initConstraint() {
        contentView.addSubview(hStackContainer)
        NSLayoutConstraint.activate([
            hStackContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            hStackContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            hStackContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            hStackContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
    
    lazy var hStackContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(artworkImageView)
        stack.addArrangedSubview(vStackLabel)
        return stack
    }()
    
    lazy var vStackLabel: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.addArrangedSubview(songNameLabel)
        stack.addArrangedSubview(artistLabel)
        stack.addArrangedSubview(albumLabel)
        return stack
    }()
    
    let artworkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var songNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Song Name"
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Artist"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var albumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Album"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
}

