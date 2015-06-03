
#import "UIBezierPath+Paths.h"

@implementation UIBezierPath (Paths)

+ (UIBezierPath *)checkMarkOnGoingPath {
    UIBezierPath *path = UIBezierPath.bezierPath;
    [path moveToPoint: CGPointMake(224.23, 746.05)];
    [path addLineToPoint: CGPointMake(33.01, 746.05)];
    [path addLineToPoint: CGPointMake(33.01, 599.53)];
    [path addLineToPoint: CGPointMake(224.23, 599.53)];
    [path addLineToPoint: CGPointMake(224.23, 746.05)];
    [path closePath];
    [path moveToPoint: CGPointMake(212.35, 539.27)];
    [path addLineToPoint: CGPointMake(39.65, 539.27)];
    [path addLineToPoint: CGPointMake(-0.05, 190.12)];
    [path addLineToPoint: CGPointMake(-0.05, -0.05)];
    [path addLineToPoint: CGPointMake(252.05, -0.05)];
    [path addLineToPoint: CGPointMake(252.05, 190.12)];
    [path addLineToPoint: CGPointMake(212.35, 539.27)];
    [path closePath];
    return path;
}

+ (UIBezierPath *)checkMarkCompletedPath {
    UIBezierPath *path = UIBezierPath.bezierPath;
    [path moveToPoint: CGPointMake(6.81, 12.13)];
    [path addLineToPoint: CGPointMake(10.32, 18.95)];
    [path addCurveToPoint: CGPointMake(25.04, 0.48) controlPoint1: CGPointMake(10.32, 18.95) controlPoint2: CGPointMake(16.03, 5.1)];
    [path addCurveToPoint: CGPointMake(25.48, 10.15) controlPoint1: CGPointMake(24.82, 3.78) controlPoint2: CGPointMake(23.94, 6.64)];
    [path addCurveToPoint: CGPointMake(10.76, 25.76) controlPoint1: CGPointMake(21.53, 11.03) controlPoint2: CGPointMake(13.4, 20.92)];
    [path addCurveToPoint: CGPointMake(-0.44, 16.53) controlPoint1: CGPointMake(7.03, 21.14) controlPoint2: CGPointMake(2.64, 17.63)];
    [path addLineToPoint: CGPointMake(6.81, 12.13)];
    [path closePath];
    return path;
}

+ (UIBezierPath *)checkMarkFailedPath {
    UIBezierPath *path = UIBezierPath.bezierPath;
    [path moveToPoint: CGPointMake(249.49, -0.03)];
    [path addLineToPoint: CGPointMake(157.15, -0.03)];
    [path addLineToPoint: CGPointMake(127.65, 50.07)];
    [path addLineToPoint: CGPointMake(97.33, -0.03)];
    [path addLineToPoint: CGPointMake(2.92, -0.03)];
    [path addLineToPoint: CGPointMake(64.53, 107.44)];
    [path addLineToPoint: CGPointMake(0.03, 219.03)];
    [path addLineToPoint: CGPointMake(94.02, 219.03)];
    [path addLineToPoint: CGPointMake(125.17, 166.87)];
    [path addLineToPoint: CGPointMake(156.32, 219.03)];
    [path addLineToPoint: CGPointMake(251.97, 219.03)];
    [path addLineToPoint: CGPointMake(187.47, 107.44)];
    [path addLineToPoint: CGPointMake(249.49, -0.03)];
    [path closePath];
    return path;
}

