//
//  ViewController.swift
//  FancyCamera
//
//  Created by user on 31.05.2024.
//

import UIKit
import AVFoundation

final class CameraViewController: UIViewController {

    private lazy var bottomBar = BottomBarView()
    private lazy var topBar = TopBarView()
    
    private var cameraService: CameraService
    
    // MARK: - Init

    init(cameraService: CameraService) {
        self.cameraService = cameraService
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraService.delegate = self
        checkPermissions()
        setupPreviewLayer()
        setupUI()
    }

    // MARK: - Setup

    private func setupUI() {
        setupZoomRecognizer()

        view.addSubview(topBar)
        view.addSubview(bottomBar)

        bottomBar.delegate = self

        bottomBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.23).isActive = true

        topBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.14).isActive = true
    }

    private func setupZoomRecognizer() {
        let zoomRecognizer = UIPinchGestureRecognizer()
        zoomRecognizer.addTarget(self, action: #selector(didPinch(_:)))
        view.addGestureRecognizer(zoomRecognizer)
    }

    private func setupPreviewLayer() {
        let previewLayer = AVCaptureVideoPreviewLayer(session: cameraService.captureSession) as AVCaptureVideoPreviewLayer

        previewLayer.frame = view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
    }
}

// MARK: - BottomBar Delegate

extension CameraViewController: BottomBarDelegate {

    func switchCamera() {
        cameraService.switchCameraInput()

        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }

    func takePhoto() {
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.flashMode = topBar.isTorchOn ? .on : .off
        cameraService.photoOutput.capturePhoto(with: photoSettings, delegate: cameraService)

        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

extension CameraViewController {

    @objc private func didPinch(_ recognizer: UIPinchGestureRecognizer) {
        if recognizer.state == .changed {
            cameraService.setZoom(scale: recognizer.scale)
        }
    }
}

// MARK: - Checking Permisions

extension CameraViewController {

    private func checkPermissions() {
        let cameraAuthStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch cameraAuthStatus {
        case .authorized:
            return
        case .denied:
            abort()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler:
                                            { (authorized) in
                if(!authorized){
                    abort()
                }
            })
        case .restricted:
            abort()
        @unknown default:
            fatalError()
        }
    }
}

// MARK: - Camera Service Delegate

extension CameraViewController: CameraServiceDelegate {

    func setPhoto(image: UIImage) {
        bottomBar.setupPhoto(image: image)
    }
}
