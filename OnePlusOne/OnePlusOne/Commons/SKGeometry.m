//
//  SKRectFunctions.m
//


#import "SKGeometry.h"



CGRect SKRectSetOrigin(CGRect rect, CGPoint origin) {
	return CGRectMake(origin.x, origin.y, rect.size.width, rect.size.height);
}

CGRect SKRectSetSize(CGRect rect, CGSize size) {
	return CGRectMake(rect.origin.x, rect.origin.y, size.width, size.height);
}

CGRect SKRectSetX(CGRect rect, CGFloat x) {
	return CGRectMake(x, rect.origin.y, rect.size.width, rect.size.height);
}

CGRect SKRectSetY(CGRect rect, CGFloat y) {
	return CGRectMake(rect.origin.x, y, rect.size.width, rect.size.height);
}

CGRect SKRectSetRight(CGRect rect, CGFloat right, BOOL adjustWidth) {
    if (adjustWidth) {
        return CGRectMake(rect.origin.x, rect.origin.y, right - rect.origin.x, rect.size.height);
    } else {
        return CGRectMake(right - rect.size.width, rect.origin.y, rect.size.width, rect.size.height);
    }
}

CGRect SKRectSetBottom(CGRect rect, CGFloat bottom,  BOOL adjustHeight) {
    if (adjustHeight) {
        return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, bottom - rect.origin.y);
    } else {
        return CGRectMake(rect.origin.x, bottom - rect.size.height, rect.size.width, rect.size.height);
    }
}

CGRect SKRectSetWidth(CGRect rect, CGFloat width) {
	return CGRectMake(rect.origin.x, rect.origin.y, width, rect.size.height);
}

CGRect SKRectSetHeight(CGRect rect, CGFloat height) {
	return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, height);
}

CGRect SKRectAlignRightInRect(CGRect rect, CGRect rectToAlignIn, int spacing) {
    return CGRectMake(rectToAlignIn.size.width - rect.size.width - spacing, rect.origin.y, rect.size.width, rect.size.height);
}

CGRect SKRectCenterInRect(CGRect rect, CGRect rectToCenterIn) {
    return CGRectMake( roundf((rectToCenterIn.size.width - rect.size.width) / 2), roundf((rectToCenterIn.size.height - rect.size.height) / 2), rect.size.width, rect.size.height);
}

CGRect SKRectCenterVerticallyInRect(CGRect rect, CGRect rectToCenterIn) {
    return CGRectMake( rect.origin.x, roundf((rectToCenterIn.size.height - rect.size.height) / 2), rect.size.width, rect.size.height);
}

CGRect SKRectCenterHorizontallyInRect(CGRect rect, CGRect rectToCenterIn) {
    return CGRectMake( roundf((rectToCenterIn.size.width - rect.size.width) / 2), rect.origin.y, rect.size.width, rect.size.height);
}

CGRect SKRectAddPoint(CGRect rect, CGPoint point) {
	return CGRectMake(rect.origin.x + point.x, rect.origin.y + point.y, rect.size.width, rect.size.height);
}

CGRect SKRectEdgeInset(CGRect rect, UIEdgeInsets insets) {
    return CGRectMake(CGRectGetMinX(rect) + insets.left, CGRectGetMinY(rect) + insets.top, CGRectGetWidth(rect) - insets.left - insets.right, CGRectGetHeight(rect) - insets.top -insets.bottom);
}

CGRect SKRectInterpolate(CGRect rect1, CGRect rect2, CGFloat t) {
    return CGRectMake(SKInterpolateFloat(rect1.origin.x, rect2.origin.x, t),
                      SKInterpolateFloat(rect1.origin.y, rect2.origin.y, t),
                      SKInterpolateFloat(rect1.size.width, rect2.size.width, t),
                      SKInterpolateFloat(rect1.size.height, rect2.size.height, t));
}

CGFloat SKInterpolateFloat(CGFloat a, CGFloat b, CGFloat t) {
    if (t <= 0) {
        return a;
    }
    if (t >= 1) {
        return b;
    }
    return a * (1 - t) + b * t;
}

CGRect SKRectTranslate(CGRect rect, CGPoint translation) {
    return CGRectMake(rect.origin.x + translation.x, rect.origin.y + translation.y, rect.size.width, rect.size.height);
}

CGRect SKCombineLateralVerticalRect(CGRect lateral, CGRect vertical) {
    return CGRectMake(lateral.origin.x, vertical.origin.y, lateral.size.width, vertical.size.height);
}

CGPoint SKPointAdd(CGPoint point1, CGPoint point2) {
    return CGPointMake(point1.x + point2.x, point1.y + point2.y);
}

CGPoint SKPointNegate(CGPoint point) {
    return CGPointMake(- point.x, - point.y);
}

NSArray *SKRectSlice(CGRect rect, NSInteger pieces, CGRectEdge edge) {
    if (pieces == 0) {
        return @[];
    }
    CGRect slice;
    CGRect remainder = rect;
    CGFloat amount = (edge == CGRectMinXEdge || edge == CGRectMaxXEdge) ? CGRectGetWidth(rect) / pieces : CGRectGetHeight(rect) / pieces;
    NSMutableArray *items = [NSMutableArray new];
    for (int i = 0; i < pieces; i++) {
        CGRectDivide(remainder, &slice, &remainder, amount, edge);
        [items addObject:[NSValue valueWithCGRect:slice]];
    }
    return items;
}
