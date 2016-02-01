//
//  HDComposeViewController.m
//  微信例子
//
//  Created by 何东洲 on 16/1/20.
//  Copyright © 2016年 何东洲. All rights reserved.
//

#import "HDComposeViewController.h"
#import "HDTextView.h"
#import "HDComposeInputView.h"
#import "HDComposePhotosView.h"
#import "HDEmotionKeyboard.h"
@interface HDComposeViewController ()<UITextViewDelegate,HDComposeInputViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, weak) HDTextView *textView;
@property (nonatomic, weak) HDComposeInputView *composeInputView;
@property (nonatomic, weak) HDComposePhotosView  *photosView;
@property (nonatomic, strong) HDEmotionKeyboard * keyboard;
@end

@implementation HDComposeViewController
- (HDEmotionKeyboard *)keyboard
{
   
    if (!_keyboard){
        self.keyboard = [[HDEmotionKeyboard alloc]init];
        self.keyboard.frame = CGRectMake(0, 0, 320, 216);
        
    }
    return _keyboard;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置导航条内容
    [self setupNavBar];
    // 添加输入控件
    [self setupTextView];
    
    // 添加工具条
    [self setUpInputView];
    
//    // 添加显示图片的相册控件
    [self setUpPhotosView];
    // 监听表情选中的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(emotionDidSelected:) name:HDEmotionDidSelectedNotification object:nil];
    // 监听删除按钮点击的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(emotionDidDeleted:) name:HDEmotionDidDeletedNotification object:nil];

}
// 添加输入控件
- (void)setupTextView
{
    // 1.创建输入控件
    HDTextView *textView = [[HDTextView alloc] init];
    textView.alwaysBounceVertical = YES; // 垂直方向上拥有有弹簧效果
    textView.frame = self.view.bounds;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 2.设置提醒文字（占位文字）
    textView.placehoder = @"分享新鲜事...";
    
    // 3.设置字体
    textView.font = [UIFont systemFontOfSize:15];
    
    // 4.监听键盘
    // 键盘的frame(位置)即将改变, 就会发出UIKeyboardWillChangeFrameNotification
    // 键盘即将弹出, 就会发出UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)setUpInputView{
    HDComposeInputView *inputView = [[HDComposeInputView alloc]init];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = 44;
    CGFloat x = 0;
    CGFloat y = self.view.frame.size.height - height*2;
    inputView.frame = CGRectMake(x, y, width, height);
    self.composeInputView = inputView;
    [self.view addSubview:inputView];
    inputView.delegate = self;
}
-(void)setUpPhotosView{
    HDComposePhotosView * photosView = [[HDComposePhotosView alloc]init];
    CGFloat x = 0;
    CGFloat y = 70;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    [self.textView addSubview:photosView];
    photosView.frame = CGRectMake(x, y, width, height);
    self.photosView = photosView;
}
#pragma delegate
-(void)composeTool:(HDComposeInputView *)toolbar didClickedButton:(HDComposeInputViewButtonType)buttonType{
    switch (buttonType) {
        case HDComposeInputViewButtonTypeCamera:
            [self openCamera];
            break;
        case HDComposeInputViewButtonTypeEmotion:
            [self openEmotion];
            break;
        case HDComposeInputViewButtonTypeTrend:
            NSLog(@"trend");
            break;
        case HDComposeInputViewButtonTypeMention:
            NSLog(@"trend");
            break;
        case HDComposeInputViewButtonTypePicture:
            [self openAlbum];
            break;
        
            
        default:
            break;
    }
}
#pragma 工具条按钮
/**
 *  打开照相机
 */
- (void)openCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开相册
 */
- (void)openAlbum
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开表情
 */
- (void)openEmotion
{
    // 正在切换键盘
    self.changingKeyboard = YES;
    if (self.textView.inputView == nil) {
        //
        UIView *keyboard = self.keyboard;
        keyboard.frame = CGRectMake(0, 0, 320, 250);
        self.textView.inputView = keyboard;
        self.composeInputView.showEmotionButton = NO;
        
    }else{
        self.textView.inputView = nil;
        self.composeInputView.showEmotionButton = YES;
    }
    [self.textView resignFirstResponder];
    // 更换完毕完毕
    self.changingKeyboard = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
    });
    
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.photosView addImage:info[UIImagePickerControllerOriginalImage]];
}

#pragma mark 键盘通知
/**
 *  键盘表情被选中
 *
 *  @param note <#note description#>
 */
-(void)emotionDidSelected:(NSNotification *)note{
    
    HDEmotion *emotion = note.userInfo[HDSelectedEmotion];
    if (emotion.emoji) {//emoji
        [self.textView insertText:emotion.emoji];
        //NSAttributedString *subString = [[NSAttributedString alloc]initWithString:emotion.emoji];
        //[attributedText appendAttributedString:subString];
    }else{//图片
        //先拥有textview的富文本
        NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:self.textView.attributedText];
        // 记录表情的插入位置
        NSUInteger insertLocation = self.textView.selectedRange.location;
        //拼接😃
        NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
        attachment.image = [UIImage imageNamed:emotion.png];
        CGFloat width = self.textView.font.lineHeight;
        CGFloat height = width;
        attachment.bounds = CGRectMake(0, -3, width, height);
        NSAttributedString *subString = [NSAttributedString attributedStringWithAttachment:attachment];
        //[attributedText appendAttributedString:subString];
        
        // 插入表情图片到光标位置
        [attributedText insertAttributedString:subString atIndex:self.textView.selectedRange.location];
    
//    字体大小
        [attributedText addAttribute:NSFontAttributeName value:self.textView.font range:NSMakeRange(0, attributedText.length)];
    //覆盖原来的富文本
        self.textView.attributedText = attributedText;
     // 让光标回到表情后面的位置
        self.textView.selectedRange = NSMakeRange(insertLocation+1, 0);
    //检测文字长度
        [self textViewDidChange:self.textView];
        }
}
/**
 *  键盘删除键被选中
 *
 *  @param note
 */
-(void)emotionDidDeleted:(NSNotification *)note{
    NSLog(@"emotionDidDeleted");
    [self.textView deleteBackward];
}
// 设置导航条内容
- (void)setupNavBar
{
    self.title = @"发微博";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    
}
/**
 *  取消
 */
- (void)cancel
{
    self.textView.text = @"gg";
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发送
 */
- (void)send
{
    
    
    // 2.关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UITextViewDelegate
/**
 *  当用户开始拖拽scrollView时调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
/**
 *  当textView的文字改变就会调用
 */
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}
/**
 *  view显示完毕的时候再弹出键盘，避免显示控制器view的时候会卡住
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 成为第一响应者（叫出键盘）
    [self.textView becomeFirstResponder];
}
#pragma mark - 键盘处理
/**
 *  键盘即将隐藏
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    if (self.changingKeyboard == YES) {
        
        return;
    }
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        self.composeInputView.transform = CGAffineTransformIdentity;
    }];
    
}

/**
 *  键盘即将弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘高度
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.composeInputView.transform = CGAffineTransformMakeTranslation(0, - keyboardH+44);
    }];
}
@end
