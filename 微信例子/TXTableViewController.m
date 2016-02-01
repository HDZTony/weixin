//
//  TXTableViewController.m
//  微信例子
//
//  Created by 何东洲 on 15/11/30.
//  Copyright © 2015年 何东洲. All rights reserved.
//

#import "TXTableViewController.h"

@interface TXTableViewController ()<CNContactPickerDelegate>
@property (strong, nonatomic) NSArray *contacts;
@end

@implementation TXTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.contacts = [self findContacts];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
    //[self creatContact];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"pickerView" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemClick)];
    [self.navigationItem setRightBarButtonItem:rightItem animated:YES];
    
   
    
    
    
}
-(void)rightBarButtonItemClick{
    CNContactPickerViewController *pickerController = [[CNContactPickerViewController alloc]init];
    pickerController.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}
/**
 *  点击pickerController联系人属性后调用
 *
 *  @param picker          <#picker description#>
 *  @param contactProperty <#contactProperty description#>
 */
-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{
    //CNContact *conatct = [contactProperty contact];
    //NSString * name =  conatct.givenName;
  
}
/**
 *  从设备通讯录中获取所有联系人
 *
 *  @return 联系人数组
 */
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
/**
 *  创建联系人
 */
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    CNContact *contact = self.contacts[indexPath.row];
    NSString *formatter = [CNContactFormatter stringFromContact:contact style:CNContactFormatterStyleFullName];
    cell.textLabel.text = formatter;
    
    
    return cell;
}



@end
