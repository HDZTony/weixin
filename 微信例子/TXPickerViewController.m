//
//  TXPickerViewController.m
//  微信例子
//
//  Created by 何东洲 on 15/12/11.
//  Copyright © 2015年 何东洲. All rights reserved.
//

#import "TXPickerViewController.h"

@interface TXPickerViewController ()
@property (strong, nonatomic) NSArray *contacts;
@end

@implementation TXPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.delegate = self;
    self.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
    self.contacts = [self findContacts];
    [self creatContact];
    [self presentedViewController];
    
    
}
-(NSMutableArray*)findContacts{
    CNContactStore * store = [[CNContactStore alloc]init];
    NSArray * keysToFetch = @[[CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName],CNContactImageDataKey,CNContactPhoneNumbersKey];
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc]initWithKeysToFetch:keysToFetch];
    NSMutableArray *contacts = [NSMutableArray array];
    [store enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact *contact ,BOOL *stop){
        [contacts addObject:contact];
    }];
    return contacts;
}
-(void)creatContact{
    CNMutableContact * contact = [[CNMutableContact alloc]init];
    contact.givenName = @"东洲";
    contact.familyName = @"何";
    CNLabeledValue *homeEmail = [CNLabeledValue labeledValueWithLabel:CNLabelHome value:@"954504788@qq.com"];
    CNLabeledValue *workEmail = [CNLabeledValue labeledValueWithLabel:CNLabelWork value:@"123456@qq.com"];
    contact.emailAddresses = @[homeEmail,workEmail];
    CNPhoneNumber *phoneNumber = [CNPhoneNumber phoneNumberWithStringValue:@"15706843696"];
    contact.phoneNumbers = @[[CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberiPhone value:phoneNumber]];
    CNMutablePostalAddress *homeAdress = [[CNMutablePostalAddress alloc]init];
    homeAdress.street = @"贝克街";
    homeAdress.city = @"伦敦";
    homeAdress.state = @"221B";
    homeAdress.postalCode = @"310013";
    contact.postalAddresses =@[[CNLabeledValue labeledValueWithLabel:CNLabelHome value:homeAdress]];
    NSDateComponents *birthday = [[NSDateComponents alloc]init];
    birthday.day = 7;
    birthday.month = 5;
    birthday.year = 1992;
    contact.birthday = birthday;
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc]init];
    [saveRequest addContact:contact toContainerWithIdentifier:nil];
    CNContactStore *store = [[CNContactStore alloc]init];
    [store executeSaveRequest:saveRequest error:nil];
    
    
}





@end
