//
//  RMMainViewController.m
//  HamburguerButtonTransition
//
//  Created by Ruben on 08/07/14.
//  Copyright (c) 2014 Caldofran. All rights reserved.
//

#import "RMMainViewController.h"
#import "RMHamburguerTransitionButton.h"

@interface RMMainViewController ()
@property (weak, nonatomic) IBOutlet RMHamburguerTransitionButton *hamburguerButton;
- (IBAction)changeButton:(UISwitch *)sender;

@end

@implementation RMMainViewController

- (instancetype)init
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        //
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeButton:(UISwitch *)sender {
    [self.hamburguerButton showMenu:sender.on];
}
@end