+ (UIBezierPath *)achievementsPath {
    UIBezierPath *path = UIBezierPath.bezierPath;
    [path moveToPoint: CGPointMake(183.26, 14.68)];
    [path addCurveToPoint: CGPointMake(175.35, 8.04) controlPoint1: CGPointMake(181.94, 10.65) controlPoint2: CGPointMake(178.84, 8.04)];
    [path addLineToPoint: CGPointMake(150.4, 8.04)];
    [path addCurveToPoint: CGPointMake(150.13, -0) controlPoint1: CGPointMake(150.34, 3) controlPoint2: CGPointMake(150.13, -0)];
    [path addLineToPoint: CGPointMake(92, -0)];
    [path addLineToPoint: CGPointMake(33.86, -0)];
    [path addCurveToPoint: CGPointMake(33.6, 8.04) controlPoint1: CGPointMake(33.86, -0) controlPoint2: CGPointMake(33.66, 3)];
    [path addLineToPoint: CGPointMake(8.65, 8.04)];
    [path addCurveToPoint: CGPointMake(0.74, 14.68) controlPoint1: CGPointMake(5.16, 8.04) controlPoint2: CGPointMake(2.06, 10.65)];
    [path addCurveToPoint: CGPointMake(21.26, 82.81) controlPoint1: CGPointMake(-2.64, 25.08) controlPoint2: CGPointMake(5.86, 66.17)];
    [path addCurveToPoint: CGPointMake(41.4, 94.03) controlPoint1: CGPointMake(26.89, 88.9) controlPoint2: CGPointMake(33.73, 92.68)];
    [path addCurveToPoint: CGPointMake(44.99, 98.35) controlPoint1: CGPointMake(43.51, 94.92) controlPoint2: CGPointMake(45.15, 96.84)];
    [path addCurveToPoint: CGPointMake(42.4, 106.25) controlPoint1: CGPointMake(44.71, 100.87) controlPoint2: CGPointMake(40.74, 101.31)];
    [path addCurveToPoint: CGPointMake(55.99, 100.21) controlPoint1: CGPointMake(44.25, 111.75) controlPoint2: CGPointMake(54.43, 108.97)];
    [path addCurveToPoint: CGPointMake(76.21, 117.19) controlPoint1: CGPointMake(61.36, 107.34) controlPoint2: CGPointMake(68.01, 113.27)];
    [path addCurveToPoint: CGPointMake(79.37, 181.49) controlPoint1: CGPointMake(86.83, 122.27) controlPoint2: CGPointMake(79.37, 175.95)];
    [path addCurveToPoint: CGPointMake(59.43, 186.82) controlPoint1: CGPointMake(79.37, 181.49) controlPoint2: CGPointMake(62.42, 181.49)];
    [path addCurveToPoint: CGPointMake(57.93, 193.93) controlPoint1: CGPointMake(57.58, 190.12) controlPoint2: CGPointMake(57.93, 193.93)];
    [path addCurveToPoint: CGPointMake(46.97, 203.41) controlPoint1: CGPointMake(57.93, 193.93) controlPoint2: CGPointMake(46.97, 198.08)];
    [path addCurveToPoint: CGPointMake(46.97, 210) controlPoint1: CGPointMake(46.97, 208.74) controlPoint2: CGPointMake(46.97, 210)];
    [path addLineToPoint: CGPointMake(92, 210)];
    [path addLineToPoint: CGPointMake(137.04, 210)];
    [path addCurveToPoint: CGPointMake(137.04, 203.41) controlPoint1: CGPointMake(137.04, 210) controlPoint2: CGPointMake(137.04, 208.74)];
    [path addCurveToPoint: CGPointMake(126.07, 193.93) controlPoint1: CGPointMake(137.04, 198.08) controlPoint2: CGPointMake(126.07, 193.93)];
    [path addCurveToPoint: CGPointMake(124.57, 186.82) controlPoint1: CGPointMake(126.07, 193.93) controlPoint2: CGPointMake(126.43, 190.12)];
    [path addCurveToPoint: CGPointMake(104.63, 181.49) controlPoint1: CGPointMake(121.58, 181.49) controlPoint2: CGPointMake(104.63, 181.49)];
    [path addCurveToPoint: CGPointMake(107.79, 117.19) controlPoint1: CGPointMake(104.63, 175.95) controlPoint2: CGPointMake(97.17, 122.27)];
    [path addCurveToPoint: CGPointMake(128.01, 100.21) controlPoint1: CGPointMake(116, 113.27) controlPoint2: CGPointMake(122.64, 107.34)];
    [path addCurveToPoint: CGPointMake(141.6, 106.25) controlPoint1: CGPointMake(129.57, 108.97) controlPoint2: CGPointMake(139.75, 111.75)];
    [path addCurveToPoint: CGPointMake(139.01, 98.35) controlPoint1: CGPointMake(143.27, 101.31) controlPoint2: CGPointMake(139.29, 100.87)];
    [path addCurveToPoint: CGPointMake(142.6, 94.03) controlPoint1: CGPointMake(138.85, 96.84) controlPoint2: CGPointMake(140.5, 94.92)];
    [path addCurveToPoint: CGPointMake(162.74, 82.81) controlPoint1: CGPointMake(150.28, 92.68) controlPoint2: CGPointMake(157.11, 88.9)];
    [path addCurveToPoint: CGPointMake(183.26, 14.68) controlPoint1: CGPointMake(178.14, 66.17) controlPoint2: CGPointMake(186.64, 25.08)];
    [path closePath];
    [path moveToPoint: CGPointMake(8.65, 17.31)];
    [path addCurveToPoint: CGPointMake(33.67, 17.31) controlPoint1: CGPointMake(11.28, 17.31) controlPoint2: CGPointMake(26.03, 17.31)];
    [path addCurveToPoint: CGPointMake(47.21, 85.33) controlPoint1: CGPointMake(34.14, 34.91) controlPoint2: CGPointMake(36.72, 62.73)];
    [path addCurveToPoint: CGPointMake(26.5, 75.96) controlPoint1: CGPointMake(39.08, 85.18) controlPoint2: CGPointMake(32.13, 82.05)];
    [path addCurveToPoint: CGPointMake(8.65, 17.31) controlPoint1: CGPointMake(11.93, 60.2) controlPoint2: CGPointMake(5.08, 17.31)];
    [path closePath];
    [path moveToPoint: CGPointMake(157.5, 75.96)];
    [path addCurveToPoint: CGPointMake(136.79, 85.33) controlPoint1: CGPointMake(151.86, 82.05) controlPoint2: CGPointMake(144.92, 85.18)];
    [path addCurveToPoint: CGPointMake(150.32, 17.31) controlPoint1: CGPointMake(147.28, 62.73) controlPoint2: CGPointMake(149.86, 34.91)];
    [path addCurveToPoint: CGPointMake(175.35, 17.31) controlPoint1: CGPointMake(157.97, 17.31) controlPoint2: CGPointMake(172.73, 17.31)];
    [path addCurveToPoint: CGPointMake(157.5, 75.96) controlPoint1: CGPointMake(178.92, 17.31) controlPoint2: CGPointMake(172.07, 60.2)];
    return path;
}

