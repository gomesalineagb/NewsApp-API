//
//  ArticleTableViewCell.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 21/05/24.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    private var image = UIImageView()
    private var author = UILabel()
    private var title = UILabel()
    private var content = UILabel()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupAuthorLabel()
        setupTitleLabel()
        setupContentLabel()
        setupImageView()
        setupConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
        author.text = nil
        title.text = nil
        content.text = nil
    }
    
    private func setupImageView() {
        image.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        
    }
    
    private func setupAuthorLabel() {
        author.font = .preferredFont(forTextStyle: .title3)
        author.numberOfLines = 0
    }
    
    private func setupTitleLabel() {
        title.font = .preferredFont(forTextStyle: .body)
        title.numberOfLines = 0
    }
    
    private func setupContentLabel() {
        content.font = .preferredFont(forTextStyle: .caption2)
        content.numberOfLines = 0
    }
    
    private func setupConstraints() {
        [image, author, title, content].forEach { view in
            contentView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 100),
            image.widthAnchor.constraint(equalToConstant: 230),
            author.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            author.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            author.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            title.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 16),
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            content.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
        
    }
    
    func setImage(image: UIImage?) {
        self.image.image = image
    }
    
    func setupCell(with dto: DTO) {
        image.image = dto.image
        author.text = dto.author
        title.text = dto.title
        content.text = dto.content
    }

}

// MARK: - DTO
extension ArticleTableViewCell {
    struct DTO {
        var image: UIImage? = nil
        var author: String?
        var title: String
        var content: String
    }
}
