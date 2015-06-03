
#import "UIBezierPath+Helpers.h"

@implementation UIBezierPath (Helpers)
- (UIImage *)imageWithfillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor strokeWidth:(CGFloat)lineWidth imageSize:(CGSize)imageSize {

    if (CGSizeEqualToSize(CGSizeZero, self.bounds.size)) {
        return nil;
    }
    
    UIBezierPath *path = self;
    if (strokeColor) {
        path = [path centerInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    }
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
    
    if (fillColor) {
        [fillColor setFill];
        [path fill];
    }
    
    if (strokeColor) {
        [strokeColor setStroke];
        path.lineWidth = lineWidth;
        
        [path stroke];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIBezierPath *)translate:(CGPoint)translation {
    CGAffineTransform transform = CGAffineTransformMakeTranslation(translation.x, translation.y);
    CGPathRef cgpath = CGPathCreateCopyByTransformingPath(self.CGPath, &transform);
    UIBezierPath *bpath = [UIBezierPath bezierPathWithCGPath:cgpath];
    CGPathRelease(cgpath);
    return bpath;
}

- (UIBezierPath *)scaleToFitSize:(CGSize)size scale:(CGFloat *)scale {
    if (size.width == 0 || size.height == 0) {
        return nil;
    }
    CGFloat xScale =  size.width / self.bounds.size.width;
    CGFloat yScale =  size.height / self.bounds.size.height;
    CGFloat s = MIN(xScale, yScale);
    CGAffineTransform transform = CGAffineTransformMakeScale(s, s);
    CGPathRef cgpath = CGPathCreateCopyByTransformingPath(self.CGPath, &transform);
    UIBezierPath *bpath = [UIBezierPath bezierPathWithCGPath:cgpath];
    CGPathRelease(cgpath);
    *scale = s;
    return bpath;
}

- (UIBezierPath *)scaleToFitSize:(CGSize)size; {
    CGFloat scale;
    return [self scaleToFitSize:size scale:&scale];
}

- (UIBezierPath *)scale:(CGFloat)scale {
    CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
    CGPathRef cgpath = CGPathCreateCopyByTransformingPath(self.CGPath, &transform);
    UIBezierPath *bpath = [UIBezierPath bezierPathWithCGPath:cgpath];
    CGPathRelease(cgpath);
    return bpath;
}

- (UIBezierPath *)centerInRect:(CGRect)rect {
    CGPoint translation;
    translation.x = roundf(rect.origin.x + (rect.size.width - CGRectGetWidth(self.bounds)) / 2.0);
    translation.y = roundf(rect.origin.y + (rect.size.height - CGRectGetHeight(self.bounds)) / 2.0);
    return [self translate:translation];
}

- (UIBezierPath *)centerHorizontallyInRect:(CGRect)rect {
    CGPoint translation;
    translation.x = roundf(rect.origin.x + (rect.size.width - CGRectGetWidth(self.bounds)) / 2);
    translation.y = 0;
    return [self translate:translation];
}

- (UIBezierPath *)centerVerticallyInRect:(CGRect)rect {
    CGPoint translation;
    translation.x = 0;
    translation.y = roundf(rect.origin.y + (rect.size.height - CGRectGetHeight(self.bounds)) / 2);
    return [self translate:translation];
}

- (UIImage *)imageWithfillColor:(UIColor *)fillColor {
    return [self imageWithfillColor:fillColor strokeColor:nil strokeWidth:0 imageSize:self.bounds.size];
}

@end
