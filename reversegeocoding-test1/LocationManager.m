//
//  LocationManager.m
//  Joule
//
//  Created by Jacob on 2018/07/02.
//  Copyright © 2018 Wellness Data Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "LocationManager.h"

@implementation LocationManager {
}

//https://nominatim.openstreetmap.org/reverse?format=json&lat=35.655164046&lon=139.740663704&zoom=18&addressdetails=&accept-language=ja
// NOTE: first check the JSON response if it has the key "error", and if it does, kill it
// ELSE: check if it has the key "address", and find the key "state" within the value of that...

+ (NSString*) GetCurrentPrefecture {
    NSArray<NSNumber *> *latlong = [LocationManager GetCurrentLocation];
    double lat = latlong[0].doubleValue;
    double lon = latlong[1].doubleValue;
    NSString *url = [NSString stringWithFormat:@"https://nominatim.openstreetmap.org/reverse?format=json&lat=%f&lon=%f&zoom=18&addressdetails=&accept-language=ja", lat, lon];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&myError];
    if (!res) { // JSON parser failed
        return @"NONE";
    }
        
    // dictionary (top-level)
    else if (![res isKindOfClass:[NSDictionary class]]) {
        // JSON parser hasn't returned a dictionary
        return @"NONE";
    }
    
    else if ([res objectForKey:@"error"]) {
        // error out...
        NSLog(@"[GEO] Error thrown by server...");
        return @"NONE";
    }
    
    else if (![res objectForKey:@"address"]) {
        NSLog(@"[GEO] Server did not return a valid address...");
        return @"NONE";
    }
    
    else {
        NSDictionary *address = res[@"address"];
        NSLog(@"[GEO] %@", [address objectForKey:@"state"]);
        return [address objectForKey:@"state"];
    }

}

+ (void) GetPermission {
    CLLocationManager *manager = [[CLLocationManager alloc] init];
    if ([CLLocationManager locationServicesEnabled]) {
        [manager requestAlwaysAuthorization];
    }
}


// ideally you want to cache this result in whatever function is calling it. the other two methods are just for the sake of completion.
+ (NSArray<NSNumber *>*) GetCurrentLocation {
    CLLocationManager *manager = [[CLLocationManager alloc] init];
    if ([CLLocationManager locationServicesEnabled]) {
        manager.delegate = nil;
        manager.desiredAccuracy = kCLLocationAccuracyBest;
        manager.distanceFilter = kCLDistanceFilterNone;
        [manager requestAlwaysAuthorization];
        [manager startUpdatingLocation];
        CLLocation *position = manager.location;
        NSArray<NSNumber*> *latlong = [[NSArray alloc] initWithObjects: [NSNumber numberWithDouble:position.coordinate.latitude],[NSNumber numberWithDouble:position.coordinate.longitude], nil];
        [manager stopUpdatingLocation];
        NSLog(@"[GEO] %f %f", latlong[0].doubleValue, latlong[1].doubleValue);
        return latlong;
    }
    else {
        NSArray<NSNumber*> *latlong = [[NSArray alloc] init];
        return latlong;
    }
}

+ (double) GetCurrentLatitude {
    NSArray<NSNumber*> *latlong = [LocationManager GetCurrentLocation];
    if (latlong.count != 2) {
        return -900;
    }
    return latlong[0].doubleValue;
}

+ (double) GetCurrentLongitude {
    NSArray<NSNumber*> *latlong = [LocationManager GetCurrentLocation];
    if (latlong.count != 2) {
        return -900;
    }
    return latlong[1].doubleValue;
}
@end
