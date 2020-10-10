//
//  Connectivity.swift
//  MobileAxxess_CodeChallenge
//
//  Created by Kunal Das on 10/10/20.
//  Copyright © 2020 Kunal Das. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
