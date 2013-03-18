//
//  calculatorModel.h
//  RPN_Pro_Calculator
//
//  Created by andreas märki on 11.03.13.
//  Copyright (c) 2013 andreas märki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface calculatorModel : NSObject

- (void) pushOperand:(double)operand;
- (double)performOperation:(NSString *)opertion;
- (double) unaryOperation:(NSString *)operation;
- (void) clearAll;
- (NSString *) returnNiceWords;

@property(readonly) id program;
+ (double)runProgram:(id)program;
+ (NSString*) descriptionOfProgram:(id)program;
@end