+ (UIBezierPath *)highscoresPath {
    UIBezierPath *path = UIBezierPath.bezierPath;
    [path moveToPoint: CGPointMake(196.01, 127)];
    [path addLineToPoint: CGPointMake(196.01, 69.39)];
    [path addCurveToPoint: CGPointMake(179.63, 53) controlPoint1: CGPointMake(196.01, 60.34) controlPoint2: CGPointMake(188.68, 53)];
    [path addLineToPoint: CGPointMake(16.37, 53)];
    [path addCurveToPoint: CGPointMake(-0.01, 69.39) controlPoint1: CGPointMake(7.32, 53) controlPoint2: CGPointMake(-0.01, 60.34)];
    [path addLineToPoint: CGPointMake(-0.01, 127)];
    [path addLineToPoint: CGPointMake(196.01, 127)];
    [path closePath];
    [path moveToPoint: CGPointMake(136, 62)];
    [path addLineToPoint: CGPointMake(136, 13.73)];
    [path addCurveToPoint: CGPointMake(129.74, 0) controlPoint1: CGPointMake(136, 6.15) controlPoint2: CGPointMake(133.2, 0)];
    [path addLineToPoint: CGPointMake(67.26, 0)];
    [path addCurveToPoint: CGPointMake(61, 13.73) controlPoint1: CGPointMake(63.8, 0) controlPoint2: CGPointMake(61, 6.15)];
    [path addLineToPoint: CGPointMake(61, 62)];
    [path addLineToPoint: CGPointMake(136, 62)];
    [path closePath];
    [path moveToPoint: CGPointMake(97.03, 19.49)];
    [path addLineToPoint: CGPointMake(92.51, 21.93)];
    [path addLineToPoint: CGPointMake(91.83, 19.25)];
    [path addLineToPoint: CGPointMake(97.51, 16.21)];
    [path addLineToPoint: CGPointMake(100.51, 16.21)];
    [path addLineToPoint: CGPointMake(100.51, 42.21)];
    [path addLineToPoint: CGPointMake(97.11, 42.21)];
    [path addLineToPoint: CGPointMake(97.11, 19.49)];
    [path addLineToPoint: CGPointMake(97.03, 19.49)];
    [path closePath];
    [path moveToPoint: CGPointMake(25.73, 102.88)];
    [path addLineToPoint: CGPointMake(28.49, 100.2)];
    [path addCurveToPoint: CGPointMake(38.17, 86.61) controlPoint1: CGPointMake(35.13, 93.89) controlPoint2: CGPointMake(38.13, 90.53)];
    [path addCurveToPoint: CGPointMake(33.01, 81.53) controlPoint1: CGPointMake(38.17, 83.97) controlPoint2: CGPointMake(36.89, 81.53)];
    [path addCurveToPoint: CGPointMake(27.49, 83.73) controlPoint1: CGPointMake(30.65, 81.53) controlPoint2: CGPointMake(28.69, 82.73)];
    [path addLineToPoint: CGPointMake(26.37, 81.25)];
    [path addCurveToPoint: CGPointMake(33.73, 78.61) controlPoint1: CGPointMake(28.17, 79.73) controlPoint2: CGPointMake(30.73, 78.61)];
    [path addCurveToPoint: CGPointMake(41.69, 86.17) controlPoint1: CGPointMake(39.33, 78.61) controlPoint2: CGPointMake(41.69, 82.45)];
    [path addCurveToPoint: CGPointMake(32.73, 100.12) controlPoint1: CGPointMake(41.69, 90.97) controlPoint2: CGPointMake(38.21, 94.85)];
    [path addLineToPoint: CGPointMake(30.65, 102.04)];
    [path addLineToPoint: CGPointMake(30.65, 102.12)];
    [path addLineToPoint: CGPointMake(42.33, 102.12)];
    [path addLineToPoint: CGPointMake(42.33, 105.04)];
    [path addLineToPoint: CGPointMake(25.73, 105.04)];
    [path addLineToPoint: CGPointMake(25.73, 102.88)];
    [path closePath];
    [path moveToPoint: CGPointMake(156.43, 103.01)];
    [path addCurveToPoint: CGPointMake(162.31, 97.97) controlPoint1: CGPointMake(160.95, 103.01) controlPoint2: CGPointMake(162.35, 100.13)];
    [path addCurveToPoint: CGPointMake(155.59, 92.77) controlPoint1: CGPointMake(162.27, 94.33) controlPoint2: CGPointMake(158.99, 92.77)];
    [path addLineToPoint: CGPointMake(153.63, 92.77)];
    [path addLineToPoint: CGPointMake(153.63, 90.14)];
    [path addLineToPoint: CGPointMake(155.59, 90.14)];
    [path addCurveToPoint: CGPointMake(161.39, 85.74) controlPoint1: CGPointMake(158.15, 90.14) controlPoint2: CGPointMake(161.39, 88.82)];
    [path addCurveToPoint: CGPointMake(156.83, 81.82) controlPoint1: CGPointMake(161.39, 83.66) controlPoint2: CGPointMake(160.07, 81.82)];
    [path addCurveToPoint: CGPointMake(151.63, 83.54) controlPoint1: CGPointMake(154.75, 81.82) controlPoint2: CGPointMake(152.75, 82.74)];
    [path addLineToPoint: CGPointMake(150.71, 80.98)];
    [path addCurveToPoint: CGPointMake(157.51, 78.98) controlPoint1: CGPointMake(152.07, 79.98) controlPoint2: CGPointMake(154.71, 78.98)];
    [path addCurveToPoint: CGPointMake(164.95, 85.18) controlPoint1: CGPointMake(162.63, 78.98) controlPoint2: CGPointMake(164.95, 82.02)];
    [path addCurveToPoint: CGPointMake(160.15, 91.3) controlPoint1: CGPointMake(164.95, 87.86) controlPoint2: CGPointMake(163.35, 90.14)];
    [path addLineToPoint: CGPointMake(160.15, 91.38)];
    [path addCurveToPoint: CGPointMake(165.95, 98.05) controlPoint1: CGPointMake(163.35, 92.02) controlPoint2: CGPointMake(165.95, 94.41)];
    [path addCurveToPoint: CGPointMake(156.47, 105.85) controlPoint1: CGPointMake(165.95, 102.21) controlPoint2: CGPointMake(162.71, 105.85)];
    [path addCurveToPoint: CGPointMake(149.71, 104.09) controlPoint1: CGPointMake(153.55, 105.85) controlPoint2: CGPointMake(150.99, 104.93)];
    [path addLineToPoint: CGPointMake(150.67, 101.37)];
    [path addCurveToPoint: CGPointMake(156.43, 103.01) controlPoint1: CGPointMake(151.67, 102.01) controlPoint2: CGPointMake(153.99, 103.01)];
    [path closePath];
    return path;
}

