#import <MapKit/MapKit.h>

@interface LocationManager: NSObject <CLLocationManagerDelegate> {
}
+ (CLLocation *) GetCurrentLocation;
+ (double) GetCurrentLatitude;
+ (double) GetCurrentLongitude;
+ (NSString *) GetCurrentPrefecture;
+ (void) GetPermission;
+ (void) ReverseGeocoding;
@end
