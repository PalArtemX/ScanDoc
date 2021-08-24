//
//  ScannerDocView.swift
//  ScannerDoc
//
//  Created by Artem Palyutin on 23.08.2021.
//

import SwiftUI

struct ScannerDocView: View {
    
    @StateObject var vm = ScanVM()
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 140, maximum: 300))]
    
    var body: some View {
        NavigationView {
            VStack {
                if vm.scan.count > 0 {
                    
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(vm.scan) { text in
                                NavigationLink(
                                    destination: ScrollView {
                                        Text(text.content)
                                            .padding()
                                    },
                                    label: {
                                        TextContentView(text: text.content)
                                            .frame(maxHeight: 200)
                                    })
                            }
                        }
                    }
                } else {
                    NoScanView(show: $vm.showScannerSheet)
                }
                
                
            } // VStack
            .sheet(isPresented: $vm.showScannerSheet) {
                vm.makeScannerView()
            }
            .navigationBarItems(trailing:
                                    Button(action: {
                                        vm.showScannerSheet.toggle()
                                    }, label: {
                                        if vm.scan.count > 0 {
                                            HStack {
                                                Text("Add Doc")
                                                Image(systemName: "doc.text.viewfinder")
                                            }
                                            .font(.headline)
                                        }
                                        
                                    }))
            
            //.navigationTitle("Scanner Doc")
        } // NavigationView
    }
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerDocView()
    }
}

struct NoScanView: View {
    
    @Binding var show: Bool
    var body: some View {
        VStack {
            HStack {
                Text("No Scanned Documents")
                Image(systemName: "viewfinder")
                
            }
            .padding()
            .foregroundColor(Color(.systemGray))
            
            Button(action: {
                show.toggle()
            }, label: {
                HStack {
                    Text("Scan Doc")
                    Image(systemName: "doc.text.viewfinder")
                }
                .font(.headline)
            })
            .padding()
            
        }
        
    }
}
