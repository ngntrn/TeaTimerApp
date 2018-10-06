//
//  Tea.swift
//  TeaTimer
//
//  Created by Lucky Tran  on 10/5/18.
//  Copyright © 2018 Ngan Tran. All rights reserved.
//

import UIKit
import os.log

class Tea: NSObject, NSCoding{
    // MARK: Properties
    
    var name: String
    var brewtime: Int
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("teas")
    
    // MARK: Types
    struct PropertyKey{
        static let name = "name"
        static let brewtime = "brewtime"
    }
    
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
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder){
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(brewtime, forKey: PropertyKey.brewtime)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        // name is required
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else{
            os_log("Unable to decode name for Tea object", log: OSLog.default, type: .debug)
            return nil
        }
        let brewtime = aDecoder.decodeInteger(forKey: PropertyKey.brewtime)
        
        self.init(name: name, brewtime: brewtime)
    }
}