+ (UIBezierPath *)playPath {
    UIBezierPath *path = UIBezierPath.bezierPath;
    [path moveToPoint: CGPointMake(-0, 138.92)];
    [path addCurveToPoint: CGPointMake(-0, 8.29) controlPoint1: CGPointMake(-0, 132.14) controlPoint2: CGPointMake(-0, 12.97)];
    [path addCurveToPoint: CGPointMake(12.43, 1.25) controlPoint1: CGPointMake(-0, 2.22) controlPoint2: CGPointMake(6.25, -2.3)];
    [path addCurveToPoint: CGPointMake(124.86, 66.44) controlPoint1: CGPointMake(17.39, 4.1) controlPoint2: CGPointMake(116.41, 61.53)];
    [path addCurveToPoint: CGPointMake(124.86, 80.59) controlPoint1: CGPointMake(130.41, 69.66) controlPoint2: CGPointMake(130.32, 77.36)];
    [path addCurveToPoint: CGPointMake(12.18, 145.92) controlPoint1: CGPointMake(118.78, 84.19) controlPoint2: CGPointMake(19.38, 141.91)];
    [path addCurveToPoint: CGPointMake(-0, 138.92) controlPoint1: CGPointMake(6.91, 148.86) controlPoint2: CGPointMake(-0, 145.61)];
    [path closePath];
    return path;
}

