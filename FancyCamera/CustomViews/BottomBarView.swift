//
//  BottomBarView.swift
//  FancyCamera
//
//  Created by user on 31.05.2024.
//

import UIKit

protocol BottomBarDelegate: AnyObject {
    
    func switchCamera()
    func takePhoto()
}

final class BottomBarView: UIView {
    
    weak var delegate: BottomBarDelegate?
    
    private lazy var captureImageButton = CaptureImageButton()
    
    private lazy var switchCameraButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        button.setImage(UIImage(systemName: "arrow.triangle.2.circlepath",
                                withConfiguration: UIImage.SymbolConfiguration.init(pointSize: 25)),
                        for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var lastPhotoView = LastPhotoView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        self.addSubview(captureImageButton)
        self.addSubview(switchCameraButton)
        self.addSubview(lastPhotoView)
        
        self.backgroundColor = .black.withAlphaComponent(0.5)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        captureImageButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        captureImageButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        switchCameraButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        switchCameraButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switchCameraButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        switchCameraButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        lastPhotoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        lastPhotoView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lastPhotoView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        lastPhotoView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        captureImageButton.addTarget(self, action: #selector(captureImage(_:)), for: .touchUpInside)
        switchCameraButton.addTarget(self, action: #selector(switchCamera(_:)), for: .touchUpInside)
    }
    
    // MARK: - Obj-c
    
    @objc private func captureImage(_ sender: UIButton?) {
        self.delegate?.takePhoto()
    }
    
    @objc private func switchCamera(_ sender: UIButton?) {
        self.delegate?.switchCamera()
    }
    
    func setupPhoto(image: UIImage) {
        self.lastPhotoView.imageView.image = image
    }
}
