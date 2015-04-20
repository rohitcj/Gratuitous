//
//  GratuitousSettingsHelper.swift
//  Gratuitous
//
//  Created by Rohit Jhangiani on 4/19/15.
//  Copyright (c) 2015 5TECH. All rights reserved.
//

import Foundation

// ToDo: add enum for tip percentages: Low, Medium, High
enum Rounding: Int
{
    case Down = 0,
    None,
    Up
    
    var description : String {
        switch self {
        case .Down: return "Down";
        case .None: return "None";
        case .Up: return "Up";
        }
    }
}

enum Theme: Int
{
    case Light = 0,
    Dark
    
    var description : String {
        switch self {
        case .Light: return "Light";
        case .Dark: return "Dark";
        }
    }
}