+ (UIBezierPath *)optionsPath {
    UIBezierPath *path = UIBezierPath.bezierPath;
    [path moveToPoint: CGPointMake(194, 90.31)];
    [path addLineToPoint: CGPointMake(194, 103.69)];
    [path addLineToPoint: CGPointMake(175.38, 111.97)];
    [path addCurveToPoint: CGPointMake(172.36, 123.23) controlPoint1: CGPointMake(174.65, 115.83) controlPoint2: CGPointMake(173.63, 119.59)];
    [path addLineToPoint: CGPointMake(184.35, 139.71)];
    [path addLineToPoint: CGPointMake(177.66, 151.29)];
    [path addLineToPoint: CGPointMake(157.38, 149.15)];
    [path addCurveToPoint: CGPointMake(149.15, 157.38) controlPoint1: CGPointMake(154.84, 152.09) controlPoint2: CGPointMake(152.09, 154.84)];
    [path addLineToPoint: CGPointMake(151.29, 177.66)];
    [path addLineToPoint: CGPointMake(139.71, 184.35)];
    [path addLineToPoint: CGPointMake(123.23, 172.36)];
    [path addCurveToPoint: CGPointMake(111.97, 175.38) controlPoint1: CGPointMake(119.59, 173.63) controlPoint2: CGPointMake(115.83, 174.65)];
    [path addLineToPoint: CGPointMake(103.69, 194)];
    [path addLineToPoint: CGPointMake(90.31, 194)];
    [path addLineToPoint: CGPointMake(82.03, 175.38)];
    [path addCurveToPoint: CGPointMake(70.77, 172.36) controlPoint1: CGPointMake(78.17, 174.65) controlPoint2: CGPointMake(74.41, 173.63)];
    [path addLineToPoint: CGPointMake(54.29, 184.35)];
    [path addLineToPoint: CGPointMake(42.71, 177.66)];
    [path addLineToPoint: CGPointMake(44.85, 157.38)];
    [path addCurveToPoint: CGPointMake(36.62, 149.15) controlPoint1: CGPointMake(41.91, 154.84) controlPoint2: CGPointMake(39.16, 152.09)];
    [path addLineToPoint: CGPointMake(16.34, 151.29)];
    [path addLineToPoint: CGPointMake(9.65, 139.71)];
    [path addLineToPoint: CGPointMake(21.64, 123.23)];
    [path addCurveToPoint: CGPointMake(18.62, 111.96) controlPoint1: CGPointMake(20.37, 119.59) controlPoint2: CGPointMake(19.35, 115.83)];
    [path addLineToPoint: CGPointMake(-0, 103.69)];
    [path addLineToPoint: CGPointMake(-0, 90.31)];
    [path addLineToPoint: CGPointMake(18.62, 82.04)];
    [path addCurveToPoint: CGPointMake(21.63, 70.76) controlPoint1: CGPointMake(19.35, 78.17) controlPoint2: CGPointMake(20.36, 74.41)];
    [path addLineToPoint: CGPointMake(9.65, 54.29)];
    [path addLineToPoint: CGPointMake(16.34, 42.71)];
    [path addLineToPoint: CGPointMake(36.63, 44.85)];
    [path addCurveToPoint: CGPointMake(44.85, 36.62) controlPoint1: CGPointMake(39.17, 41.92) controlPoint2: CGPointMake(41.91, 39.16)];
    [path addLineToPoint: CGPointMake(42.71, 16.34)];
    [path addLineToPoint: CGPointMake(54.29, 9.65)];
    [path addLineToPoint: CGPointMake(70.77, 21.64)];
    [path addCurveToPoint: CGPointMake(82.03, 18.62) controlPoint1: CGPointMake(74.41, 20.37) controlPoint2: CGPointMake(78.17, 19.35)];
    [path addLineToPoint: CGPointMake(90.31, -0)];
    [path addLineToPoint: CGPointMake(103.69, -0)];
    [path addLineToPoint: CGPointMake(111.97, 18.62)];
    [path addCurveToPoint: CGPointMake(123.23, 21.64) controlPoint1: CGPointMake(115.83, 19.35) controlPoint2: CGPointMake(119.59, 20.37)];
    [path addLineToPoint: CGPointMake(139.71, 9.65)];
    [path addLineToPoint: CGPointMake(151.29, 16.34)];
    [path addLineToPoint: CGPointMake(149.15, 36.62)];
    [path addCurveToPoint: CGPointMake(157.37, 44.85) controlPoint1: CGPointMake(152.09, 39.16) controlPoint2: CGPointMake(154.83, 41.92)];
    [path addLineToPoint: CGPointMake(177.66, 42.71)];
    [path addLineToPoint: CGPointMake(184.35, 54.29)];
    [path addLineToPoint: CGPointMake(172.37, 70.76)];
    [path addCurveToPoint: CGPointMake(175.38, 82.04) controlPoint1: CGPointMake(173.64, 74.41) controlPoint2: CGPointMake(174.65, 78.17)];
    [path addLineToPoint: CGPointMake(194, 90.31)];
    [path closePath];
    [path moveToPoint: CGPointMake(97, 66.88)];
    [path addCurveToPoint: CGPointMake(66.88, 97) controlPoint1: CGPointMake(80.36, 66.88) controlPoint2: CGPointMake(66.88, 80.36)];
    [path addCurveToPoint: CGPointMake(97, 127.12) controlPoint1: CGPointMake(66.88, 113.64) controlPoint2: CGPointMake(80.36, 127.12)];
    [path addCurveToPoint: CGPointMake(127.12, 97) controlPoint1: CGPointMake(113.64, 127.12) controlPoint2: CGPointMake(127.12, 113.64)];
    [path addCurveToPoint: CGPointMake(97, 66.88) controlPoint1: CGPointMake(127.12, 80.36) controlPoint2: CGPointMake(113.64, 66.88)];
    [path closePath];
    return path;
}

