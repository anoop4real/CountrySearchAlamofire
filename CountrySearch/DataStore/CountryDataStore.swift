//
//  CountryDataStore.swift
//  CountrySearch
//
//  Created by anoopm on 09/11/17.
//  Copyright © 2017 anoopm. All rights reserved.
//

import Foundation

class CountryDataStore {
    fileprivate var isFilterApplied = false
    fileprivate var filteredArray = [Country]()
    fileprivate var normalArray = [Country]()

    private var networkManager = NetworkDataManager()
    // Private Init
    private init() {
        preparedata()
    }

    // MARK: Shared Instance

    private static let _shared = CountryDataStore()

    // MARK: - Accessors

    class func shared() -> CountryDataStore {
        return _shared
    }

    // Get the list of iso countries from NSLocale
    func preparedata() {
        for countryCode in NSLocale.isoCountryCodes {
            var countryName: String? = NSLocale().displayName(forKey: .countryCode, value: countryCode)
            if countryName == nil {
                countryName = NSLocale(localeIdentifier: "en_US").displayName(forKey: .countryCode, value: countryCode)
            }
            let simpleCountry = Country(countryName: countryName!, countryCode: countryCode.lowercased())
            normalArray.append(simpleCountry)
        }
        normalArray = normalArray.sorted(by: { $0.countryName < $1.countryName })
    }

    // Apply the user filter
    func filterBy(keyWord: String) {
        if keyWord.isEmpty {
            setFilterWith(status: false)
            return
        }
        filteredArray = normalArray.filter({ $0.countryName.lowercased().contains(keyWord.lowercased()) })
        setFilterWith(status: true)
    }

    // If user is searching then set the filter flag
    func setFilterWith(status: Bool) {
        isFilterApplied = status
    }

    // Cancel the ongoing request if the user hits back before data loads.
    func cancelOnGoingRequest() {
        // networkManager.cancelOnGoingTasks()
    }

    func fetchDetailsOfCountryWith(code: String, completion: @escaping (_ data: CountryViewModel?, _ error: Error?) -> Void) {
        NetworkDataManager.fetchDataForCountryWith(code) { [weak self] _, anyData in
            if let countryData = anyData {
                let jsonDecoder = JSONDecoder()
                do {
                    let responseModel = try jsonDecoder.decode(CountryData.self, from: countryData)
                    let vm = self?.createViewModelFrom(countryData: responseModel)
                    completion(vm, nil)
                } catch {
                    print(error.localizedDescription)
                    completion(nil, error)
                }

            } else {
                let error = NSError(domain: "FetchError", code: 99, userInfo: nil)
                completion(nil, error)
            }
        }
    }

    // From the JSON model, prepate the view model for display.
    func createViewModelFrom(countryData: CountryData) -> CountryViewModel? {
        let vm = CountryViewModel(with: countryData)
        return vm
    }
}

extension CountryDataStore: DataStoreProtocol {
    func sectionCount() -> Int {
        return 1
    }

    func rowsCountIn(section: Int) -> Int {
        var rowCount = 0

        if isFilterApplied {
            rowCount = filteredArray.count
        } else {
            rowCount = normalArray.count
        }
        return rowCount
    }

    func itemAt(row: Int) -> Country? {
        if isFilterApplied {
            return filteredArray[row]
        } else {
            return normalArray[row]
        }
    }
}
