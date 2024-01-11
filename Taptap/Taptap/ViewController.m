//
//  ViewController.m
//  Taptap
//
//  Created by IB Mac on 08/01/24.
//

#import "ViewController.h"
#import "SecondViewController.h"


@interface ViewController ()

@end

@implementation ViewController

UIGestureRecognizer *tapper;
NSString *username = @"kirtirajdemo";
NSString *password = @"Kirtiraj@1997";
NSString *enteredUsername;
NSString *enteredPassword;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
}

- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

- (IBAction)enterUsername:(UITextField *)sender {
    enteredUsername = sender.text;
    NSLog(@"OK Button Tapped %@",enteredUsername);
}
- (IBAction)enterPassword:(UITextField *)sender {
    enteredPassword = sender.text;
    NSLog(@"OK Button Tapped %@",enteredPassword);
}

- (void)okButtonPreesed {
    NSLog(@"OK Button Tapped");
};

- (IBAction)login:(UIButton *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Unauthorized" message:@"Entered credentials are not correct!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:okAction];
    
    if ([enteredUsername isEqualToString:username] && [enteredPassword isEqualToString:password]) {
        [self.view endEditing:YES];
        NSLog(@"Password is correct@");
        SecondViewController *homescreen = [self.storyboard instantiateViewControllerWithIdentifier:@"home"];
        [self.navigationController pushViewController:homescreen animated:YES];
    } else {
        NSLog(@"Password is wronge@");
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}
@end

