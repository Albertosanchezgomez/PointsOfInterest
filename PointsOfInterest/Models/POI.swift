//
//  POI.swift
//  PointsOfInterest
//
//  Created by Albertodev on 12/18/22.
//  Copyright © 2022 Alberto Sanchez. All rights reserved.
//


import Foundation
import SwiftUI

struct POI: Hashable, Identifiable, Decodable {
    var id: String
    var title: String
    var geocoordinates: String
    var image: String
}
