//
//  ScanVM.swift
//  ScannerDoc
//
//  Created by Artem Palyutin on 24.08.2021.
//

import Foundation


class ScanVM: ObservableObject {
    
    @Published var scan: [Scan] = []
    @Published var showScannerSheet = false
    
    
    // MARK: - func
    func makeScannerView() -> ScannerView {
        ScannerView { textPerPage in
            if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines) {
                let newScanData = Scan(content: outputText)
                self.scan.append(newScanData)
            }
            self.showScannerSheet.toggle()
        }
    }
}
