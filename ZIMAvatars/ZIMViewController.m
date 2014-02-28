//
//  ZIMViewController.m
//  ZIMAvatars
//
//  Created by kovtash on 28.02.14.
//  Copyright (c) 2014 kovtash.com. All rights reserved.
//

#import "ZIMViewController.h"
#import "ZIMAvatarManager.h"

@interface ZIMViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (strong, nonatomic) IBOutlet UITextField *identifierField;

@end

@implementation ZIMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.avatarImageView.image = [[ZIMAvatarManager sharedManager] avatarForIdentifier:self.identifierField.text];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)randomAvatarTapped:(id)sender {
    self.avatarImageView.image = [[ZIMAvatarManager sharedManager] randomAvatar];
}

- (IBAction)avatarForIdentifierTapped:(id)sender {
    self.avatarImageView.image = [[ZIMAvatarManager sharedManager] avatarForIdentifier:self.identifierField.text];
}

@end
