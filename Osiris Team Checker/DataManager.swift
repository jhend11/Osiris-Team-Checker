//
//  DataManager.swift
//  Osiris Team Checker
//
//  Created by JOSH HENDERSHOT on 8/18/15.
//  Copyright © 2015 Joshua Hendershot. All rights reserved.
//

import Foundation
var gamertag = ""
var destinyMembershipId = ""
var displayName = ""
var url = ""
var systemID = 1
var charID = ""

class DataManager {
    
    
    class func getMemberID(){
        url = "https://www.bungie.net/platform/destiny/SearchDestinyPlayer/\(systemID)/\(gamertag)"
        
        getPlayerDataWithSuccess { (playerData) -> Void in
            let json = JSON(data: playerData)
            if let _ = json["Response"][0].dictionary {
                displayName = json["Response"][0]["displayName"].string!
                destinyMembershipId = json["Response"][0]["membershipId"].string!
                print(displayName)
                print(destinyMembershipId)
                self.charCheck()
            }
        }
    }
    class func charCheck (){
        url = "https://www.bungie.net/platform/destiny/\(systemID)/account/\(destinyMembershipId)"
        
        getPlayerDataWithSuccess { (playerData) -> Void in
            let json = JSON(data: playerData)
            if let _ = json["Response"]["data"]["characters"][0]["characterBase"].dictionary {
                charID = json["Response"]["data"]["characters"][0]["characterBase"]["characterId"].string!
                print(charID)
                getKD()
            }
        }
    }
    class func getKD (){
        url = "http://www.bungie.net/Platform/Destiny/Stats/activityhistory/1/\(destinyMembershipId)/\(charID)/?mode=TrialsOfOsiris&count=100"
        var gamesPlayed = 0.0
        var killsDeath = 0.0
        for i in 0...99 {
            getPlayerDataWithSuccess { (playerData) -> Void in
                let json = JSON(data: playerData)
                if let _ = json["Response"]["data"]["activities"][i]["values"]["killsDeathsRatio"]["basic"].dictionary {
                    let charKD = json["Response"]["data"]["activities"][i]["values"]["killsDeathsRatio"]["basic"]["displayValue"].string!
                    
                    killsDeath = killsDeath + Double(charKD)!
                    gamesPlayed = gamesPlayed++

                }

            }
            print(killsDeath)

        }
        /*
        getPlayerDataWithSuccess { (playerData) -> Void in
            let json = JSON(data: playerData)
            if let _ = json["Response"]["data"]["activities"][46]["values"]["killsDeathsRatio"]["basic"].dictionary {
               let charKD = json["Response"]["data"]["activities"][46]["values"]["killsDeathsRatio"]["basic"]["displayValue"].string!
                print(charKD)
                
            }
        }*/
    }
    class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        let session = NSURLSession.sharedSession()
        
        // Use NSURLSession to get data from an NSURL
        let loadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if let responseError = error {
                completion(data: nil, error: responseError)
            } else {
                completion(data: data, error: nil)
            }
        })
        
        loadDataTask.resume()
    }
    
    class func getPlayerDataWithSuccess(success: ((playerData: NSData!) -> Void)) {
        //1
        loadDataFromURL(NSURL(string: url)!, completion:{(data, error) -> Void in
            //2
            if let urlData = data {
                //3
                success(playerData: urlData)
            }
        })
    }
}