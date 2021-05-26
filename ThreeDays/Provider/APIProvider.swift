//
//  APIProvider.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/6.
//

import SwiftUI
import Combine

class APIProvider {
    static let ak = "sRTP3Lzp3BB6qI6GPCXnpuquksrow2CM"
    static var shared = APIProvider()
    
    enum Error: LocalizedError, Identifiable {
        var id: String {
            localizedDescription
        }
        
        case urlError(URL)
        case invalidResponse
        
        var errorDescription: String? {
            switch self {
                case .urlError(let url):
                    return "\(url.absoluteString) 地址错误"
                case .invalidResponse:
                    return "服务器响应错误"
            }
        }
    }
    
    enum EndPoint {
        case getWeather(_ districtId: String)
//        case getPlace(_ name: String)
        
        func getBaseUrl () -> URLComponents {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.map.baidu.com"
            return components
        }
        
        var url: URL {
            var component: URLComponents
            
            switch self {
                case .getWeather(let districtId):
                    var components = getBaseUrl()
                    components.path = "/weather/v1/"
                    components.queryItems = [
                        .init(name: "district_id", value: String(districtId)),
                        .init(name: "data_type", value: "all"),
                        .init(name: "ak", value: APIProvider.ak),
                        .init(name: "Cache-Control", value: "no-cache")
                    ]
                    component = components
                    
//                case .getPlace(let name):
//                    var components = getBaseUrl()
//                    components.path = "/place/v2/search"
//                    components.queryItems = [
//                        .init(name: "query", value: name),
//                        .init(name: "region", value: "全国"),
//                        .init(name: "ak", value: APIProvider.ak),
//                        .init(name: "output", value: "json"),
//                        .init(name: "extensions_adcode", value: String(true))
//                    ]
//                    component = components
            }
            
            return component.url!
        }
    }
    
    private let decoder = JSONDecoder()
    private let queue = DispatchQueue(label: "WeatherService", qos: .default)
    
//    func getPlace(name: String) -> AnyPublisher<LocationModel, Error> {
//        print("District URI",  EndPoint.getPlace(name).url)
//        return URLSession.shared
//            .dataTaskPublisher(for: EndPoint.getPlace(name).url)
//            .receive(on: queue)
//            .map { $0.0 }
//            .decode(type: LocationModel.self, decoder: decoder)
//            .mapError { error in
//                switch error {
//                    case is URLError:
//                        return Error.urlError(EndPoint.getPlace(name).url)
//                    default:
//                        return Error.invalidResponse
//                }
//            }
//            .eraseToAnyPublisher()
//    }
    
    func getWeather(districtId: String) -> AnyPublisher<WeatherModel, Error> {
        print("天气URI",  EndPoint.getWeather(districtId).url)
        let config = URLSessionConfiguration.ephemeral
        let sessionWorker = URLSession(configuration: config)
        return sessionWorker
            .dataTaskPublisher(for: EndPoint.getWeather(districtId).url)
            .receive(on: queue)
            .map { $0.0 }
            .decode(type: WeatherModel.self, decoder: decoder)
            .mapError { error in
                switch error {
                    case is URLError:
                        return Error.urlError(EndPoint.getWeather(districtId).url)
                    default:
                        return Error.invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }
}
