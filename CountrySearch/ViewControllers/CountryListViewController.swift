//
//  CountryListViewController.swift
//  CountrySearch
//
//  Created by anoopm on 08/11/17.
//  Copyright © 2017 anoopm. All rights reserved.
//

import UIKit

class CountryListViewController: BaseViewController, SegueHandlerType {

    @IBOutlet private weak var countryListTableView: UITableView!
    fileprivate var store = CountryDataStore.shared()
    fileprivate var searchController: UISearchController!
    enum SegueIdentifier: String {
        case ShowDetails
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)

        searchController.searchResultsUpdater = self

        searchController.dimsBackgroundDuringPresentation = false

        searchController.searchBar.placeholder = NSLocalizedString("Enter country name...", comment: "Place holder string in Searchbar")
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        self.definesPresentationContext = true
        countryListTableView.tableHeaderView = searchController.searchBar
    }

    // MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if isReachable() {
            return true
        } else {
            displayNetworkError()
            return false
        }
    }
    // Right now the list of coutries are loaded from OS and the below code tried to get the country data once the user types a letter, this is yet to be completed, just a test code.
    @objc fileprivate func reload(){
        searchController.searchBar.isLoading = true
        store.fetchDetailsOfCountryWith(code: "in") { (model, error) in
            print("Fetched data")
            DispatchQueue.main.async {
                self.searchController.searchBar.isLoading = false
            }
            
        }
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        switch segueIdentifierForSegue(segue: segue) {
        case .ShowDetails:
            print("ShowDetails")
            guard let indexPath = countryListTableView.indexPathForSelectedRow else {

                fatalError("Couldnt find the clicked index path")
            }
            guard let selectedCountry = store.itemAt(row: indexPath.row) else {
                fatalError("Couldnt find the country")
            }
            // So indexpath exists
            let countryDetailsVC = segue.destination as! CountriesDetailViewController

            countryDetailsVC.selectedCountryCode = selectedCountry.countryCode
            countryListTableView.deselectRow(at: indexPath, animated: true)
        }
    }

}

extension CountryListViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {

        return store.sectionCount()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return store.rowsCountIn(section: section)
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        if let item = store.itemAt(row: indexPath.row) {
            cell.textLabel?.text = item.countryName
        }
        return cell
    }
}

extension CountryListViewController:UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else {
            return
        }
        // Right now the list of coutries are loaded from OS and the below code tried to get the country data once the user types a letter, this is yet to be completed, just a test code.
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reload), object: nil)
        self.perform(#selector(reload), with: nil, afterDelay: 0.5)

        store.filterBy(keyWord: searchString)
        // reload tableview
        countryListTableView.reloadData()
    }
}

extension CountryListViewController:UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        store.setFilterWith(status: true)
        //countryListTableView.reloadData()
    }


    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        store.setFilterWith(status: false)
        countryListTableView.reloadData()
    }
}
