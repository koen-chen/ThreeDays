//
//  PlaceSearchViewModel.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/21.
//

import SwiftUI
import Combine

class PlaceSearchViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    
    @Published private (set) var searchCitys: [ChinaPlace.Place] = []
    @Published var searchText: String = ""
    
    init() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
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
        self.searchCitys = ChinaPlace.shared.searchPlace(seachText)
    }
}

