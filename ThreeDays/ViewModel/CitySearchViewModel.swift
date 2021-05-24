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
    
    //@Published private (set) var searchCitys: [PlaceModel] = [ThreeDays.PlaceModel(districtCode: 430600, city: "岳阳市", district: "岳阳", province: "湖南省", isAppLocation: nil, createdAt: nil), ThreeDays.PlaceModel(districtCode: 430602, city: "岳阳市", district: "岳阳楼区", province: "湖南省", isAppLocation: nil, createdAt: nil), ThreeDays.PlaceModel(districtCode: 430621, city: "岳阳市", district: "岳阳县", province: "湖南省", isAppLocation: nil, createdAt: nil)]
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

