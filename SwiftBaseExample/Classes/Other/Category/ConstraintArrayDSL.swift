//
//  SnapKitExtend
//
//  MIT License
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//  Created by charles on 2017/8/2.
//  Copyright © 2017年 charles. All rights reserved.
//   使用博客 https://www.jianshu.com/p/74b4561828f7
//https://blog.csdn.net/zn_echonn/article/details/80395156
//https://www.cnblogs.com/sundaysme/articles/11775738.html

import SnapKit

public enum ConstraintAxis : Int {
    case horizontal
    case vertical
}

#if os(iOS) || os(tvOS)
import UIKit
public typealias ConstraintEdgeInsets = UIEdgeInsets
#else
import AppKit
extension NSEdgeInsets {
    public static let zero = NSEdgeInsetsZero
}
public typealias ConstraintEdgeInsets = NSEdgeInsets


#endif

public struct ConstraintArrayDSL {
    @discardableResult
    public func prepareConstraints(_ closure: (_ make: ConstraintMaker) -> Void) -> [Constraint] {
        var constraints = Array<Constraint>()
        for view in self.array {
            constraints.append(contentsOf: view.snp.prepareConstraints(closure))
        }
        return constraints
    }
    
    public func makeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        for view in self.array {
            view.snp.makeConstraints(closure)
        }
    }
    
    public func remakeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        for view in self.array {
            view.snp.remakeConstraints(closure)
        }
    }
    
    public func updateConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        for view in self.array {
            view.snp.updateConstraints(closure)
        }
    }
    
    public func removeConstraints() {
        for view in self.array {
            view.snp.removeConstraints()
        }
    }
    
    
    /// distribute with the width that you give
   /// you should calculate the width of each item first
   ///
   /// - Parameters:
   ///   - verticalSpacing: the vertical spacing between each item
   ///   - horizontalSpacing: the horizontal spacing between each item
   ///   - tailSpacing: the spacing after the last item and the container
   ///   - maxWidth: the max width of each row or each item
   ///   - determineWidths: the width of each item, you must ensure determineWidths.count == self.array.count
   ///   - itemHeight: the height of each item
   ///   - edgeInset: the edgeInset of all item, default is UIEdgeInsets.zero
   ///                if edgeInset.left or edgeInset.right is not 0, the maxWidth will change, maxWidth -=  (edgeInset.left +  edgeInset.right)
   ///   - topConstrainView: the view before the first item
    ///https://blog.csdn.net/zn_echonn/article/details/80395156
    ///https://www.cnblogs.com/sundaysme/articles/11775738.html
   public func distributeDetermineWidthViews(verticalSpacing: CGFloat,
                                             horizontalSpacing: CGFloat,
                                             maxWidth: CGFloat,
                                             determineWidths: [CGFloat],
                                             itemHeight: CGFloat,
                                             edgeInset: UIEdgeInsets = UIEdgeInsets.zero,
                                             topConstrainView: ConstraintView? = nil) {
       
       guard self.array.count > 1, determineWidths.count == self.array.count, let tempSuperview = commonSuperviewOfViews() else {
           return
       }
       
       var prev : ConstraintView?
       var vMinX: CGFloat = 0
       
       let maxW = maxWidth - (edgeInset.right + edgeInset.left)
       
       for (i,v) in self.array.enumerated() {
           
           let curWidth = min(determineWidths[i], maxW)
           v.snp.makeConstraints({ (make) in
               make.width.equalTo(curWidth)
               make.bottom.lessThanOrEqualTo(tempSuperview).offset(-edgeInset.bottom)
               make.height.equalTo(itemHeight)
               
               if prev == nil { // the first one
                   let tmpTarget = topConstrainView != nil ? topConstrainView!.snp.bottom : tempSuperview.snp.top
                   make.top.equalTo(tmpTarget).offset(edgeInset.top)
                   make.left.equalTo(tempSuperview).offset(edgeInset.left)
                   vMinX = curWidth + horizontalSpacing
               }
               else {
                   make.right.lessThanOrEqualToSuperview().offset(-edgeInset.right)
                   
                   if vMinX + curWidth > maxW {
                       make.top.equalTo(prev!.snp.bottom).offset(verticalSpacing)
                       make.left.equalTo(tempSuperview).offset(edgeInset.left)
                       vMinX = curWidth + horizontalSpacing
                   }
                   else {
                       make.top.equalTo(prev!)
                       make.left.equalTo(prev!.snp.right).offset(horizontalSpacing)
                       vMinX += curWidth + horizontalSpacing
                   }
               }
           })
           
           prev = v
       }
   }
    
    ///只使用与label的简单竖排和横排
    public func distributeDetermineViews(verticalSpacing: CGFloat,
                                              horizontalSpacing: CGFloat,
                                              maxWidth: CGFloat,
                                              itemHeight: CGFloat,
                                              edgeInset: UIEdgeInsets = UIEdgeInsets.zero,
                                              topConstrainView: ConstraintView? = nil) {
        
        guard self.array.count > 1, let tempSuperview = commonSuperviewOfViews() else {
            return
        }
        
        var prev : ConstraintView?
        var vMinX: CGFloat = 0
        
        let maxW = maxWidth - (edgeInset.right + edgeInset.left)
        
        for (i,v) in self.array.enumerated() {
            v.sizeToFit()
            let curWidth = min(v.width(), maxW)
            v.snp.makeConstraints({ (make) in
                make.width.equalTo(curWidth)
                make.bottom.lessThanOrEqualTo(tempSuperview).offset(-edgeInset.bottom)
                make.height.equalTo(itemHeight)
                
                if prev == nil { // the first one
                    let tmpTarget = topConstrainView != nil ? topConstrainView!.snp.bottom : tempSuperview.snp.top
                    make.top.equalTo(tmpTarget).offset(edgeInset.top)
                    make.left.equalTo(tempSuperview).offset(edgeInset.left)
                    vMinX = curWidth + horizontalSpacing
                }
                else {
                    make.right.lessThanOrEqualToSuperview().offset(-edgeInset.right)
                    
                    if vMinX + curWidth > maxW {
                        make.top.equalTo(prev!.snp.bottom).offset(verticalSpacing)
                        make.left.equalTo(tempSuperview).offset(edgeInset.left)
                        vMinX = curWidth + horizontalSpacing
                    }
                    else {
                        make.top.equalTo(prev!)
                        make.left.equalTo(prev!.snp.right).offset(horizontalSpacing)
                        vMinX += curWidth + horizontalSpacing
                    }
                }
            })
            
            prev = v
        }
    }
    ///只使用与label的简单竖排和横排
    public func distributeDetermineWrapViews(verticalSpacing: CGFloat,
                                              horizontalSpacing: CGFloat,
                                              maxWidth: CGFloat,
                                              edgeInset: UIEdgeInsets = UIEdgeInsets.zero,
                                              topConstrainView: ConstraintView? = nil,maskBourds:Bool = false ,cornerRadio:CGFloat = 10) {
        
        guard self.array.count > 1, let tempSuperview = commonSuperviewOfViews() else {
            return
        }
        
        var prev : ConstraintView?
        var vMinX: CGFloat = 0
        
        let maxW = maxWidth - (edgeInset.right + edgeInset.left)
        
        for (i,v) in self.array.enumerated() {
            v.sizeToFit()
            if maskBourds == true {
                v.layer.cornerRadius = cornerRadio
                v.layer.masksToBounds = maskBourds
            }
            let curWidth = min(v.width(), maxW)
            v.snp.makeConstraints({ (make) in
                make.width.equalTo(curWidth)
                make.bottom.lessThanOrEqualTo(tempSuperview).offset(-edgeInset.bottom)
                
                if prev == nil { // the first one
                    let tmpTarget = topConstrainView != nil ? topConstrainView!.snp.bottom : tempSuperview.snp.top
                    make.top.equalTo(tmpTarget).offset(edgeInset.top)
                    make.left.equalTo(tempSuperview).offset(edgeInset.left)
                    vMinX = curWidth + horizontalSpacing
                }
                else {
                    make.right.lessThanOrEqualToSuperview().offset(-edgeInset.right)
                    
                    if vMinX + curWidth > maxW {
                        make.top.equalTo(prev!.snp.bottom).offset(verticalSpacing)
                        make.left.equalTo(tempSuperview).offset(edgeInset.left)
                        vMinX = curWidth + horizontalSpacing
                    }
                    else {
                        make.top.equalTo(prev!)
                        make.left.equalTo(prev!.snp.right).offset(horizontalSpacing)
                        vMinX += curWidth + horizontalSpacing
                    }
                }
            })
            
            prev = v
        }
    }
    /// distribute with fixed spacing
    ///
    /// - Parameters:
    ///   - axisType: which axis to distribute items along
    ///   - fixedSpacing: the spacing between each item
    ///   - leadSpacing: the spacing before the first item and the container
    ///   - tailSpacing: the spacing after the last item and the container
    public func distributeViewsAlong(axisType:ConstraintAxis, fixedSpacing:CGFloat = 0, leadSpacing:CGFloat = 0, tailSpacing:CGFloat = 0) {
        
        guard self.array.count > 1, let tempSuperView = commonSuperviewOfViews() else {
            return
        }
        
        if axisType == .horizontal {
            var prev : ConstraintView?
            for (i, v) in self.array.enumerated() {
                v.snp.makeConstraints({ (make) in
                    guard let prev = prev else {//first one
                        make.left.equalTo(tempSuperView).offset(leadSpacing)
                        return
                    }
                    make.width.equalTo(prev)
                    make.left.equalTo(prev.snp.right).offset(fixedSpacing)
                    if (i == self.array.count - 1) {//last one
                        make.right.equalTo(tempSuperView).offset(-tailSpacing)
                    }
                })
                prev = v;
            }
        }else {
            var prev : ConstraintView?
            for (i, v) in self.array.enumerated() {
                v.snp.makeConstraints({ (make) in
                    guard let prev = prev else {//first one
                        make.top.equalTo(tempSuperView).offset(leadSpacing);
                        return
                    }
                    make.height.equalTo(prev)
                    make.top.equalTo(prev.snp.bottom).offset(fixedSpacing)
                    if (i == self.array.count - 1) {//last one
                        make.bottom.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                })
                prev = v;
            }
        }
    }
    
    /// distribute with fixed item size
    ///
    /// - Parameters:
    ///   - axisType: which axis to distribute items along
    ///   - fixedItemLength: the fixed length of each item
    ///   - leadSpacing: the spacing before the first item and the container
    ///   - tailSpacing: the spacing after the last item and the container
    public func distributeViewsAlong(axisType:ConstraintAxis, fixedItemLength:CGFloat = 0, leadSpacing:CGFloat = 0, tailSpacing:CGFloat = 0) {
        
        guard self.array.count > 1, let tempSuperView = commonSuperviewOfViews() else {
            return
        }
        
        if axisType == .horizontal {
            var prev : ConstraintView?
            for (i, v) in self.array.enumerated() {
                v.snp.makeConstraints({ (make) in
                    make.width.equalTo(fixedItemLength)
                    if prev != nil {
                        if (i == self.array.count - 1) {//last one
                            make.right.equalTo(tempSuperView).offset(-tailSpacing);
                        } else {
                            let offset = (CGFloat(1) - (CGFloat(i) / CGFloat(self.array.count - 1))) *
                                (fixedItemLength + leadSpacing) -
                                CGFloat(i) * tailSpacing / CGFloat(self.array.count - 1)
                            make.right.equalTo(tempSuperView).multipliedBy(CGFloat(i) / CGFloat(self.array.count - 1)).offset(offset)
                        }
                    }else {//first one
                        make.left.equalTo(tempSuperView).offset(leadSpacing);
                    }
                })
                prev = v;
            }
        }else {
            var prev : ConstraintView?
            for (i, v) in self.array.enumerated() {
                v.snp.makeConstraints({ (make) in
                    make.height.equalTo(fixedItemLength)
                    if prev != nil {
                        if (i == self.array.count - 1) {//last one
                            make.bottom.equalTo(tempSuperView).offset(-tailSpacing);
                        }else {
                            let offset = (CGFloat(1) - (CGFloat(i) / CGFloat(self.array.count - 1))) *
                                (fixedItemLength + leadSpacing) -
                                CGFloat(i) * tailSpacing / CGFloat(self.array.count - 1)
                            make.bottom.equalTo(tempSuperView).multipliedBy(CGFloat(i) / CGFloat(self.array.count-1)).offset(offset)
                        }
                    }else {//first one
                        make.top.equalTo(tempSuperView).offset(leadSpacing);
                    }
                })
                prev = v;
            }
        }
    }
    
    /// distribute Sudoku with fixed item size
    ///
    /// - Parameters:
    ///   - fixedItemWidth: the fixed width of each item
    ///   - fixedItemLength: the fixed length of each item
    ///   - warpCount: the warp count in the super container
    ///   - edgeInset: the padding in the super container
    public func distributeSudokuViews(fixedItemWidth: CGFloat, fixedItemHeight: CGFloat, warpCount: Int, edgeInset: ConstraintEdgeInsets = .zero) {
        
        guard self.array.count > 1, warpCount >= 1, let tempSuperView = commonSuperviewOfViews() else {
            return
        }
        
        let remainder = self.array.count % warpCount
        let quotient = self.array.count / warpCount
        
        let rowCount = (remainder == 0) ? quotient : (quotient + 1)
        let columnCount = warpCount
        
        for (i,v) in self.array.enumerated() {
            
            let currentRow = i / warpCount
            let currentColumn = i % warpCount
            
            v.snp.makeConstraints({ (make) in
                make.width.equalTo(fixedItemWidth)
                make.height.equalTo(fixedItemHeight)
                if currentRow == 0 {//fisrt row
                    make.top.equalTo(tempSuperView).offset(edgeInset.top)
                }
                if currentRow == rowCount - 1 {//last row
                    make.bottom.equalTo(tempSuperView).offset(-edgeInset.bottom)
                }
                
                if currentRow != 0 && currentRow != rowCount - 1 {//other row
                    let offset = (CGFloat(1) - CGFloat(currentRow) / CGFloat(rowCount - 1)) *
                        (fixedItemHeight + edgeInset.top) -
                        CGFloat(currentRow) * edgeInset.bottom / CGFloat(rowCount - 1)
                    make.bottom.equalTo(tempSuperView).multipliedBy(CGFloat(currentRow) / CGFloat(rowCount - 1)).offset(offset);
                }
                
                if currentColumn == 0 {//first col
                    make.left.equalTo(tempSuperView).offset(edgeInset.left)
                }
                if currentColumn == columnCount - 1 {//last col
                    make.right.equalTo(tempSuperView).offset(-edgeInset.right)
                }
                
                if currentColumn != 0 && currentColumn != columnCount - 1 {//other col
                    let offset = (CGFloat(1) - CGFloat(currentColumn) / CGFloat(columnCount - 1)) *
                        (fixedItemWidth + edgeInset.left) -
                        CGFloat(currentColumn) * edgeInset.right / CGFloat(columnCount - 1)
                    make.right.equalTo(tempSuperView).multipliedBy(CGFloat(currentColumn) / CGFloat(columnCount - 1)).offset(offset);
                }
            })
        }
    }
    
    /// distribute Sudoku with fixed item spacing
    ///
    /// - Parameters:
    ///   - fixedLineSpacing: the line spacing between each item
    ///   - fixedInteritemSpacing: the Interitem spacing between each item
    ///   - warpCount: the warp count in the super container
    ///   - edgeInset: the padding in the super container
    public func distributeSudokuViews(fixedLineSpacing: CGFloat, fixedInteritemSpacing: CGFloat, warpCount: Int, edgeInset: ConstraintEdgeInsets = .zero) {
        
        guard self.array.count > 1, warpCount >= 1, let tempSuperView = commonSuperviewOfViews() else {
            return
        }
        
        let remainder = self.array.count % warpCount
        let quotient = self.array.count / warpCount
        
        let rowCount = (remainder == 0) ? quotient : (quotient + 1)
        let columnCount = warpCount
        
        
        var prev : ConstraintView?
        
        for (i,v) in self.array.enumerated() {
            
            let currentRow = i / warpCount
            let currentColumn = i % warpCount
            
            v.snp.makeConstraints({ (make) in
                guard let prev = prev else {//first row & first col
                    make.top.equalTo(tempSuperView).offset(edgeInset.top)
                    make.left.equalTo(tempSuperView).offset(edgeInset.left)
                    return
                }
                make.width.height.equalTo(prev)
                if currentRow == rowCount - 1 {//last row
                    if currentRow != 0 && i - columnCount >= 0 {//just one row
                        make.top.equalTo(self.array[i-columnCount].snp.bottom).offset(fixedLineSpacing)
                    }
                    make.bottom.equalTo(tempSuperView).offset(-edgeInset.bottom)
                }
                
                if currentRow != 0 && currentRow != rowCount - 1 {//other row
                    make.top.equalTo(self.array[i-columnCount].snp.bottom).offset(fixedLineSpacing);
                }
                if currentColumn == warpCount - 1 {//last col
                    if currentColumn != 0 {//just one line
                        make.left.equalTo(prev.snp.right).offset(fixedInteritemSpacing)
                    }
                    make.right.equalTo(tempSuperView).offset(-edgeInset.right)
                }
                
                if currentColumn != 0 && currentColumn != warpCount - 1 {//other col
                    make.left.equalTo(prev.snp.right).offset(fixedInteritemSpacing);
                }
            })
            prev = v
        }
    }
    
//   /////////////////只使用与label的简单竖排和横排
    public func distributeViewsAlongLeading(axisType:ConstraintAxis, fixedSpacing:CGFloat = 0, leadSpacing:CGFloat = 0,tailSpacing:CGFloat = 0) {
        
        guard self.array.count > 1, let tempSuperView = commonSuperviewOfViews() else {
            return
        }
        
        if axisType == .horizontal {
            var prev : ConstraintView?
            for (i, v) in self.array.enumerated() {
                v.sizeToFit()
                v.snp.makeConstraints({ (make) in
                    guard let prev = prev else {//first one
                        make.left.equalTo(tempSuperView).offset(leadSpacing)
                        make.right.lessThanOrEqualTo(tempSuperView).offset(tailSpacing)
                        return
                    }
                    if prev.right() + v.width() + fixedSpacing + fixedSpacing > tempSuperView.right() {
                        make.left.equalTo(tempSuperView).offset(leadSpacing)
                        make.top.equalTo(prev.snp.bottom).offset(fixedSpacing)
                        make.right.lessThanOrEqualTo(tempSuperView).offset(-tailSpacing)
                    }else{
                        make.top.equalTo(prev.snp.top)
                        make.left.equalTo(prev.snp.right).offset(fixedSpacing)
                        make.right.lessThanOrEqualTo(tempSuperView).offset(-tailSpacing)
                    }
                    
                })
                prev = v;
            }
        }else {
            var prev : ConstraintView?
            for (i, v) in self.array.enumerated() {
                v.snp.makeConstraints({ (make) in
                    guard let prev = prev else {//first one
                        make.top.equalTo(tempSuperView).offset(leadSpacing);
                        return
                    }
                    make.left.equalTo(tempSuperView).offset(leadSpacing)
                    make.top.equalTo(prev.snp.bottom).offset(fixedSpacing)
                    if (i == self.array.count - 1) {//last one
                        make.bottom.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                })
                prev = v;
            }
        }
    }
    /////   /////////////////只使用与label的简单竖排和横排
    public func distributeViewsAlongTraling(axisType:ConstraintAxis, fixedSpacing:CGFloat = 0, leadSpacing:CGFloat = 0, tailSpacing:CGFloat = 0) {
        
        guard self.array.count > 1, let tempSuperView = commonSuperviewOfViews() else {
            return
        }
        
        if axisType == .horizontal {
            var prev : ConstraintView?
            for (i, v) in self.array.reversed().enumerated() {
                v.snp.makeConstraints({ (make) in
                    guard let prev = prev else {//first one
                        make.left.equalTo(tempSuperView).offset(leadSpacing)
                        return
                    }
                    make.width.equalTo(prev)
                    make.left.equalTo(prev.snp.right).offset(fixedSpacing)
                    if (i == self.array.count - 1) {//last one
                        make.right.equalTo(tempSuperView).offset(-tailSpacing)
                    }
                })
                prev = v;
            }
        }else {
            var prev : ConstraintView?
            for (i, v) in self.array.enumerated() {
                v.snp.makeConstraints({ (make) in
                    guard let prev = prev else {//first one
                        make.top.equalTo(tempSuperView).offset(leadSpacing);
                        return
                    }
                    make.height.equalTo(prev)
                    make.top.equalTo(prev.snp.bottom).offset(fixedSpacing)
                    if (i == self.array.count - 1) {//last one
                        make.bottom.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                })
                prev = v;
            }
        }
    }
//    /// distribute with fixed item size
//    ///
//    /// - Parameters:
//    ///   - axisType: which axis to distribute items along
//    ///   - fixedItemLength: the fixed length of each item
//    ///   - leadSpacing: the spacing before the first item and the container
//    ///   - tailSpacing: the spacing after the last item and the container
//    public func distributeViewsAlong(axisType:ConstraintAxis, fixedItemLength:CGFloat = 0, leadSpacing:CGFloat = 0, tailSpacing:CGFloat = 0) {
//        
//        guard self.array.count > 1, let tempSuperView = commonSuperviewOfViews() else {
//            return
//        }
//        
//        if axisType == .horizontal {
//            var prev : ConstraintView?
//            for (i, v) in self.array.enumerated() {
//                v.snp.makeConstraints({ (make) in
//                    make.width.equalTo(fixedItemLength)
//                    if prev != nil {
//                        if (i == self.array.count - 1) {//last one
//                            make.right.equalTo(tempSuperView).offset(-tailSpacing);
//                        } else {
//                            let offset = (CGFloat(1) - (CGFloat(i) / CGFloat(self.array.count - 1))) *
//                                (fixedItemLength + leadSpacing) -
//                                CGFloat(i) * tailSpacing / CGFloat(self.array.count - 1)
//                            make.right.equalTo(tempSuperView).multipliedBy(CGFloat(i) / CGFloat(self.array.count - 1)).offset(offset)
//                        }
//                    }else {//first one
//                        make.left.equalTo(tempSuperView).offset(leadSpacing);
//                    }
//                })
//                prev = v;
//            }
//        }else {
//            var prev : ConstraintView?
//            for (i, v) in self.array.enumerated() {
//                v.snp.makeConstraints({ (make) in
//                    make.height.equalTo(fixedItemLength)
//                    if prev != nil {
//                        if (i == self.array.count - 1) {//last one
//                            make.bottom.equalTo(tempSuperView).offset(-tailSpacing);
//                        }else {
//                            let offset = (CGFloat(1) - (CGFloat(i) / CGFloat(self.array.count - 1))) *
//                                (fixedItemLength + leadSpacing) -
//                                CGFloat(i) * tailSpacing / CGFloat(self.array.count - 1)
//                            make.bottom.equalTo(tempSuperView).multipliedBy(CGFloat(i) / CGFloat(self.array.count-1)).offset(offset)
//                        }
//                    }else {//first one
//                        make.top.equalTo(tempSuperView).offset(leadSpacing);
//                    }
//                })
//                prev = v;
//            }
//        }
//    }
//    /////////////
    internal let array: Array<ConstraintView>
    
    internal init(array: Array<ConstraintView>) {
        self.array = array
    }
    
}

public extension Array {
    var snp: ConstraintArrayDSL {
        return ConstraintArrayDSL(array: self as! Array<ConstraintView>)
    }
}



private extension ConstraintArrayDSL {
    func commonSuperviewOfViews() -> ConstraintView? {
        var commonSuperview : ConstraintView?
        var previousView : ConstraintView?
        
        for view in self.array {
            if previousView != nil {
                commonSuperview = view.closestCommonSuperview(commonSuperview)
            }else {
                commonSuperview = view
            }
            previousView = view
        }
        
        return commonSuperview
    }
}

private extension ConstraintView {
    func closestCommonSuperview(_ view : ConstraintView?) -> ConstraintView? {
        var closestCommonSuperview: ConstraintView?
        var secondViewSuperview: ConstraintView? = view
        while closestCommonSuperview == nil && secondViewSuperview != nil {
            var firstViewSuperview: ConstraintView? = self
            while closestCommonSuperview == nil && firstViewSuperview != nil {
                if secondViewSuperview == firstViewSuperview {
                    closestCommonSuperview = secondViewSuperview
                }
                firstViewSuperview = firstViewSuperview?.superview
            }
            secondViewSuperview = secondViewSuperview?.superview
        }
        return closestCommonSuperview
    }
}
