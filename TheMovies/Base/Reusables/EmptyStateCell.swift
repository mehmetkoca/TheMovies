//
//  EmptyStateCell.swift
//  TheMovies
//
//  Created by Mehmet Koca on 18.10.2020.
//

import UIKit

final class EmptyStateCell: UITableViewCell {
    
    private let titleHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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

extension EmptyStateCell {

    func set(text: String) {
        titleLabel.text = text
    }
}

// MARK: - Configure Views

private extension EmptyStateCell {
    
    func configureViews() {
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0)
        ])
    }
}
