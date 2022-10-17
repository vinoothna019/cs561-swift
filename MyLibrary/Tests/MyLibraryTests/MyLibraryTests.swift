import XCTest
@testable import MyLibrary

let JsonString = """
{
    "main":{
        "temp": 38
        }
}
"""

let JsonString2 = """
{
    "main":{
        "random": "somestring"
        }
}
"""

let JsonString3 = """
{
    "somekey":{
        "temp": 38
    }
}
"""

final class MyLibraryTests: XCTestCase {
    
    
    func testIsLuckyBecauseWeAlreadyHaveLuckyNumber() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(8)
        

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }

    func testIsLuckyBecauseWeatherHasAnEight() async throws {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: true
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(0)
        

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }

    func testIsNotLucky() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)
        

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == false)
    }

    func testIsNotLuckyBecauseServiceCallFails() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: false,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)
        

        // Then
        XCTAssertNil(isLuckyNumber)
    }
    func testTempInJsonString() async {
        //Given
        let jsonData = Data(JsonString.utf8)
        let jsonDecoder = JSONDecoder()
        
        //When
        let weather = try?jsonDecoder.decode(Weather.self, from: jsonData)
        let tempisright = weather?.main.temp
        
        //Then
        XCTAssertNotNil(weather)
        XCTAssert(tempisright == 38)
    }
    func testRandomInJsonString() async {
        //Given
        let jsonData = Data(JsonString2.utf8)
        let jsonDecoder = JSONDecoder()
        
        //When
        let weather = try?jsonDecoder.decode(Weather.self, from: jsonData)
        
        //Then
        XCTAssertNil(weather)
        XCTAssertNil(weather?.main.temp)
    }
    func testMainInJsonString() async {
        //Given
        let jsonData = Data(JsonString3.utf8)
        let jsonDecoder = JSONDecoder()
        
        //When
        let weather = try?jsonDecoder.decode(Weather.self, from: jsonData)
        
        //Then
        XCTAssertNil(weather)
        XCTAssertNil(weather?.main.temp)
    }
    
    //Integration Test
    func testWeatherService() async {
        let weatherService = WeatherServiceImpl(baseUrl: BaseUrl.openweathermap)
        
        let temp = try? await weatherService.getTemperature()
        
        XCTAssertNotNil(temp)
    }
}

