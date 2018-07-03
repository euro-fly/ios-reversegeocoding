//
//  ViewController.m
//  reversegeocoding-test1
//
//  Created by Jacob on 2018/07/03.
//  Copyright © 2018 Jacob. All rights reserved.
//

#import "ViewController.h"
#import "LocationManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *prefectureLabel;
@property (weak, nonatomic) IBOutlet UIButton *permissionButton;
@property (weak, nonatomic) IBOutlet UIButton *prefectureButton;
- (IBAction)requestPermission:(id)sender;
- (IBAction)getPrefecture:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)requestPermission:(id)sender {
    [LocationManager GetPermission];
}

- (IBAction)getPrefecture:(id)sender {
    [LocationManager ReverseGeocoding];
    //_prefectureLabel.text = [LocationManager GetCurrentPrefecture];
}
@end
