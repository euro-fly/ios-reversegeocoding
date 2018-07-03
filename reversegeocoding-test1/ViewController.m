//
//  ViewController.m
//  reversegeocoding-test1
//
//  Created by Jacob on 2018/07/03.
//  Copyright © 2018 Jacob. All rights reserved.
//

#import "ViewController.h"
#import "LocationManager.h"

//http://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer/reverseGeocode?f=pjson&featureTypes=&location=-117.205453,34.037988

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [LocationManager GetPermission];
    [LocationManager GetCurrentPrefecture];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end