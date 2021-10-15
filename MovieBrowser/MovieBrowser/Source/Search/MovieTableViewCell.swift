//
//  MovieTableViewCell.swift
//  MovieBrowser
//
//  Created by Ke Liu on 10/15/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    static let reuseID = "\(MovieTableViewCell.self)"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    lazy var releaseLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .gray
        return label
    }()
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .right
        label.widthAnchor.constraint(equalToConstant: 20).isActive = true
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.accessoryType = .disclosureIndicator
        
        let hStackView = UIStackView(frame: .zero)
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.axis = .horizontal
        
        let vStackView = UIStackView(frame: .zero)
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        vStackView.spacing = 8
        
        vStackView.addArrangedSubview(self.titleLabel)
        vStackView.addArrangedSubview(self.releaseLabel)
        
        hStackView.addArrangedSubview(vStackView)
        hStackView.addArrangedSubview(self.ratingLabel)
        
        self.contentView.addSubview(hStackView)
        hStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        hStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16).isActive = true
        hStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16).isActive = true
        hStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16).isActive = true
    }
    
    func configure(movie: Movie) {
        self.titleLabel.text = movie.title
        self.releaseLabel.text = movie.releaseDate?.dateFormatting()
        self.ratingLabel.text = "\(movie.rating)"
    }
    
    

}
