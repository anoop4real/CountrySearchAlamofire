/*
 Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

 For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

 */

import Foundation
struct CountryData: Codable {
    let name: String?
    let topLevelDomain: [String]?
    let alpha2Code: String?
    let alpha3Code: String?
    let callingCodes: [String]?
    let capital: String?
    let altSpellings: [String]?
    let region: String?
    let subregion: String?
    let population: Double?
    let latlng: [Double]?
    let demonym: String?
    let area: Double?
    let gini: Double?
    let timezones: [String]?
    let borders: [String]?
    let nativeName: String?
    let numericCode: String?
    let currencies: [Currencies]?
    let languages: [Languages]?
    let translations: Translations?
    let flag: String?
    let regionalBlocs: [RegionalBlocs]?
    let cioc: String?

    enum CodingKeys: String, CodingKey {
        case name
        case topLevelDomain
        case alpha2Code
        case alpha3Code
        case callingCodes
        case capital
        case altSpellings
        case region
        case subregion
        case population
        case latlng
        case demonym
        case area
        case gini
        case timezones
        case borders
        case nativeName
        case numericCode
        case currencies
        case languages
        case translations
        case flag
        case regionalBlocs
        case cioc
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        topLevelDomain = try values.decodeIfPresent([String].self, forKey: .topLevelDomain)
        alpha2Code = try values.decodeIfPresent(String.self, forKey: .alpha2Code)
        alpha3Code = try values.decodeIfPresent(String.self, forKey: .alpha3Code)
        callingCodes = try values.decodeIfPresent([String].self, forKey: .callingCodes)
        capital = try values.decodeIfPresent(String.self, forKey: .capital)
        altSpellings = try values.decodeIfPresent([String].self, forKey: .altSpellings)
        region = try values.decodeIfPresent(String.self, forKey: .region)
        subregion = try values.decodeIfPresent(String.self, forKey: .subregion)
        population = try values.decodeIfPresent(Double.self, forKey: .population)
        latlng = try values.decodeIfPresent([Double].self, forKey: .latlng)
        demonym = try values.decodeIfPresent(String.self, forKey: .demonym)
        area = try values.decodeIfPresent(Double.self, forKey: .area)
        gini = try values.decodeIfPresent(Double.self, forKey: .gini)
        timezones = try values.decodeIfPresent([String].self, forKey: .timezones)
        borders = try values.decodeIfPresent([String].self, forKey: .borders)
        nativeName = try values.decodeIfPresent(String.self, forKey: .nativeName)
        numericCode = try values.decodeIfPresent(String.self, forKey: .numericCode)
        currencies = try values.decodeIfPresent([Currencies].self, forKey: .currencies)
        languages = try values.decodeIfPresent([Languages].self, forKey: .languages)
        translations = try values.decodeIfPresent(Translations.self, forKey: .translations)
        // translations = try Translations(from: decoder)
        flag = try values.decodeIfPresent(String.self, forKey: .flag)
        regionalBlocs = try values.decodeIfPresent([RegionalBlocs].self, forKey: .regionalBlocs)
        cioc = try values.decodeIfPresent(String.self, forKey: .cioc)
    }
}
