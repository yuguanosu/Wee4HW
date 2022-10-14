import XCTest
@testable import MyLibrary

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

    //myunittest
    func testWeatherModel() async {

        //let myTemp = Weather.self()

        //XCTAssertNil(myTemp)

        let jasonString = """
        {
            "coord": {
                "lon": 10.99,
                "lat": 44.34
            },
            "weather": [
                {
                "id": 501,
                "main": "Rain",
                "description": "moderate rain",
                "icon": "10d"
                }
            ],
            "base": "stations",
            "main": {
                "temp": 298.48,
                "feels_like": 298.74,
                "temp_min": 297.56,
                "temp_max": 300.05,
                "pressure": 1015,
                "humidity": 64,
                "sea_level": 1015,
                "grnd_level": 933
            },
            "visibility": 10000,
            "wind": {
                "speed": 0.62,
                "deg": 349,
                "gust": 1.18
            },
            "rain": {
                "1h": 3.16
            },
            "clouds": {
                "all": 100
            },
            "dt": 1661870592,
            "sys": {
                "type": 2,
                "id": 2075663,
                "country": "IT",
                "sunrise": 1661834187,
                "sunset": 1661882248
            },
            "timezone": 7200,
            "id": 3163858,
            "name": "Zocca",
            "cod": 200
        }
        """
        let data = Data(jasonString.utf8)
        
        do{
            let jsonData = try JSONDecoder().decode(Weather.self, from: data)
            XCTAssertEqual(jsonData.main.temp, 298.48)
        }catch{
            XCTAssert(false)
        }
        
        
    }

/*
    //my integration test
    func testIsNotLuckyBecauseServiceCallFails123() async {
        // Given
        
        let myLibrary = MyLibrary(weatherService: nil)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)

        // Then
        XCTAssertNotNil(isLuckyNumber)
    }

*/
}
