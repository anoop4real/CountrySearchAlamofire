##Country Search

A small app to searach for details of a country.

* Supported IDE: `XCode 9, iOS 11 SDK`
* API Used: `https://restcountries.eu/rest/v2/alpha/{code}`
* `Codable` protocol for JSON to object.
* `SwiftSVG` used for SVG rendering
* `Alamofire` used for Network Activities

### Building

Please do a Carthage update after cloning so that libraries are properly updated

### Data Displayed

* Name
* Native Name
* Region
* Capital
* Area
* Languages
* German Translation of name
* Flag
* Location in map

### Thought Process

Initially the idea was to do an online search while user types in each character for the country, since the API doesnot support plain list of countries, we may have to parse the complete JSON which seem to be not optimal.

Found that list of countries and their code can be obtained from NSLocale, and used that for initial list which turns out to be faster for filtering without any API call. Once user selects the country , API call is being made to retrieve the required info of a country.

### Known Issues and Debts

`SwiftSVG` - Causes crash for some of the SVGs

 No offline functionalities done.

