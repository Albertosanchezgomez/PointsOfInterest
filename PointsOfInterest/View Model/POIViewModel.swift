//
//  POIViewModel.swift
//  PointsOfInterest
//
//  Created by Albertodev on 12/18/22.
//  Copyright © 2022 AlbertoDev. All rights reserved.
//

import SwiftUI
import Combine

final class POIViewModel: ObservableObject {
    
    @Published private(set) var pois : [POI] = []
    private var time : Double = 1.0
    
    private var poiCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    deinit {
        poiCancellable?.cancel()
    }
    
    func fetch(finished: @escaping () -> Void) {
        
        let request = URLRequest(url: URL(string: Constants.baseUrl)!)
        
        poiCancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: POIResponse.self, decoder: JSONDecoder())
            .map { $0.list }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .assign(to: \.pois, on: self)

            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                finished()
            }
        }
    }
    
    

