//
//  LastPhotoView.swift
//  FancyCamera
//
//  Created by user on 31.05.2024.
//

import UIKit
import SnapKit

final class LastPhotoView: UIView {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.systemBlue
        self.layer.cornerRadius = 10
        
        addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 2).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
    }
    
}
