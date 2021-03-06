//
//  PSTextFieldHandler.m
//  Pods
//
//  Created by Nadiia Dovbysh on 7/2/17.
//
//

#import "PSTextFieldHandler.h"

@interface PSTextFieldHandler ()
    
@property (nonatomic, weak) id<UITextFieldDelegate> next;
@property (nonatomic, assign) NSUInteger maxLength;

@end

@implementation PSTextFieldHandler
    
+ (instancetype)new:(NSUInteger)maxLength {
    PSTextFieldHandler *me = [[PSTextFieldHandler alloc] init];
    me.maxLength = maxLength;
    return me;
}
    
- (void)assignNext:(id<UITextFieldDelegate>)delegate {
    self.next = delegate;
}
    
#pragma mark - UITextFieldDelegate
    
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.next respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.next textFieldShouldBeginEditing:textField];
    }
    return YES;
}
    
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.next respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.next textFieldDidBeginEditing:textField];
    }
}
    
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([self.next respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.next textFieldShouldEndEditing:textField];
    }
    return YES;
}
    
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.next respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.next textFieldDidEndEditing:textField];
    }
}
    
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    if ([self.next respondsToSelector:@selector(textFieldDidEndEditing:reason:)]) {
        [self.next textFieldDidEndEditing:textField reason:reason];
    }
}
    
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
    if ([components count] > 1) {
        return NO;
    }
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    return newLength <= self.maxLength;
}
    
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if ([self.next respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [self.next textFieldShouldClear:textField];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.next respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.next textFieldShouldReturn:textField];
    }
    return YES;
}
    
@end
