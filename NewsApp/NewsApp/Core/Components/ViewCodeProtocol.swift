//
//  ViewCodeProtocol.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 21/05/24.
//

import Foundation

protocol ViewCodeProtocol: AnyObject {
    func setupViewHierarchy()
    func setupViewConstraints()
    func setupViewAditionalConfiguration()
    func setupView()
}

extension ViewCodeProtocol {
    func setupView() {
        setupViewHierarchy()
        setupViewConstraints()
        setupViewAditionalConfiguration()
    }
}
