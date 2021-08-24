//
//  TextContentView.swift
//  ScannerDoc
//
//  Created by Artem Palyutin on 24.08.2021.
//

import SwiftUI

struct TextContentView: View {
    
    let text: String
    
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                
                Color.colorTheme.background.cornerRadius(15)
                       
                Text(text)
                    .foregroundColor(.colorTheme.text)
                    .font(.subheadline)
                    .padding()

            }
            .animation(.spring())
            .padding()
        }
    }
}

struct TextContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TextContentView(text: "Content")
            TextContentView(text: "Content")
                .preferredColorScheme(.dark)
        }
    }
}
