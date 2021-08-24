//
//  TextRecognizer.swift
//  ScannerDoc
//
//  Created by Artem Palyutin on 23.08.2021.
//

import Foundation
import Vision
import VisionKit


class TextRecognizer {
    let cameraScan: VNDocumentCameraScan
    
    init(cameraScan: VNDocumentCameraScan) {
        self.cameraScan = cameraScan
    }
    
    private let queue = DispatchQueue(label: "scan-codes", qos: .default, attributes: [], autoreleaseFrequency: .workItem)
    
    
    // MARK: - func
    func recognizeText(withCompletionHandler: @escaping ([String]) -> Void) {
        queue.async {
            let images = (0..<self.cameraScan.pageCount).compactMap({
                self.cameraScan.imageOfPage(at: $0).cgImage
            })
            let imagesAndRequest = images.map({ (image: $0, request: VNRecognizeTextRequest()) })
            let textPerPage = imagesAndRequest.map { image, request -> String  in
                let handler = VNImageRequestHandler(cgImage: image, options: [:])
                do {
                    try handler.perform([request])
                    guard let observation = request.results as? [VNRecognizedTextObservation] else { return "" }
                    return observation.compactMap( {$0.topCandidates(1).first?.string } ).joined(separator: "\n")
                    
                } catch {
                    print(error)
                    return ""
                }
            }
            DispatchQueue.main.async {
                withCompletionHandler(textPerPage)
            }
        }
    }
}

