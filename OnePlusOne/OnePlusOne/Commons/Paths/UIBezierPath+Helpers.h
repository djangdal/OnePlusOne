
#import <UIKit/UIKit.h>

@interface UIBezierPath (Helpers)

- (UIBezierPath *)translate:(CGPoint)translation;
- (UIBezierPath *)scaleToFitSize:(CGSize)size;
- (UIBezierPath *)scale:(CGFloat)scale;
- (UIBezierPath *)scaleToFitSize:(CGSize)size scale:(CGFloat *)scale;
- (UIBezierPath *)centerInRect:(CGRect)rect;
- (UIBezierPath *)centerHorizontallyInRect:(CGRect)rect;
- (UIBezierPath *)centerVerticallyInRect:(CGRect)rect;
- (UIImage *)imageWithfillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor strokeWidth:(CGFloat)lineWidth imageSize:(CGSize)imageSize;
- (UIImage *)imageWithfillColor:(UIColor *)fillColor;

@end