+ (UIBezierPath *)undoPath {
    UIBezierPath *path = UIBezierPath.bezierPath;
    [path moveToPoint: CGPointMake(156, 156)];
    [path addLineToPoint: CGPointMake(12, 156)];
    [path addLineToPoint: CGPointMake(12, 12)];
    [path addLineToPoint: CGPointMake(156, 12)];
    [path addLineToPoint: CGPointMake(156, 156)];
    [path closePath];
    [path moveToPoint: CGPointMake(0, 0)];
    [path addLineToPoint: CGPointMake(0, 168)];
    [path addLineToPoint: CGPointMake(168, 168)];
    [path addLineToPoint: CGPointMake(168, 0)];
    [path addLineToPoint: CGPointMake(0, 0)];
    [path closePath];
    [path moveToPoint: CGPointMake(54.17, 116.37)];
    [path addLineToPoint: CGPointMake(30, 92.99)];
    [path addCurveToPoint: CGPointMake(31.56, 86.6) controlPoint1: CGPointMake(27.44, 90.52) controlPoint2: CGPointMake(28.13, 87.63)];
    [path addLineToPoint: CGPointMake(39.22, 84.28)];
    [path addCurveToPoint: CGPointMake(44.46, 59.31) controlPoint1: CGPointMake(38.6, 75.9) controlPoint2: CGPointMake(40.21, 67.26)];
    [path addCurveToPoint: CGPointMake(106.7, 40.46) controlPoint1: CGPointMake(56.45, 36.91) controlPoint2: CGPointMake(84.31, 28.48)];
    [path addCurveToPoint: CGPointMake(125.54, 102.7) controlPoint1: CGPointMake(129.09, 52.44) controlPoint2: CGPointMake(137.53, 80.3)];
    [path addCurveToPoint: CGPointMake(97.07, 125.33) controlPoint1: CGPointMake(119.33, 114.31) controlPoint2: CGPointMake(108.85, 122.12)];
    [path addLineToPoint: CGPointMake(96.84, 112.37)];
    [path addCurveToPoint: CGPointMake(114.59, 96.84) controlPoint1: CGPointMake(104.19, 109.6) controlPoint2: CGPointMake(110.6, 104.3)];
    [path addCurveToPoint: CGPointMake(100.84, 51.42) controlPoint1: CGPointMake(123.33, 80.5) controlPoint2: CGPointMake(117.17, 60.16)];
    [path addCurveToPoint: CGPointMake(55.42, 65.17) controlPoint1: CGPointMake(84.5, 42.67) controlPoint2: CGPointMake(64.16, 48.83)];
    [path addCurveToPoint: CGPointMake(51.49, 80.56) controlPoint1: CGPointMake(52.79, 70.08) controlPoint2: CGPointMake(51.55, 75.35)];
    [path addLineToPoint: CGPointMake(62.52, 77.22)];
    [path addCurveToPoint: CGPointMake(67.36, 81.69) controlPoint1: CGPointMake(65.95, 76.19) controlPoint2: CGPointMake(68.13, 78.2)];
    [path addLineToPoint: CGPointMake(60.23, 114.54)];
    [path addCurveToPoint: CGPointMake(54.17, 116.37) controlPoint1: CGPointMake(59.46, 118.03) controlPoint2: CGPointMake(56.74, 118.85)];
    [path closePath];
    return path;
}

