//
//  Config.swift
//  liftorum
//
//  Created by Voxy on 12/16/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

#if LOCAL
    
let SERVER_URL = "http://localhost:5000"
    
#elseif TESTING

let SERVER_URL = "http://localhost:7357"
    
#elseif NRGOK
    
let SERVER_URL = "http://f7fe8526.ngrok.io"
    
#else
    
let SERVER_URL = "http://www.liftorum.com"
    
#endif

