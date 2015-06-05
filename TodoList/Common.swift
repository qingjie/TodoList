//
//  Common.swift
//  TodoList
//
//  Created by qingjiezhao on 6/4/15.
//  Copyright (c) 2015 qingjiezhao. All rights reserved.
//

import UIKit

func dateFromString(dateStr : String) ->NSDate?{
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.dateFromString(dateStr)
    return date
}