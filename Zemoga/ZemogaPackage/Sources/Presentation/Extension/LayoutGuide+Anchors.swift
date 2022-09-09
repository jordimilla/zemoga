import UIKit

extension UILayoutGuide {
    
    @discardableResult
    public func fillView(with view: UIView,
                         topConstant: CGFloat = 0,
                         leftConstant: CGFloat = 0,
                         bottomConstant: CGFloat = 0,
                         rightConstant: CGFloat = 0,
                         active: Bool = true) -> [NSLayoutConstraint] {
        return anchor(top: view.topAnchor,
                      left: view.leftAnchor,
                      bottom: view.bottomAnchor,
                      right: view.rightAnchor,
                      topConstant: topConstant,
                      leftConstant: leftConstant,
                      bottomConstant: bottomConstant,
                      rightConstant: rightConstant,
                      active: active)
    }
    
    @discardableResult
    public func proportionWidthToView(_ view: UIView, multiplier: CGFloat, active: Bool = true) -> [NSLayoutConstraint] {
        let constraint = widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier)
        constraint.isActive = active
        
        return [constraint]
    }
    
    @discardableResult
    public func proportionHeightToView(_ view: UIView, multiplier: CGFloat, active: Bool = true) -> [NSLayoutConstraint] {
        let constraint = heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier)
        constraint.isActive = active
        
        return [constraint]
    }
    
    @discardableResult
    public func anchor(top: NSLayoutYAxisAnchor? = nil,
                       left: NSLayoutXAxisAnchor? = nil,
                       bottom: NSLayoutYAxisAnchor? = nil,
                       right: NSLayoutXAxisAnchor? = nil,
                       topConstant: CGFloat = 0,
                       leftConstant: CGFloat = 0,
                       bottomConstant: CGFloat = 0,
                       rightConstant: CGFloat = 0,
                       width: NSLayoutDimension? = nil,
                       height: NSLayoutDimension? = nil,
                       widthConstant: CGFloat = 0,
                       heightConstant: CGFloat = 0,
                       widthMultiplier: CGFloat = 1.0,
                       heightMultiplier: CGFloat = 1.0,
                       active: Bool = true) -> [NSLayoutConstraint] {
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if let width = width {
            anchors.append(widthAnchor.constraint(equalTo: width, multiplier: widthMultiplier))
        }
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if let height = height {
            anchors.append(heightAnchor.constraint(equalTo: height, multiplier: heightMultiplier))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = active})
        
        return anchors
    }
    
    @discardableResult
    public func anchorCenterYToView(view: UIView, constant: CGFloat = 0, active: Bool = true) -> [NSLayoutConstraint] {
        let constraint = centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
        constraint.isActive = active
        
        return [constraint]
    }
    
    @discardableResult
    public func anchorCenterXToView(view: UIView, constant: CGFloat = 0, active: Bool = true) -> [NSLayoutConstraint] {
        let constraint = centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant)
        constraint.isActive = active
        
        return [constraint]
    }
    
    @discardableResult
    public func anchorCenterToView(_ view: UIView,
                                   constantX: CGFloat = 0,
                                   constantY: CGFloat = 0,
                                   active: Bool = true) -> [NSLayoutConstraint] {
        var anchors = [NSLayoutConstraint]()
        
        anchors +=  anchorCenterXToView(view: view, constant: constantX, active: active)
        anchors +=  anchorCenterYToView(view: view, constant: constantY, active: active)
        
        return anchors
    }
    
    @discardableResult
    public func equalWidthToHeight(multiplier: CGFloat = 1.0, active: Bool = true) -> [NSLayoutConstraint] {
        let constraint = widthAnchor.constraint(equalTo: heightAnchor, multiplier: multiplier)
        constraint.isActive = active
        
        return [constraint]
    }
    
    @discardableResult
    public func equalHeightToWidth(multiplier: CGFloat = 1.0, active: Bool = true) -> [NSLayoutConstraint] {
        let constraint = heightAnchor.constraint(equalTo: widthAnchor, multiplier: multiplier)
        constraint.isActive = active
        
        return [constraint]
    }
}
