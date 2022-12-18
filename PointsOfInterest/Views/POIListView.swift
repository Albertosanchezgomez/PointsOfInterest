//
//  UserListView.swift
//  PointsOfInterest
//
//  Created by Albertodev on 12/18/22.
//  Copyright © 2022 AlbertoDev. All rights reserved.
//


import SwiftUI

struct POIListView: View {
    
    @StateObject var realmManager = RealmManager()
    @ObservedObject var viewModel = POIViewModel()
    @State private var isActive = false
    @State private var isLoaded = false
    @State var pois = [POILocal]()
    @State var text = ""
    @State var detailText = ""
    @State var detailImage = ""
    
    // MARK: View

    var body: some View {
        
        NavigationView{
            VStack(alignment: .center) {
                HStack {
                    TextField("", text: $text)
                        .padding(.leading, 20)
                        .frame(height: 32)
                        .background(Color.gray)
                        .cornerRadius(16)
                        .foregroundColor(.white)
                    
                    Button("search") {
                        self.filter(text: text)
                    }
                    .foregroundColor(Color.white)
                }
                .background(Color.black)
                .padding(.leading, 20)

                List(self.pois) { user in
                    Text(user.title)
                        .onTapGesture {
                            
                            self.detailText = user.title
                            self.detailImage = user.image
                            
                            openDetail()
                            
                        }
                    
                }
                .listRowBackground(Color.white)
                .navigationTitle("pointsOfInterest")
                .navigationBarTitleDisplayMode(.inline)
                
                NavigationLink(destination: POIDetailView(img: self.detailImage, text: self.detailText), isActive: $isActive){}
            }
        }
        .onAppear {
            initView()
        }
        
    }
    
    // MARK: Functions

    func openDetail(){
        
        //Toggle boolean to navigate to next view
        isActive.toggle()
    }
    
    func initView(){
        
        //Called when view appears and check if we have data on data base
        //If not, does the call and fill pois

        if(realmManager.localPOIs.count == 0){
            
            self.viewModel.fetch{
                self.realmManager.addPOIs(pois: self.viewModel.pois){
                    self.pois = realmManager.localPOIs
                }
            }

        } else {
        
        //If we have data, we get it from database

            self.pois = realmManager.localPOIs
        }
    }
    
    func filter(text: String) {
        
        //Filter local pois with the text

        self.pois = realmManager.localPOIs
        
        if(text == ""){
            
            self.pois = self.pois
            
        } else {
            
            self.pois = pois.filter { $0.title.contains(text)}
            
        }
    }
    
}
