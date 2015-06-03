//
//  SKRectFunctions.h
//

#import <Foundation/Foundation.h>

CGRect SKRectSetOrigin(CGRect rect, CGPoint origin);
CGRect SKRectSetSize(CGRect rect, CGSize size);
CGRect SKRectSetX(CGRect rect, CGFloat x);
CGRect SKRectSetY(CGRect rect, CGFloat y);
CGRect SKRectSetWidth(CGRect rect, CGFloat width);
CGRect SKRectSetHeight(CGRect rect, CGFloat height);
CGRect SKRectAlignRightInRect(CGRect rect, CGRect rectToAlignIn, int spacing);
CGRect SKRectCenterInRect(CGRect rect, CGRect rectToCenterIn);
CGRect SKRectCenterVerticallyInRect(CGRect rect, CGRect rectToCenterIn);
CGRect SKRectCenterHorizontallyInRect(CGRect rect, CGRect rectToCenterIn);
CGRect SKRectAddPoint(CGRect rect, CGPoint point);

/**
 if adjustWidth is true the width is adjusted and x remains the same.
 */
CGRect SKRectSetRight(CGRect rect, CGFloat right, BOOL adjustWidth);

/**
 if adjustHeight is true the height is adjusted and y remains the same.
 */
CGRect SKRectSetBottom(CGRect rect, CGFloat bottom,  BOOL adjustHeight);

/**
 @param t from 0 to 1.
 
 Interpolates between a and b.
 */
CGFloat SKInterpolateFloat(CGFloat a, CGFloat b, CGFloat
                           t);
/**
 @param t from 0 to 1.
 
 Interpolates between rect1 and rect2.
 */
CGRect SKRectInterpolate(CGRect rect1, CGRect rect2, CGFloat t);


/**
 Insets rect
 */
CGRect SKRectEdgeInset(CGRect rect, UIEdgeInsets insets);

/**
 @param The rect to translate
 @param The translation of the rect

  Translates rect.
 */
CGRect SKRectTranslate(CGRect rect, CGPoint translation);

CGRect SKCombineLateralVerticalRect(CGRect lateral, CGRect vertical);

/**
 @param point The CGPoint to negate
 */
CGPoint SKPointNegate(CGPoint point);

/**
 Adds point1 to point2
 */
CGPoint SKPointAdd(CGPoint point1, CGPoint point2);

/**
 Slices rect into a number of equally sized rects
 @param pieces Number of pieces
 @param edge The edge from which division starts
 */
NSArray *SKRectSlice(CGRect rect, NSInteger pieces, CGRectEdge edge);
