


import Foundation
import UIKit


// MARK: - 基层:Overlay类，覆盖全屏，提供点击取消菜单功能


/// 基层：Overlay类，覆盖全屏，提供点击取消菜单功能
class FLMenuOverlay:UIView{
    override init(frame:CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.isOpaque = false
        // 添加点击手势，调用dismissMenu取消菜单
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(singleTap))
        self.addGestureRecognizer(gestureRecognizer)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(singleTap))
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("OverlayView被注销！")
    }
    
    /// 单击响应，调用shared单例的dismissMenu来取消菜单显示。
    @objc func singleTap(recognizer:UITapGestureRecognizer){
        //        for view in self.subviews{
        //            if view.isKind(of: FLMenuView.self) && view.responds(to: #selector(FLMenuView.dismissMenu)){
        //                view.perform(#selector(FLMenuView.dismissMenu), with: true)
        //            }
        //        }
        FLPopMenu.shared.dismissMenu(animated: true)
    }
    
}


