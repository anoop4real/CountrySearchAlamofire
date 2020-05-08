//
//  NetworkDataManager.swift
//
//  Created by anoopm.

import Alamofire
import UIKit
enum Result<T, Error> {
    case success(T)
    case error(Error)
}

enum DownloadErrors: Error {
    case failedToDownload
}

class NetworkDataManager: NSObject {
    // Method to fetch data from URL
    class func fetchDataForCountryWith(_ code: String, completion: @escaping (_ success: Bool, _ fetchedData: Data?) -> Void) {
        Alamofire.request(APIRouter.byCode(code))
            .responseJSON { response in

                guard response.result.isSuccess else {
                    completion(false, nil)
                    return
                }

                guard let _ = response.result.value as? [String: Any]
                else {
                    print("Invalid information received from the service")
                    completion(false, nil)
                    return
                }

                completion(true, response.data)
            }
    }
}
