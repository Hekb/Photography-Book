//
//  event.swift
//  Photography Book
//
//  Created by Hekmat on 5/2/20.
//  Copyright © 2020 Hekmat Barbar. All rights reserved.
//

import Foundation

struct event{
    var title: String?
    var lat: Double?
    var long: Double?
    var date: String?
    var time: String?
    var attendingList: String?
    var details: String?
    var hostedBy: String?
    
    init(title: String, lat: Double, long: Double, date: String, time: String,
         attendingList:String, details: String, hostedBy: String){
        self.title = title
        self.lat = lat
        self.long = long
        self.date = date
        self.time = time
        self.attendingList = attendingList
        self.details = details
        self.hostedBy = hostedBy
    }
    
    
}