+ (UIBezierPath *)storagePath {
    UIBezierPath *path = UIBezierPath.bezierPath;
    [path moveToPoint: CGPointMake(-0, -0)];
    [path addLineToPoint: CGPointMake(0, 36)];
    [path addLineToPoint: CGPointMake(12, 36)];
    [path addLineToPoint: CGPointMake(12, 12)];
    [path addLineToPoint: CGPointMake(36, 12)];
    [path addLineToPoint: CGPointMake(36, -0)];
    [path addLineToPoint: CGPointMake(-0, -0)];
    [path closePath];
    [path moveToPoint: CGPointMake(0, 134)];
    [path addLineToPoint: CGPointMake(12, 134)];
    [path addLineToPoint: CGPointMake(12, 158)];
    [path addLineToPoint: CGPointMake(36, 158)];
    [path addLineToPoint: CGPointMake(36, 170)];
    [path addLineToPoint: CGPointMake(0, 170)];
    [path addLineToPoint: CGPointMake(0, 134)];
    [path closePath];
    [path moveToPoint: CGPointMake(134, 170)];
    [path addLineToPoint: CGPointMake(134, 158)];
    [path addLineToPoint: CGPointMake(158, 158)];
    [path addLineToPoint: CGPointMake(158, 134)];
    [path addLineToPoint: CGPointMake(170, 134)];
    [path addLineToPoint: CGPointMake(170, 170)];
    [path addLineToPoint: CGPointMake(134, 170)];
    [path closePath];
    [path moveToPoint: CGPointMake(170, 36)];
    [path addLineToPoint: CGPointMake(158, 36)];
    [path addLineToPoint: CGPointMake(158, 12)];
    [path addLineToPoint: CGPointMake(134, 12)];
    [path addLineToPoint: CGPointMake(134, 0)];
    [path addLineToPoint: CGPointMake(170, 0)];
    [path addLineToPoint: CGPointMake(170, 36)];
    [path closePath];
    return path;
}

