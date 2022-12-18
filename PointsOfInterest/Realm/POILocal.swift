//
//  POILocal.swift
//  PointsOfInterest
//
//  Created by Albertodev on 12/18/22.
//  Copyright © 2022 AlbertoDev. All rights reserved.
//

import Foundation
import RealmSwift

class POILocal: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String
    @Persisted var geocoordinates: String
    @Persisted var image: String

}
