#import <MapKit/MapKit.h>

@interface LocationManager: NSObject <CLLocationManagerDelegate> {
}
+ (NSArray<NSNumber *>*) GetCurrentLocation;
+ (double) GetCurrentLatitude;
+ (double) GetCurrentLongitude;
+ (NSString *) GetCurrentPrefecture;
+ (void) GetPermission;
@end
