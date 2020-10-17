//
//  MovieDetailsCell.swift
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

final class MovieDetailsCell: UITableViewCell {
    
    private let containerView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16.0
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
        label.textColor = .black
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

// MARK: - Configure Views

extension MovieDetailsCell {

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
            ratingLabel.text = "Rating: \(rating)"
        }
    }
}

// MARK: - Configure Views
private extension MovieDetailsCell {
    
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
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                           constant: 8.0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                              constant: 8.0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                               constant: 8.0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: 8.0).isActive = true
    }
    
    func configurePosterImageView() {
        posterHolderView.addSubview(posterImageView)
        posterImageView.leadingAnchor.constraint(equalTo: posterHolderView.leadingAnchor).isActive = true
        posterImageView.trailingAnchor.constraint(equalTo: posterHolderView.trailingAnchor).isActive = true
        posterImageView.centerYAnchor.constraint(equalTo: posterHolderView.centerYAnchor).isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
    }
    
    func configureTitleView() {
        titleHolderView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: titleHolderView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: titleHolderView.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: titleHolderView.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: titleHolderView.bottomAnchor).isActive = true
    }
    
    func configureSummaryView() {
        summaryHolderView.addSubview(summaryLabel)
        summaryLabel.leadingAnchor.constraint(equalTo: summaryHolderView.leadingAnchor).isActive = true
        summaryLabel.trailingAnchor.constraint(equalTo: summaryHolderView.trailingAnchor).isActive = true
        summaryLabel.bottomAnchor.constraint(equalTo: summaryHolderView.bottomAnchor).isActive = true
        summaryLabel.topAnchor.constraint(equalTo: summaryHolderView.topAnchor).isActive = true
    }
}
