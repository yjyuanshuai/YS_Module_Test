//
//  ChatViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/12/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatBottemView.h"
#import "EmotionView.h"
#import "ChatViewTableViewCell.h"

static NSString * const ChatViewCellID = @"ChatViewCellID";

@interface ChatViewController ()<UITableViewDelegate, UITableViewDataSource, ChatBottemViewDelegate>

@property (nonatomic, strong) UITableView * messageTableView;
@property (nonatomic, strong) ChatBottemView * chatBottemView;
@property (nonatomic, strong) EmotionView * emotionView;

@end

@implementation ChatViewController
{
    NSMutableArray * _messageDataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createTableView];
    [self createEmoView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initUIAndData
{
    self.title = @"聊天界面";
    _messageDataArr = [@[] mutableCopy];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)createEmoView
{
    _chatBottemView = [[ChatBottemView alloc] initWithFrame:CGRectMake(0, kScreenHeightNo64 - 85, kScreenWidth, 85)];
    _chatBottemView.delegate = self;
    [self.view addSubview:_chatBottemView];
    
    _emotionView = [EmotionView shareEmotionView];
    _emotionView.hidden = YES;
    _emotionView.frame = CGRectMake(0, kScreenHeightNo64, kScreenWidth, [_emotionView getEmotionViewHeight]);
    [self.view addSubview:_emotionView];
    
    _chatBottemView.backgroundColor = YSColorDefault;
    _emotionView.backgroundColor = [UIColor greenColor];
}

- (void)createTableView
{
    _messageTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _messageTableView.delegate = self;
    _messageTableView.dataSource = self;
    _messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_messageTableView];
    
    [_messageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 85, 0));
    }];
    
    [_messageTableView registerClass:[ChatViewTableViewCell class] forCellReuseIdentifier:ChatViewCellID];
    
    [_messageTableView setTransform:CGAffineTransformMakeRotation(-M_PI)];
    
    _messageTableView.backgroundColor = [UIColor yellowColor];
}

#pragma mark -
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame = value.CGRectValue;
    
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // 添加移动动画，使视图跟随键盘移动
    [UIView animateWithDuration:duration.doubleValue animations:^{
        
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        
        _chatBottemView.frame = CGRectMake(0, kScreenHeightNo64 - frame.size.height, kScreenWidth, [_chatBottemView getBottemViewHeight]);
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    
}

#pragma mark - ChatBottemViewDelegate
- (void)showFunctionViewWithTag:(FunctionType)functionType
{
    if (functionType == FunctionType_Emotion) {
        // 显示表情选择
        [UIView animateWithDuration:0.5 animations:^{
            _emotionView.hidden = NO;
            
            CGFloat chatBottemViewHeight = [_chatBottemView getBottemViewHeight];
            CGFloat emoViewHeight = [_emotionView getEmotionViewHeight];
            _chatBottemView.frame = CGRectMake(0, kScreenHeightNo64 - chatBottemViewHeight - emoViewHeight, kScreenWidth, chatBottemViewHeight);
            
            _emotionView.frame = CGRectMake(0, kScreenHeightNo64 - emoViewHeight, kScreenWidth, emoViewHeight);
        }];
    }
}

#pragma mark - 

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_messageDataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatViewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ChatViewCellID];
    
    return cell;
}

@end
