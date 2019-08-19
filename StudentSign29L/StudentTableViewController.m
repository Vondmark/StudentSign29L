//
//  StudentTableViewController.m
//  StudentSign29L
//
//  Created by Mark on 2/21/19.
//  Copyright © 2019 Mark. All rights reserved.
//

#import "StudentTableViewController.h"


@interface StudentTableViewController ()

@end

static NSString* kSettingsName =                @"name";
static NSString* kSettingsSecondName =          @"second name";
static NSString* kSettingsAge =                 @"age";
static NSString* kSettingsLogin =               @"login";
static NSString* kSettingsPassword =            @"password";
static NSString* kSettingsPhoneNumber =         @"phone number";
static NSString* kSettingsEmail =               @"email";
static NSString* kSettingsLevel =               @"level";
static NSString* kSettingsCity =                @"city";
static NSString* kSettingsMapType =             @"map type";



@implementation StudentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.nameTextField becomeFirstResponder];
    [self loadSettings];
    
    
    
    
}

#pragma mark - Save and Load

-(void) saveSettings{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:self.nameTextField.text forKey:kSettingsName];
    [userDefaults setObject:self.secondNameTextField.text forKey:kSettingsSecondName];
    [userDefaults setObject:self.ageTextField.text forKey:kSettingsAge];
    [userDefaults setObject:self.loginTextField.text forKey:kSettingsLogin];
    [userDefaults setObject:self.passwordTextField.text forKey:kSettingsPassword];
    [userDefaults setObject:self.phoneNumberTextField.text forKey:kSettingsPhoneNumber];
    [userDefaults setObject:self.emailTextField.text forKey:kSettingsEmail];
    
    [userDefaults setInteger:self.levelSegmentedControl.selectedSegmentIndex forKey:kSettingsLevel];
    [userDefaults setInteger:self.citySegmentedControl.selectedSegmentIndex forKey:kSettingsCity];
    [userDefaults setInteger:self.mapTypeSegmentedControl.selectedSegmentIndex forKey:kSettingsMapType];
    
}



-(void) loadSettings{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.nameTextField.text = [userDefaults objectForKey:kSettingsName];
    self.secondNameTextField.text = [userDefaults objectForKey:kSettingsSecondName];
    self.ageTextField.text = [userDefaults objectForKey:kSettingsAge];
    self.loginTextField.text = [userDefaults objectForKey:kSettingsLogin];
    self.passwordTextField.text = [userDefaults objectForKey:kSettingsPassword];
    self.phoneNumberTextField.text = [userDefaults objectForKey:kSettingsPhoneNumber];
    self.emailTextField.text = [userDefaults objectForKey:kSettingsEmail];
    
    self.levelSegmentedControl.selectedSegmentIndex = [userDefaults integerForKey:kSettingsLevel];
    self.citySegmentedControl.selectedSegmentIndex = [userDefaults integerForKey:kSettingsCity];
    self.mapTypeSegmentedControl.selectedSegmentIndex = [userDefaults integerForKey:kSettingsMapType];
    
}



- (IBAction)actionTextChange:(UITextField *)sender {
    [self saveSettings];
}

- (IBAction)actionValueChanged:(id)sender {
    [self saveSettings];
}

#pragma mark - UiTextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //Personal Inforamtions
    if ([textField isEqual:self.nameTextField]) {
        [self.secondNameTextField becomeFirstResponder];
        
    } else if([textField isEqual:self.secondNameTextField]){
        [self.ageTextField becomeFirstResponder];
        
    }else if([textField isEqual:self.secondNameTextField]){
        [self.ageTextField becomeFirstResponder];
        
    }else if([textField isEqual:self.ageTextField]){
        [self.loginTextField becomeFirstResponder];
        
    }//Personal Inforamtions
    else if([textField isEqual:self.loginTextField]){
        [self.passwordTextField becomeFirstResponder];
        
    }else if([textField isEqual:self.passwordTextField]){
        [self.phoneNumberTextField becomeFirstResponder];
        
    }
    else if([textField isEqual:self.phoneNumberTextField]){
        [self.emailTextField becomeFirstResponder];
        
    }
    else if([textField isEqual:self.emailTextField]){
        [self.emailTextField resignFirstResponder];
        
    }
    
    return YES;
}

#define ALPHA                   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define NUMERIC                 @"1234567890"
#define ALPHA_NUMERIC           ALPHA NUMERIC

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([textField isEqual:self.phoneNumberTextField]) {
        
        NSCharacterSet* validationSet = [[NSCharacterSet decimalDigitCharacterSet]invertedSet];
        NSArray* components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if ([components count] > 1) {
            return NO;
        }
        
        NSString* newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSLog(@"new string - %@", newString);
        
        NSArray *validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
        
        newString  = [validComponents componentsJoinedByString:@""];
        
        NSLog(@"new string fixed - %@", newString);
        
        static const int localNumberMaxLenght = 7;
        static const int areaCodeMaxLenght = 3;
        static const int countryCodeMaxLenght = 3;
        
        if ([newString length] > localNumberMaxLenght + areaCodeMaxLenght + countryCodeMaxLenght) {
            return NO;
        }
        
        
        NSMutableString* resultString = [NSMutableString string];
        
        
        NSInteger localNumberLenght = MIN([newString length], localNumberMaxLenght);
        
        if (localNumberLenght > 0) {
            NSString* number = [newString substringFromIndex:(int)[newString length] - localNumberLenght];
            
            [resultString appendString:number];
            
            if ([resultString length] > 3) {
                [resultString insertString:@"-" atIndex:3];
            }
        }
        
        if ([newString length] > localNumberMaxLenght) {
            NSInteger areaCodeLenght = MIN([newString length] - localNumberMaxLenght, areaCodeMaxLenght);
            
            NSRange areaRange = NSMakeRange((int)[newString length] - localNumberLenght - areaCodeLenght, areaCodeLenght);
            
            NSString* area = [newString substringWithRange:areaRange];
            
            area = [NSString stringWithFormat:@"(%@)",area];
            
            [resultString  insertString:area atIndex:0];
        }
        
        if ([newString length] > localNumberMaxLenght + areaCodeMaxLenght) {
            NSInteger countryCodeLenght = MIN([newString length] - localNumberMaxLenght - areaCodeMaxLenght, countryCodeMaxLenght);
            
            NSRange countryCodeRange = NSMakeRange(0, countryCodeLenght);
            
            NSString* countryCode = [newString substringWithRange:countryCodeRange];
            
            countryCode = [NSString stringWithFormat:@"+%@ ",countryCode];
            
            [resultString  insertString:countryCode atIndex:0];
        }
        
        textField.text = resultString;
        return NO;
    }
    if ([textField isEqual:self.emailTextField]) {
        NSCharacterSet *unacceptedInput = nil;
        if ([[textField.text componentsSeparatedByString:@"@"] count] > 1) {
            unacceptedInput = [[NSCharacterSet characterSetWithCharactersInString:[ALPHA_NUMERIC stringByAppendingString:@".-"]] invertedSet];
        } else {
            unacceptedInput = [[NSCharacterSet characterSetWithCharactersInString:[ALPHA_NUMERIC stringByAppendingString:@".!#$%&'*+-/=?^_`{|}~@"]] invertedSet];
        }
        return ([[string componentsSeparatedByCharactersInSet:unacceptedInput] count] <= 1);
    }
    
    return YES;
    
    
}


@end
