//
//  NewsDetailsContainerView.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 21/05/24.
//

import UIKit

class NewsDetailsContainerView: UIView {
    
    private var imageView = UIImageView()
    private var date = UILabel()
    private var content = UILabel()
    
    private func setupImageView() {
        let imageView = UIImageView(frame: .zero)
        imageView.layer.cornerRadius = 10
        layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        self.imageView = imageView
    }
    
    private func setupDateLabel() {
        let date = UILabel()
        date.font = .preferredFont(forTextStyle: .title3)
        date.numberOfLines = 0
        
        self.date = date
    }
    
    private func setupContentLabel() {
        let content = UILabel()
        content.font = .preferredFont(forTextStyle: .body)
        content.numberOfLines = 0
        
        self.content = content
    }
    
    func setupView(with dto: DTO) {
        imageView.image = dto.image
        date.text = dto.date
        content.text = dto.content
    }
}

// MARK: DTO
extension NewsDetailsContainerView {
    struct DTO {
        var image: UIImage?
        var date: String
        var content: String
    }
}

// MARK: - ViewCodeProtocol
extension NewsDetailsContainerView: ViewCodeProtocol {
    func setupViewHierarchy() {
        setupImageView()
        setupDateLabel()
        setupContentLabel()
        [imageView, date, content].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
            
        }
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupViewConstraints() {
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.widthAnchor.constraint(equalToConstant: 430),
            date.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            date.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            date.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            content.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            content.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            content.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 8),
            content.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
        ])
    }
}
