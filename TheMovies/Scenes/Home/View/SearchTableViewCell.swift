//
//  MovieTableViewCell.swift
//  TheMovies
//
//  Created by Mehmet Koca on 15.10.2020.
//

import UIKit

struct MoviewTableViewCellPresentation {
    
    let posterPath: String?
    let title: String?
    let voteAverage: Double?
}

struct PersonTableViewCellPresentation {
    
    let profilePath: String?
    let name: String?
}

final class SearchTableViewCell: UITableViewCell {
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let containerView: UIStackView = {
       let view = UIStackView()
        view.spacing = 4.0
        view.axis = .vertical
        view.distribution = .fillEqually
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

extension SearchTableViewCell {
    
    func configure(with presentation: MoviewTableViewCellPresentation) {
        if let posterPath = presentation.posterPath {
            posterImageView.downloaded(from: posterPath)
        }
        
        if let title = presentation.title {
            titleLabel.text = title
        }
        
        if let voteAverage = presentation.voteAverage {
            voteAverageLabel.text = "Vote: \(voteAverage)"
            voteAverageLabel.isHidden = false
        }
    }
    
    func configure(with presentation: PersonTableViewCellPresentation) {
        if let profilePath = presentation.profilePath {
            posterImageView.downloaded(from: profilePath)
        }
        
        if let name = presentation.name {
            titleLabel.text = name
        }
        
        voteAverageLabel.isHidden = true
    }
}

// MARK: - Configure Views

private extension SearchTableViewCell {
    
    func configureViews() {
        
        selectionStyle = .none
        accessoryType = .disclosureIndicator
        
        contentView.addSubview(posterImageView)
        containerView.addArrangedSubview(titleLabel)
        containerView.addArrangedSubview(voteAverageLabel)
        contentView.addSubview(containerView)
        
        configurePosterImageView()
        configureContainerView()
    }

    func configurePosterImageView() {
        posterImageView.centerYAnchor.constraint(equalTo:contentView.centerYAnchor).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant:16).isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant:50).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
    }
    
    func configureContainerView() {
        containerView.centerYAnchor.constraint(equalTo:contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:posterImageView.trailingAnchor, constant:8).isActive = true
        containerView.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant:-16).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:40).isActive = true
    }
}
