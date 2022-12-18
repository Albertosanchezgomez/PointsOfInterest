//
//  POIDetailView.swift
//  PointsOfInterest
//
//  Created by Albertodev on 12/18/22.
//  Copyright © 2022 AlbertoDev. All rights reserved.
//


import SwiftUI

struct POIDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var img = ""
    @State var text = ""
    
    // MARK: View

    var body: some View {
        VStack{
            Text(text)
            AsyncImage(
                url: URL(string: img),
                content: { image in
                    image
                        .resizable()
                        .frame(minWidth: 300, maxWidth: 300, minHeight: 150, maxHeight: 150)
                },
                placeholder: {
                    ProgressView()
                }
            )
        }
        .font(.title)
        .padding()
        .background(.black)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
           Button(action: backButtonPressed) {
            HStack {
                Image(systemName: "arrow.left")
                    .tint(.gray)
            }
        })
    }
    
    // MARK: Functions

    func backButtonPressed(){
        
        //Dismiss current view
        self.presentationMode.wrappedValue.dismiss()
    }
}

