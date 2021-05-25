//
//  CitySearchViewModel.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/21.
//

import SwiftUI
import Combine

class CitySearchViewModel: ObservableObject {
    @EnvironmentObject var weatherStore: WeatherViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    @Published private (set) var searchCitys: [PlaceModel] = []
    @Published var searchText: String = ""
    
    init() {
        $searchText
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { (string) -> String? in
                if string.count < 1 {
                    self.searchCitys = []
                    return nil
                }
                
                return string
            }
            .compactMap { $0 }
            .sink { completion in
            } receiveValue: { searchField in
                self.searchItems(searchField)
            }
            .store(in: &subscriptions)
    }
    
    private func searchItems(_ seachText: String) {
        self.searchCitys = PlaceCSV.shared.searchPlace(seachText)
        
        print(self.searchCitys)
    }
}

