//
//  Constants.swift
//  api-client
//
//  Created by user on 27/09/2017.
//  Copyright © 2017 David Kennedy. All rights reserved.
//

import Foundation

// Callbacks
// Typealias for callbacks used in Data Service

typealias callback = (_ success: Bool) -> ()

// Base URL
let BASE_API_URL = "https://david-k96.uk/api/v1"

// GET all food trucks

let GET_ALL_FT_URL = "\(BASE_API_URL)/foodtruck"

// GET all reviews for specific foodtruck
let GET_ALL_FT_REVIEWS = "\(BASE_API_URL)/foodtruck/reviews"

// POST add a new food truck
let POST_ADD_NEW_TRUCK = "\(BASE_API_URL)/foodtruck/add"

// POST add review fora  specific food truck
let POST_ADD_NEW_REVIEW = "\(BASE_API_URL)/foodtruck/reviews/add"

//Boolean auth UserDefaults keys
let DEFAULTS_REGISTERED = "isRegistered"
let DEFAULTS_AUTHENTICATED = "isAuthenticated"

//Auth Email
let DEFAULTS_EMAIL = "email"

//Auth Token
let DEFAULTS_TOKEN = "authToken"

// REGISTER url
let POST_REGISTER_ACCT = "\(BASE_API_URL)/account/register"
let POST_LOGIN_ACCT = "\(BASE_API_URL)/account/login"