+ (UIBezierPath *)addPath {
    UIBezierPath *path = UIBezierPath.bezierPath;
    [path moveToPoint: CGPointMake(156, 156)];
    [path addLineToPoint: CGPointMake(12, 156)];
    [path addLineToPoint: CGPointMake(12, 12)];
    [path addLineToPoint: CGPointMake(156, 12)];
    [path addLineToPoint: CGPointMake(156, 156)];
    [path closePath];
    [path moveToPoint: CGPointMake(0, 0)];
    [path addLineToPoint: CGPointMake(0, 168)];
    [path addLineToPoint: CGPointMake(168, 168)];
    [path addLineToPoint: CGPointMake(168, 0)];
    [path addLineToPoint: CGPointMake(0, 0)];
    [path closePath];
    [path moveToPoint: CGPointMake(34, 78)];
    [path addLineToPoint: CGPointMake(134, 78)];
    [path addLineToPoint: CGPointMake(134, 90)];
    [path addLineToPoint: CGPointMake(34, 90)];
    [path addLineToPoint: CGPointMake(34, 78)];
    [path closePath];
    [path moveToPoint: CGPointMake(78, 34)];
    [path addLineToPoint: CGPointMake(90, 34)];
    [path addLineToPoint: CGPointMake(90, 134)];
    [path addLineToPoint: CGPointMake(78, 134)];
    [path addLineToPoint: CGPointMake(78, 34)];
    [path closePath];
    return path;
}

@end
