//
//  ScannerView.swift
//  ScannerDoc
//
//  Created by Artem Palyutin on 23.08.2021.
//

import SwiftUI
import VisionKit


struct ScannerView: UIViewControllerRepresentable {

    typealias UIViewControllerType = VNDocumentCameraViewController
    
    private let comletionHandler: ([String]?) -> Void
    
    init(comletion: @escaping ([String]?) -> Void) {
        comletionHandler = comletion
    }
    
    // MARK: - Coordinator
    final class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        private let completionHandler: ([String]?) -> Void
        
        init(completion: @escaping ([String]?) -> Void) {
            self.completionHandler = completion
        }
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            let recognizer = TextRecognizer(cameraScan: scan)
            recognizer.recognizeText(withCompletionHandler: completionHandler)
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            completionHandler(nil)
        }
        
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            completionHandler(nil)
        }
    }
    
    
    // MARK: - func
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(completion: comletionHandler)
    }
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let viewController = VNDocumentCameraViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
        
    }
    

}

