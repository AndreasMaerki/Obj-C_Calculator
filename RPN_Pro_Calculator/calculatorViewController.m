//
//  calculatorViewController.m
//  RPN_Pro_Calculator
//
//  Created by andreas märki on 10.03.13.
//  Copyright (c) 2013 andreas märki. All rights reserved.
//

#import "calculatorViewController.h"
#import "calculatorModel.h"

@interface calculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfTypingANumber;
@property (nonatomic, strong) calculatorModel *calcModel;
@end

@implementation calculatorViewController
@synthesize display = _display;
@synthesize userIsInTheMiddleOfTypingANumber = _userIsInTheMiddleOfTypingANumber;
@synthesize calcModel = _calcModel;


- (calculatorModel *) calcModel{
    if (!_calcModel) _calcModel = [[calculatorModel alloc]init];
    return _calcModel;
}


// IBaction = void, only for xCode
// id can point to any kind of object. so i could pass this method any kind
// of object. if possible it should be as specific as possible.(button here)
// the passed object will be stored in the local var sender!!
- (IBAction)digitPressed:(UIButton *)sender {
    // pass the receeved objet to digit
    NSString *digit = sender.currentTitle;//current title is the lable
    if (self.userIsInTheMiddleOfTypingANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    }else{
        self.display.text = digit;
        self.userIsInTheMiddleOfTypingANumber = YES;
    }
}
- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfTypingANumber) [self enterPressed];//convienience
    double result = [self.calcModel performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
}

- (IBAction)enterPressed {
    [self.calcModel pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfTypingANumber = NO;

}
- (IBAction)allClear {
    [self.calcModel clearAll];
    self.display.text = @"0";
}

- (IBAction)unaryOperationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfTypingANumber) [self enterPressed];//convienience
    double result = [self.calcModel unaryOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
}
- (IBAction)iFeelLuckyButtonPressed {
    [self allClear];
    NSString *resultString =[self.calcModel returnNiceWords];
    self.display.text = resultString;
}


@end
