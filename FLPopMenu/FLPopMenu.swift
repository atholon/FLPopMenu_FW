//
//  File.swift
//  FLPopMenu
//
//  Created by Atholon on 2018/1/25.
//  Copyright © 2018年 Atholon. All rights reserved.
//


// 存在问题：
//


import Foundation
import UIKit

// MARK: - 默认设置全局变量 ///////////////////////////////////////////////////////

/// 主题颜色
let gTintColor:UIColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
/// 阴影颜色
let gShadowColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
/// 文字颜色
let gTextColor:UIColor = UIColor.black
/// 字体大小
let gTextFontSize:CGFloat = 18.0
/// 文字对齐方式
let gAlignment:NSTextAlignment = .left
/// 垂直边距
let gVMargin:CGFloat = 10.0
/// 水平边距
let gLMargin:CGFloat = 17.0
/// 圆角半径
let gCornerRadius:CGFloat = 4.0
/// 箭头大小
let gArrowSize:CGFloat = 8.0
/// 是否阴影
let gHasShadow:Bool = true
/// 箭头方向
let gArrowDirection:FLMenuViewArrowDirection = .down
/// 分割线颜色
let gSeparatorColor:UIColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)
/// 背景效果
let gBackgrounColorEffect:FLMenuBackgrounColorEffect = .solid

/// 背景效果枚举
public enum FLMenuBackgrounColorEffect {
    ///<背景显示效果-纯色
    case solid
    ///<背景显示效果-渐变叠加>
    case Gradient
}

///箭头方向枚举
public enum FLMenuViewArrowDirection{
    case up
    case down
    case left
    case right
    case none
}









// MARK: - 接口层:FLPopMenu类/////////////////////////////////////////////////////

/// 用户接口类，含有单实例 .shared ，各项静态属性供用户修改，使用 show 函数显示菜单。
public class FLPopMenu:NSObject{
    // 单例对象
    public static var shared = FLPopMenu()
    // 菜单 menuView 实例
    var menuView:FLMenuView?
    // 是否被监听
    var isObserving = false
    // 视图当前是否显示
    var isShow:Bool = false
    
    // 主题颜色
    public static var tintColor:UIColor = gTintColor
    // 阴影颜色
    public static var shadowColor = gShadowColor
    // 文字颜色
    public static var textColor:UIColor = gTextColor
    // 标题字体
    public static var textFont:UIFont = UIFont.systemFont(ofSize: gTextFontSize)
    // 文字对齐方式
    public static var alignment:NSTextAlignment = gAlignment
    // 圆角尺寸
    public static var cornerRadius:CGFloat = gCornerRadius
    // 箭头尺寸
    public static var arrowSize:CGFloat = gArrowSize
    // 箭头方向
    public static var arrowDirection:FLMenuViewArrowDirection = gArrowDirection
    // 垂直边距
    public static var vMargin:CGFloat = gVMargin
    // 水平边距
    public static var lMargin:CGFloat = gLMargin
    // 背景效果
    public static var backgrounColorEffect:FLMenuBackgrounColorEffect = gBackgrounColorEffect
    // 是否显示阴影
    public static var hasShadow:Bool = gHasShadow
    // 选中颜色
    //var selectedColor:UIColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
    // 分割线颜色
    public static var separatorColor:UIColor = gSeparatorColor
    
    
    // 菜单元素垂直方向上的边距值
    //var menuItemMarginY:CGFloat = 12.0
    
    
    // MARK: - 构造，析构函数//////////////////////////////////////////
    
    // 构造函数（单例类，设置为private）
    //    private override init(){
    //        print("PopMenu被创建")
    //    }
    
    // 析构函数
    //    deinit{
    //        print("注销PopMenu")
    //    }
    
    // MARK: - 接口函数/////////////////////////////////////////////
    
    /// 显示PopMenu（view：添加菜单的页面的 view 对象；fromRect：箭头所指向的矩形；items：菜单项数组；animated：是否动画效果）
    public func show(withIN view:UIView,fromRect rect:CGRect,items:[FLMenuItem],animated:Bool = true){
        //        if menuView != nil {
        //            menuView?.dismissMenu(animated: false)
        //            menuView = nil
        //        }
        
        //        if !isObserving {
        //            isObserving = true
        //            NotificationCenter.default.addObserver(self, selector: #selector(orientationWillChange), name: NSNotification.Name.UIApplicationWillChangeStatusBarOrientation, object: nil)
        //        }
        
        // 添加menuItems
        addItems(items: items)
        // 调用menuView的函数，显示菜单
        menuView?.showMenuInView(view: view, fromRect: rect,animated:animated)
        self.isShow = true
        
    }
    
    
    
    
    // MARK: - 私有函数///////////////////////////////////////////////
    
    // 向Menu中添加Item
    func addItems (items:[FLMenuItem]) {
        //print("向Menu中添加项目（\(items.count)个项目）")
        // 如果menuView不是nil，说明菜单正在显示，取消之。
        if menuView != nil {
            menuView?.dismissMenu(animated: false)
            menuView = nil
        }
        // 建立新的实例
        menuView = FLMenuView()
        // 添加菜单项
        menuView?.addItems(items: items)
        //print("添加成功")
        //print(menuView?.contentView?.frame)
    }
    
    
    /// 将PopMenu的各项属性重置为默认值
    class func reset(){
        FLPopMenu.tintColor = gTintColor
        FLPopMenu.shadowColor = gShadowColor
        FLPopMenu.textColor = gTextColor
        FLPopMenu.textFont = UIFont.systemFont(ofSize: gTextFontSize)
        FLPopMenu.alignment = gAlignment
        FLPopMenu.cornerRadius = gCornerRadius
        FLPopMenu.arrowSize = gArrowSize
        FLPopMenu.arrowDirection = gArrowDirection
        FLPopMenu.vMargin = gVMargin
        FLPopMenu.lMargin = gLMargin
        FLPopMenu.backgrounColorEffect = gBackgrounColorEffect
        FLPopMenu.hasShadow = gHasShadow
        FLPopMenu.separatorColor = gSeparatorColor
    }
    
    
    // 清除弹出菜单
    func dismissMenu(animated:Bool = true){
        if menuView != nil {
            menuView?.dismissMenu(animated: animated)
            menuView = nil
        }
        
        self.isShow = false
    }
    
    @objc func performAction(sender:Any?){
        //self.dismissMenu(animated: true)
        // 获取按钮的 target 和 action
        let btn = sender as! UIButton
        let target = menuView?.menuItems[btn.tag].target as AnyObject
        let action = menuView?.menuItems[btn.tag].action
        // 清除弹出菜单
        dismissMenu(animated: false)
        // 如果有相应的处理函数，发送消息
        if  target.responds(to: action) {
            target.performSelector(onMainThread: action!, with: self, waitUntilDone: false)
            //target.perform( action!, with: self)
        }
        
    }
    
    // MARK: - 监听///////////////////////////////////////////////////
    
    /// 监听到横竖屏事件后取消菜单显示
    @objc func orientationWillChange(notification:Notification) {
        dismissMenu(animated: false)
    }
    
    
    
}

