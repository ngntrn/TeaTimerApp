//
//  Tea.swift
//  TeaTimer
//
//  Created by Lucky Tran  on 10/5/18.
//  Copyright © 2018 Ngan Tran. All rights reserved.
//

import UIKit

class Tea{
    //MARK: properties
    
    var name: String
    var brewtime: Int
    
    //MARK: initialization
    init?(name: String, brewtime: Int){
        
        guard !name.isEmpty else{
            return nil
        }
        
        guard (brewtime >= 0) && (brewtime <= 1000) else{
            return nil
        }
        
        // initialize stored properties
        self.name = name
        self.brewtime = brewtime
        
    }
}
