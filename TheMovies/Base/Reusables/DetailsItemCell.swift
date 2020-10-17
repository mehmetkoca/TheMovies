//
//  DetailsItemCell.swift
//  TheMovies
//
//  Created by Mehmet Koca on 17.10.2020.
//

import UIKit

struct MovieDetailsCellPresentation {
    
    let posterPath: String?
    let title: String?
    let summary: String?
    let rating: Double?
}

struct PersonDetailsCellPresentation {
    
    let posterPath: String?
    let name: String?
    let biography: String?
}

final class DetailsItemCell: UITableViewCell {
    
    private let containerView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8.0
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        return stackView
    }()
    
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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.numberOfLines = 0
        label.textColor = .purple
        return label
    }()
    
    private let summaryHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.numberOfLines = 0
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        return label
    }()
    
    private let detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8.0
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
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

extension DetailsItemCell {

    func configure(with presentation: MovieDetailsCellPresentation) {
        if let posterPath = presentation.posterPath {
            posterImageView.downloaded(from: posterPath)
        }
        
        if let title = presentation.title {
            titleLabel.text = title
        }
        
        if let summary = presentation.summary {
            summaryLabel.text = summary
        }
        
        if let rating = presentation.rating {
            ratingLabel.isHidden = false
            ratingLabel.text = "Rating: \(rating)"
        }
    }
    
    func configure(with presentation: PersonDetailsCellPresentation) {
        if let posterPath = presentation.posterPath {
            posterImageView.downloaded(from: posterPath)
        }
        
        if let name = presentation.name {
            titleLabel.text = name
        }
        
        if let biography = presentation.biography {
            summaryLabel.text = biography
        }
        
        ratingLabel.isHidden = true
    }
}

// MARK: - Configure Views

private extension DetailsItemCell {
    
    func configureViews() {
        selectionStyle = .none
        configureContainerView()
        configurePosterImageView()
        configureTitleView()
        configureSummaryView()
        containerView.addArrangedSubview(posterHolderView)
        containerView.addArrangedSubview(detailsStackView)
        detailsStackView.addArrangedSubview(titleHolderView)
        detailsStackView.addArrangedSubview(summaryHolderView)
        detailsStackView.addArrangedSubview(ratingLabel)
    }
    
    func configureContainerView() {
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0)
        ])
    }
    
    func configurePosterImageView() {
        posterHolderView.addSubview(posterImageView)
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: posterHolderView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: posterHolderView.trailingAnchor),
            posterImageView.topAnchor.constraint(equalTo: posterHolderView.topAnchor),
            posterImageView.bottomAnchor.constraint(lessThanOrEqualTo: posterHolderView.bottomAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 100.0),
            posterImageView.heightAnchor.constraint(equalToConstant: 150.0)
        ])
    }
    
    func configureTitleView() {
        titleHolderView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: titleHolderView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleHolderView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleHolderView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleHolderView.bottomAnchor)
        ])
    }
    
    func configureSummaryView() {
        summaryHolderView.addSubview(summaryLabel)
        NSLayoutConstraint.activate([
            summaryLabel.leadingAnchor.constraint(equalTo: summaryHolderView.leadingAnchor),
            summaryLabel.trailingAnchor.constraint(equalTo: summaryHolderView.trailingAnchor),
            summaryLabel.bottomAnchor.constraint(lessThanOrEqualTo: summaryHolderView.bottomAnchor),
            summaryLabel.topAnchor.constraint(equalTo: summaryHolderView.topAnchor)
        ])
    }
}
