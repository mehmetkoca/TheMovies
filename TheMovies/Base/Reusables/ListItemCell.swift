//
//  MovieTableViewCell.swift
//  TheMovies
//
//  Created by Mehmet Koca on 15.10.2020.
//

import UIKit

struct MovieListItemCellPresentation {
    
    let posterPath: String?
    let title: String?
    let voteAverage: Double?
}

struct PersonListItemCellPresentation {
    
    let profilePath: String?
    let name: String?
}

final class ListItemCell: UITableViewCell {
    
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
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textColor = .blue
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let informationHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4.0
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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

extension ListItemCell {
    
    func configure(with presentation: MovieListItemCellPresentation) {
        if let posterPath = presentation.posterPath {
            posterImageView.downloaded(from: posterPath)
        }
        
        if let title = presentation.title {
            titleLabel.text = title
        }
        
        if let voteAverage = presentation.voteAverage {
            informationLabel.text = "Vote: \(voteAverage)"
            informationHolderView.isHidden = false
        }
    }
    
    func configure(with presentation: PersonListItemCellPresentation) {
        if let profilePath = presentation.profilePath {
            posterImageView.downloaded(from: profilePath)
        }
        
        if let name = presentation.name {
            titleLabel.text = name
        }
        
        informationHolderView.isHidden = true
    }
}

// MARK: - Configure Views

private extension ListItemCell {
    
    func configureViews() {
        
        selectionStyle = .none
        accessoryType = .disclosureIndicator
        
        configureContainerView()
        
        configurePosterImageView()
        configureTitleHolderView()
        configureInformationHolderView()
        
        containerView.addArrangedSubview(posterHolderView)
        containerView.addArrangedSubview(informationStackView)
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
        informationStackView.addArrangedSubview(titleHolderView)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo:titleHolderView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleHolderView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleHolderView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleHolderView.bottomAnchor)
        ])
    }
    
    func configureInformationHolderView() {
        informationHolderView.addSubview(informationLabel)
        informationStackView.addArrangedSubview(informationHolderView)
        NSLayoutConstraint.activate([
            informationLabel.leadingAnchor.constraint(equalTo:informationHolderView.leadingAnchor),
            informationLabel.trailingAnchor.constraint(equalTo: informationHolderView.trailingAnchor),
            informationLabel.topAnchor.constraint(equalTo: informationHolderView.topAnchor),
            informationLabel.bottomAnchor.constraint(equalTo: informationHolderView.bottomAnchor)
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

