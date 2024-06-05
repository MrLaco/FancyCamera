//
//  CustomImageButton.swift
//  FancyCamera
//
//  Created by user on 31.05.2024.
//

import UIKit

final class CaptureImageButton: UIButton {
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 72, height: 72)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = intrinsicContentSize.height / 2
        self.layer.borderWidth = 4
        self.layer.borderColor = UIColor.systemBlue.cgColor
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
