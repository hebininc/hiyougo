//
//  ViewController.m
//  test
//
//  Created by eshine on 15/8/20.
//  Copyright (c) 2015年 eshine. All rights reserved.
//

#import "ViewController.h"
#import "LocationManager.h"
@interface ViewController ()<LocationManagerDelegate>
@property (nonatomic,strong)LocationManager *locationManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _locationManager = [LocationManager creatLocationManager];
    _locationManager.delegate = self;
}


- (IBAction)locate:(id)sender {
    [_locationManager startLocate];
}
-(void)locateResult:(NSString *)result withStatus:(LocateStatusEnum)status{
    if (status == LocateEnumSuccess) {
          NSLog(@"result %@",result);
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
