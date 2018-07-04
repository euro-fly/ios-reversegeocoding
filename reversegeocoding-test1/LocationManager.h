#import <MapKit/MapKit.h>

@interface LocationManager: NSObject <CLLocationManagerDelegate> {
}
+ (CLLocation *) GetCurrentLocation;
+ (double) GetCurrentLatitude;
+ (double) GetCurrentLongitude;
+ (NSString *) GetCurrentPrefecture;
+ (void ) GetCurrentPrefectureWithLocation: (CLLocation *)location;
+ (void) GetPrefectureFromPostalCode: (NSString *)postalCode;
+ (void) GetPermission;
+ (void) ReverseGeocoding;
@end
