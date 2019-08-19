//
//  StudentTableViewController.h
//  StudentSign29L
//
//  Created by Mark on 2/21/19.
//  Copyright © 2019 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StudentTableViewController : UITableViewController <UITextFieldDelegate>

#pragma mark - Outlets

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *levelSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *citySegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mapTypeSegmentedControl;



- (IBAction)actionTextChange:(UITextField *)sender;
- (IBAction)actionValueChanged:(id)sender;


@end

NS_ASSUME_NONNULL_END
