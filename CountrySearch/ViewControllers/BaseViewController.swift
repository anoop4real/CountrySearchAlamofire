//
//  BaseViewController.swift
//  CountrySearch
//
//  Created by anoopm on 17/11/17.
//  Copyright © 2017 anoopm. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    fileprivate let reachability = Reachability.shared
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func isReachable() -> Bool {
        if reachability.isConnectedToNetwork() {
            return true
        }
        return false
    }

    func displayNetworkError() {
        let alertController = UIAlertController(title: "Error", message: "No Internet Connection.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default) { _ in
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
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
