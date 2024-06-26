//
//  TopBarView.swift
//  FancyCamera
//
//  Created by user on 31.05.2024.
//

import UIKit

final class TopBarView: UIView {
    
    lazy var flashButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "bolt.circle",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)),
                        for: .normal)
        button.imageView?.contentMode = .scaleToFill
        button.addTarget(self, action: #selector(toggleFlash), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var isTorchOn = false {
        didSet {
            if isTorchOn {
                flashButton.tintColor = .systemBlue
            } else {
                flashButton.tintColor = .white
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .black.withAlphaComponent(0.5)
        
        addSubview(flashButton)
        
        flashButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        flashButton.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        flashButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        flashButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    @objc private func toggleFlash() {
        isTorchOn.toggle()
    }
}
