//
//  APIService.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/6.
//

import SwiftUI
import Combine

class APIService {
    #if PRODUCTION
    static var key = "fa337af718794348960d3e498713ca0d"
    static var host = "api.qweather.com"
    #else
    static var key = "cd6eff2f582c41b4b6763a9e04c74655"
    static var host = "devapi.qweather.com"
    #endif
  
    static var shared = APIService()
    
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
        case getWeatherNow(_ location: String)
        case getWeatherDaily(_ location: String, daily: String = "3d")
        case getWeatherHourly(_ location: String, hour: String = "24h")
        
        func getBaseUrl () -> URLComponents {
            var components = URLComponents()
            components.scheme = "https"
            components.host = APIService.host
            
            components.queryItems = [
                .init(name: "key", value: APIService.key),
                .init(name: "Cache-Control", value: "no-cache")
            ]
            
            return components
        }
        
        var url: URL {
            var component: URLComponents
        
            switch self {
                case .getWeatherNow(let location):
                    var components = getBaseUrl()
                    components.path = "/v7/weather/now"
                    components.queryItems?.append(.init(name: "location", value: location))
                    component = components
                    
                case .getWeatherDaily(let location, let daily):
                    var components = getBaseUrl()
                    components.path = "/v7/weather/\(daily)"
                    components.queryItems?.append(.init(name: "location", value: location))
                    component = components
                   
                case .getWeatherHourly(let location, let hour):
                    var components = getBaseUrl()
                    components.path = "/v7/weather/\(hour)"
                    components.queryItems?.append(.init(name: "location", value: location))
                    component = components
            }
            
            return component.url!
        }
    }
    
    private let decoder = JSONDecoder()
    private let queue = DispatchQueue(label: "WeatherService", qos: .default, attributes: .concurrent)
    
    func getWeatherNow(_ location: String) -> AnyPublisher<WeatherNowModel, Error> {
        let config = URLSessionConfiguration.ephemeral
        let sessionWorker = URLSession(configuration: config)
        return sessionWorker
            .dataTaskPublisher(for: EndPoint.getWeatherNow(location).url)
            .receive(on: queue)
            .map { $0.0 }
            .decode(type: WeatherNowModel.self, decoder: decoder)
            .mapError { error in
                switch error {
                    case is URLError:
                        return Error.urlError(EndPoint.getWeatherNow(location).url)
                    default:
                        return Error.invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getWeatherDaily(_ location: String, daily: String = "3d") -> AnyPublisher<WeatherDailyModel, Error> {
        let config = URLSessionConfiguration.ephemeral
        let sessionWorker = URLSession(configuration: config)
        return sessionWorker
            .dataTaskPublisher(for: EndPoint.getWeatherDaily(location, daily: daily).url)
            .receive(on: queue)
            .map { $0.0 }
            .decode(type: WeatherDailyModel.self, decoder: decoder)
            .mapError { error in
                switch error {
                    case is URLError:
                        return Error.urlError(EndPoint.getWeatherDaily(location, daily: daily).url)
                    default:
                        return Error.invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getWeatherHourly(_ location: String) -> AnyPublisher<WeatherHourlyModel, Error> {
        let config = URLSessionConfiguration.ephemeral
        let sessionWorker = URLSession(configuration: config)
        return sessionWorker
            .dataTaskPublisher(for: EndPoint.getWeatherHourly(location).url)
            .receive(on: queue)
            .map { $0.0 }
            .decode(type: WeatherHourlyModel.self, decoder: decoder)
            .mapError { error in
                switch error {
                    case is URLError:
                        return Error.urlError(EndPoint.getWeatherHourly(location).url)
                    default:
                        return Error.invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }
    
}
