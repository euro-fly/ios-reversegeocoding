//
//  LocationManager.m
//  Joule
//
//  Created by Jacob on 2018/07/02.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "LocationManager.h"

@implementation LocationManager {
}

+ (NSString*) GetCurrentPrefecture {
    CLLocation* latlong = [LocationManager GetCurrentLocation];
    double lat = latlong.coordinate.latitude;
    double lon = latlong.coordinate.longitude;
    NSString *url = [NSString stringWithFormat:@"https://nominatim.openstreetmap.org/reverse?format=json&lat=%f&lon=%f&zoom=18&addressdetails=&accept-language=ja", lat, lon];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&myError];
    if (!res || ![res isKindOfClass:[NSDictionary class]] || [res objectForKey:@"error"] || ![res objectForKey:@"address"]) {
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
        [manager requestWhenInUseAuthorization];
    }
}

+ (void) ReverseGeocoding {
    CLLocation *loc = [LocationManager GetCurrentLocation];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:loc preferredLocale:locale completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if(placemarks && placemarks.count > 0)
         {
             CLPlacemark *placemark= [placemarks objectAtIndex:0];
             NSLog(@"[GEO] Current Prefecture: %@", [placemark administrativeArea]);
         }     }];
}

// ideally you want to cache this result in whatever function is calling it. the other two methods are just for the sake of completion.
+ (CLLocation*) GetCurrentLocation {
    CLLocationManager *manager = [[CLLocationManager alloc] init];
    if ([CLLocationManager locationServicesEnabled]) {
        manager.delegate = nil;
        manager.desiredAccuracy = kCLLocationAccuracyBest;
        manager.distanceFilter = kCLDistanceFilterNone;
        [manager requestWhenInUseAuthorization];
        [manager startUpdatingLocation];
        CLLocation *position = manager.location;
        [manager stopUpdatingLocation];
        NSLog(@"[GEO] %f %f", position.coordinate.latitude, position.coordinate.longitude);
        return position;
    }
    else {
        return nil;
    }
}

+ (double) GetCurrentLatitude {
    CLLocation *loc = [LocationManager GetCurrentLocation];
    if (loc == nil) {return 0;}
    return loc.coordinate.latitude;
}

+ (double) GetCurrentLongitude {
    CLLocation *loc = [LocationManager GetCurrentLocation];
    if (loc == nil) {return 0;}
    return loc.coordinate.longitude;
}

@end
