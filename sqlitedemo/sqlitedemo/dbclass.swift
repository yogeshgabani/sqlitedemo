//
//  dbclass.swift
//  sqlitedemo
//
//  Created by MACOS on 8/23/17.
//  Copyright © 2017 MACOS. All rights reserved.
//

import UIKit

class dbclass: NSObject {
    
    func dmloop(query:String) -> Bool {
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path1 = path[0]
        let finalpath = path1.appending("/appdemo.db");
        print(finalpath)
        
        var status:Bool = false;
        var db:OpaquePointer? = nil;
        
        if sqlite3_open(finalpath, &db) == SQLITE_OK {
            var stmt:OpaquePointer? = nil;
            if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
                
                sqlite3_step(stmt)
                status = true;
            }
            sqlite3_finalize(stmt)
            sqlite3_close(db);
            
        }
        
        return status;
        
    }
    
    func getdata(query:String) -> [Any] {
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path1 = path[0]
        let finalpath = path1.appending("/appdemo.db")
        print(finalpath)
        
        var arr:[Any] = [];
        var status:Bool = false
        var db:OpaquePointer? = nil
        
        if sqlite3_open(finalpath, &db) == SQLITE_OK {
            
            var stmt:OpaquePointer? = nil;
            
            if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
                
                while sqlite3_step(stmt) == SQLITE_ROW {
                
                var brr :[String] = [];
                let id = String(cString: sqlite3_column_text(stmt, 0))
                let name = String(cString: sqlite3_column_text(stmt, 1))
                let address = String(cString: sqlite3_column_text(stmt, 2))
                let city = String(cString: sqlite3_column_text(stmt, 3))
                let mobile = String(cString: sqlite3_column_text(stmt, 4))
                brr.append(id)
                brr.append(name)
                brr.append(address)
                brr.append(city)
                brr.append(mobile)
                arr.append(brr)
            }
        }
        sqlite3_finalize(stmt)
        sqlite3_close(db)
      }
       return arr
    }
}

