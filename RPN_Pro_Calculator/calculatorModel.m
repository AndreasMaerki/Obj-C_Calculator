//
//  calculatorModel.m
//  RPN_Pro_Calculator
//
//  Created by andreas märki on 11.03.13.
//  Copyright (c) 2013 andreas märki. All rights reserved.
//

#import "calculatorModel.h"

@interface calculatorModel()
@property (nonatomic, strong) NSMutableArray *programStack;
@end



@implementation calculatorModel
@synthesize programStack = _programStack;
//override the getter from synthesize
-(NSMutableArray *) programStack{
    //lazy instanciation == do it at the last moment possible, and only when needed
    if (_programStack == nil) _programStack = [[NSMutableArray alloc] init];
    return _programStack;
}

- (void) pushOperand:(double)operand{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
    
}

- (double) popOperand{
    NSNumber *operandObject = [self.programStack lastObject];
    if(operandObject)[self.programStack removeLastObject];
    return [operandObject doubleValue];//casting because NSMutableArray returnes allways a object
}

- (double)performOperation:(NSString *)operation{
    
    [self.programStack addObject:operation];
    return[calculatorModel runProgram:self.program];
}

//getter for program
- (id)program{
    
    //return a copy because we dont want the internal state to get out of the object
    //the copy will be a normal array[]. not mutable!
    return [self.programStack copy];
}
+ (NSString*)descriptionOfProgram:(id)program{
    return @"not implemented jet";
}

//method calls itself recurcively 
+(double)popOperandOfStack:(NSMutableArray* )stack{
    double result = 0;
    
    id topOfStack = [stack lastObject];//could be number or operation
    if (topOfStack) [stack removeLastObject];
    
    if([topOfStack isKindOfClass:[NSNumber class]]){
        result = [topOfStack doubleValue];
    }else if ([topOfStack isKindOfClass:[NSString class]]){
        
        NSString* operation = topOfStack;
        if ([operation isEqualToString:@"+"]) {
            result =[self popOperandOfStack:stack]+[self popOperandOfStack:stack];
        }else if ([operation isEqualToString:@"*"]){
            result = [self popOperandOfStack:stack]*[self popOperandOfStack:stack];
        }else if ([operation isEqualToString:@"/"]){
            double divisor = [self popOperandOfStack:stack];
            if (divisor){
                result = [self popOperandOfStack:stack]/divisor;
            }else{
                result = MAXFLOAT;
            }
        }else if ([operation isEqualToString:@"-"]){
            result = [self popOperandOfStack:stack]-[self popOperandOfStack:stack];
        }else if ([operation isEqualToString:@"x^y"]){
            double exponent = [self popOperandOfStack:stack];
            double base = [self popOperandOfStack:stack];
            result = pow(base, exponent);
        }else if ([operation isEqualToString:@"sqrt"]) {
            result = sqrt([self popOperandOfStack:stack]);
        }else if ([operation isEqualToString:@"pow"]){
            result = pow([self popOperandOfStack:stack], 2);
        }else if ([operation isEqualToString:@"log"]){
            result = log10([self popOperandOfStack:stack]);
        }else if ([operation isEqualToString:@"sin"]){
            result = sin([self popOperandOfStack:stack]/180*M_PI);
        }else if ([operation isEqualToString:@"cos"]){
            result = cos([self popOperandOfStack:stack]/180*M_PI);
        }else if ([operation isEqualToString:@"tan"]){
            result = tan([self popOperandOfStack:stack]/180*M_PI);
        }else if ([operation isEqualToString:@"1/x"]){
            result = 1/[self popOperandOfStack:stack];
        }else if ([operation isEqualToString:@"π"]){
            result = M_PI;
        }else if ([operation isEqualToString:@"e"]){
            result = M_E;
        }
    }
    
    return result;
}

+ (double)runProgram:(id)program{
    NSMutableArray *stack;//nil by default
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    return [self popOperandOfStack:stack];
}

-(void) clearAll{
    [self.programStack removeAllObjects];
}

//just for fun
- (NSString *) returnNiceWords{
    int randomInt = arc4random()%10 +0;//a random number between 0 and 9
    NSString* mw2 []= {@"Hane", @"Profi...", @"Mostchopof",@"Holzchopf",@"Halbgott",@"Eier",@"Gott",@"grosse Chef",@"Kakadu",@"Hans"};
    NSString *resultString = [NSString stringWithFormat:@"%@", mw2[randomInt]];
    return resultString;
}





@end
//continue lec 1 52 min