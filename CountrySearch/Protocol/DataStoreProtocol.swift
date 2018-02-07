//
//  DataStoreProtocol.swift
//  CountrySearch
//
//  Created by anoopm on 09/11/17.
//  Copyright © 2017 anoopm. All rights reserved.
//

import Foundation

protocol DataStoreProtocol {

    associatedtype T
    func sectionCount() -> Int
    func rowsCountIn(section: Int) -> Int
    func itemAt(row: Int) -> T?
}
