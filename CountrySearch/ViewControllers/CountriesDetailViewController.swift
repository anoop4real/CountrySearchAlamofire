//
//  CountriesDetailViewController.swift
//  CountrySearch
//
//  Created by anoop mohanan on 13/11/17.
//  Copyright © 2017 anoopm. All rights reserved.
//

import UIKit
import MapKit
import SwiftSVG

class CountriesDetailViewController: UIViewController {

    var selectedCountryCode: String!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var nativeName: UILabel!
    @IBOutlet private weak var capital: UILabel!
    @IBOutlet private weak var region: UILabel!
    @IBOutlet private weak var languages: UILabel!
    @IBOutlet private weak var germanTranslation: UILabel!
    @IBOutlet private weak var flag: UIView!
    @IBOutlet private weak var area: UILabel!
    @IBOutlet private weak var mapView: MKMapView!
    fileprivate var store = CountryDataStore.shared()
    fileprivate let regionRadius: CLLocationDistance = 1000
    fileprivate let overlay = LoadingOverlay.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCountryDetails()
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.cancelOnGoingRequest()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadCountryDetails() {
        overlay.showOverlay(view: self.view)
        store.fetchDetailsOfCountryWith(code: selectedCountryCode) { [weak self](countryData, error) in
            if let countryDetails = countryData {
                DispatchQueue.main.async {
                    self?.overlay.hideOverlayView()
                    self?.populateDataWith(countryDetails: countryDetails)
                }
            } else {
                // Show error
                self?.displayError()
            }
        }
    }
    func displayError() {

        let alertController = UIAlertController(title: "Error", message: "Failed To Fetch Data, Try later.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default) {[weak self] (action) in
            DispatchQueue.main.async {
                self?.overlay.hideOverlayView()
            }
            self?.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func populateDataWith(countryDetails: CountryViewModel) {

        name.text = countryDetails.name
        nativeName.text = countryDetails.nativeName
        capital.text = countryDetails.capital
        region.text = countryDetails.region
        area.text = countryDetails.area
        languages.text = countryDetails.languages
        germanTranslation.text = countryDetails.germanTranslation
        let flagView = UIView(SVGURL: countryDetails.imageURL) { (svgLayer) in
            //svgLayer.fillColor = UIColor(red:0.52, green:0.16, blue:0.32, alpha:1.00).cgColor
            svgLayer.resizeToFit(self.flag.bounds)
        }
        // Show the location in map
        let initialLocation = CLLocation(latitude: countryDetails.latitute, longitude: countryDetails.longitude)
        centerMapOnLocation(location: initialLocation)
        self.flag.addSubview(flagView)

    }


    func centerMapOnLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(15.00, 15.00)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), span: span)

        let adjustedRegion = mapView.regionThatFits(region)
        mapView.setRegion(adjustedRegion, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        mapView.addAnnotation(annotation)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
