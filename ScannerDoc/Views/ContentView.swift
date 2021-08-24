//
//  ContentView.swift
//  ScannerDoc
//
//  Created by Artem Palyutin on 23.08.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showScannerSheet = false
    @StateObject var vm = ScanVM()
    
    var body: some View {
        NavigationView {
            VStack {
                if vm.scan.count > 0 {
                    List {
                        ForEach(vm.scan) { text in
                            NavigationLink(
                                destination: ScrollView {
                                    Text(text.content)
                                },
                                label: {
                                    Text(text.content).lineLimit(1)
                                })
                        }
                    }
                } else {
                    Text("No scan")
                }
            }
            
            .sheet(isPresented: $showScannerSheet, content: {
                makeScannerView()
            })
            
            .navigationBarItems(trailing:
                                    Button(action: {
                                        showScannerSheet.toggle()
                                    }, label: {
                                        HStack {
                                            Text("New Doc")
                                            Image(systemName: "doc.text.viewfinder")
                                        }
                                        .font(.headline)
                                    }))
            
            .navigationTitle("Scanner")
        } // NavigationView
    }
    
    private func makeScannerView() -> ScannerView {
        ScannerView { textPerPage in
            if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines) {
                let newScanData = Scan(content: outputText)
                self.vm.scan.append(newScanData)
            }
            self.showScannerSheet.toggle()
        }
    }
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
