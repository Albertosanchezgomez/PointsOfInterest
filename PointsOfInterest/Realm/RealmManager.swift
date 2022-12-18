//
//  RealmManager.swift
//  PointsOfInterest
//
//  Created by Albertodev on 12/18/22.
//  Copyright © 2022 AlbertoDev. All rights reserved.
//


import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    
    private(set) var localRealm: Realm?
    @Published private(set) var localPOIs : [POILocal] = []
    
    // MARK: Init
    
    init() {
        openRealm()
        getPOIs()
    }
    
    // MARK: Functions

    
    func openRealm(){
        
        //Init Realm

        do {
            
            let config = Realm.Configuration(schemaVersion: 1)
            
            Realm.Configuration.defaultConfiguration = config
            
            localRealm = try Realm()
            
        } catch {
            print("Realm error: \(error)")
        }
    }
    
    func addPOIs(pois: [POI], updated: () -> Void){
        
        //Add Points of interest to database

        if let localRealm = localRealm {
            
            do{
                try localRealm.write {
                    
                    pois.forEach{ poi in
                        let newPOI = POILocal(value: ["id": poi.id, "title": poi.title,
                                                      "geocoordinates": poi.geocoordinates, "image": poi.image])
                        
                        localRealm.add(newPOI)
                    }
                }
                
            } catch {
                print("error adding POIs: \(error)")
            }
            
            //Update local POIs
            getPOIs()
            updated()

        }
    }
    
    func getPOIs(){
        
        //Retrieve all Points of interest from database

        if let localRealm = localRealm {
            
            let allPois = localRealm.objects(POILocal.self)
            localPOIs = []
            
            allPois.forEach{ poi in
                localPOIs.append(poi)
            }
        }
    }
    
}



