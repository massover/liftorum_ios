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
    
#elseif NGROK
    
let SERVER_URL = "http://02dec740.ngrok.io"
    
#else
    
let SERVER_URL = "http://www.liftorum.com"
    
#endif

