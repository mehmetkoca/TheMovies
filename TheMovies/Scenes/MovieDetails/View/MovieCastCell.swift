//
//  MovieCastCell.swift
//  TheMovies
//
//  Created by Mehmet Koca on 15.10.2020.
//

import UIKit

struct MovieCastCellPresentation {
    
    let profilePath: String?
    let name: String?
}

final class MovieCastCell: UITableViewCell {
    
    private let posterHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let containerView: UIStackView = {
       let view = UIStackView()
        view.spacing = 4.0
        view.axis = .horizontal
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Public Methods

extension MovieCastCell {
    
    func configure(with presentation: MovieCastCellPresentation) {
        if let profilePath = presentation.profilePath {
            posterImageView.backgroundColor = .clear
            posterImageView.downloaded(from: profilePath)
        } else {
            posterImageView.backgroundColor = .gray
        }
        
        if let name = presentation.name {
            titleLabel.text = name
        }
    }
}

// MARK: - Configure Views

private extension MovieCastCell {
    
    func configureViews() {
        
        selectionStyle = .none
        accessoryType = .disclosureIndicator
        
        configureContainerView()
        
        configurePosterImageView()
        configureTitleHolderView()
        
        containerView.addArrangedSubview(posterHolderView)
        containerView.addArrangedSubview(titleHolderView)
    }

    func configurePosterImageView() {
        posterHolderView.addSubview(posterImageView)
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo:posterHolderView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: posterHolderView.trailingAnchor),
            posterImageView.topAnchor.constraint(equalTo: posterHolderView.topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: posterHolderView.bottomAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant:80),
            posterImageView.heightAnchor.constraint(equalToConstant:100)
        ])
    }
    
    func configureTitleHolderView() {
        titleHolderView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            containerView.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 8.0),
            containerView.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant:-8.0),
            titleLabel.leadingAnchor.constraint(equalTo:titleHolderView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleHolderView.trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleHolderView.centerYAnchor)
        ])
    }
    
    func configureContainerView() {
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            containerView.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 8.0),
            containerView.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant:-8.0)
        ])
    }
}
