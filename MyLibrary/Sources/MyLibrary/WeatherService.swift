import Alamofire

public protocol WeatherService {
    func getTemperature() async throws -> Int
}

enum BaseUrl: String {
    case openweathermap = "https://api.openweathermap.org"
    case mockServer = "http://localhost:3000"
}

class WeatherServiceImpl: WeatherService {
    var url = "/data/2.5/weather"
    public init(baseUrl: BaseUrl=BaseUrl.mockServer){
        self.url = "\(baseUrl.rawValue)" + url
        print(self.url)
    }
    
    func getTemperature() async throws -> Int {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Weather.self) {
    
                response in
                print(response.result)
                switch response.result {
                case let .success(weather):
                    print(weather)
                    let temperature = weather.main.temp
                    let temperatureAsInteger = Int(temperature)
                    continuation.resume(with: .success(temperatureAsInteger))
                case let .failure(error):
                    print("fails")
                    
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
}

public struct Weather: Decodable {
    let main: Main

    struct Main: Decodable {
        let temp: Double
    }
}
