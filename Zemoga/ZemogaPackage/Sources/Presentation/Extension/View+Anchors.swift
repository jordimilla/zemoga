import UIKit

extension UIView {
    
    @discardableResult
    public func fillView(with view: UIView,
                         topConstant: CGFloat = 0,
                         leftConstant: CGFloat = 0,
                         bottomConstant: CGFloat = 0,
                         rightConstant: CGFloat = 0,
                         widthConstant: CGFloat = 0,
                         heightConstant: CGFloat = 0,
                         active: Bool = true) -> [NSLayoutConstraint] {
        return anchor(top: view.topAnchor,
                      left: view.leftAnchor,
                      bottom: view.bottomAnchor,
                      right: view.rightAnchor,
                      topConstant: topConstant,
                      leftConstant: leftConstant,
                      bottomConstant: bottomConstant,
                      rightConstant: rightConstant,
                      widthConstant: widthConstant,
                      heightConstant: heightConstant,
                      active: active
        )
    }
    
    @discardableResult
    public func fillSuperview(topConstant: CGFloat = 0,
                              leftConstant: CGFloat = 0,
                              bottomConstant: CGFloat = 0,
                              rightConstant: CGFloat = 0,
                              widthConstant: CGFloat = 0,
                              heightConstant: CGFloat = 0,
                              active: Bool = true) -> [NSLayoutConstraint] {
        
        if let superview = superview {
            return fillView(with: superview,
                            topConstant: topConstant,
                            leftConstant: leftConstant,
                            bottomConstant: bottomConstant,
                            rightConstant: rightConstant,
                            widthConstant: widthConstant,
                            heightConstant: heightConstant,
                            active: active
            )
        }
        return [NSLayoutConstraint]()
    }
    
    @discardableResult
    public func proportionWidthToSuperView(multiplier: CGFloat, active: Bool = true) -> [NSLayoutConstraint] {
        if let superview = superview {
            return proportionWidthToView(superview, multiplier: multiplier, active: active)
        }
        return [NSLayoutConstraint]()
    }
    
    @discardableResult
    public func proportionHeightToSuperView(multiplier: CGFloat, active: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            return proportionHeightToView(superview, multiplier: multiplier, active: active)
        }
        return [NSLayoutConstraint]()
    }
    
    @discardableResult
    public func proportionWidthToView(_ view: UIView, multiplier: CGFloat, active: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier)
        constraint.isActive = active
        
        return [constraint]
    }
    
    @discardableResult
    public func proportionHeightToView(_ view: UIView, multiplier: CGFloat, active: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
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
                       centerX: NSLayoutXAxisAnchor? = nil,
                       centerY: NSLayoutYAxisAnchor? = nil,
                       active: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
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
        
        if let centerX = centerX {
            anchors.append(centerXAnchor.constraint(equalTo: centerX))
        }
        
        if let centerY = centerY {
            anchors.append(centerYAnchor.constraint(equalTo: centerY))
        }
        
        anchors.forEach({$0.isActive = active})
        
        return anchors
    }
    
    @discardableResult
    public func anchorCenterXToSuperview(constant: CGFloat = 0, active: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            return anchorCenterXToView(superview, constant: constant, active: active)
        }
        return [NSLayoutConstraint]()
    }
    
    @discardableResult
    public func anchorCenterYToSuperview(constant: CGFloat = 0, active: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            return anchorCenterYToView(superview, constant: constant, active: active)
        }
        return [NSLayoutConstraint]()
    }
    
    @discardableResult
    public func anchorCenterYToView(_ view: UIView, constant: CGFloat = 0, active: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
        constraint.isActive = active
        
        return [constraint]
    }
    
    @discardableResult
    public func anchorCenterYToView(_ view: UILayoutGuide, constant: CGFloat = 0, active: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
        constraint.isActive = active
        
        return [constraint]
    }
    
    @discardableResult
    public func anchorCenterYView(relativeTo view: UIView,
                                  multiplier: CGFloat = 1.0,
                                  constant: CGFloat = 0,
                                  active: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: multiplier, constant: constant)
        constraint.isActive = active
        
        return [constraint]
    }
    
    @discardableResult
    public func anchorCenterXToView(_ view: UIView, constant: CGFloat = 0, active: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant)
        constraint.isActive = active
        
        return [constraint]
    }
    
    @discardableResult
    public func anchorCenterXToView(_ view: UILayoutGuide, constant: CGFloat = 0, active: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
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
        
        anchors +=  anchorCenterXToView(view, constant: constantX, active: active)
        anchors +=  anchorCenterYToView(view, constant: constantY, active: active)
        
        return anchors
    }
    
    @discardableResult
    public func anchorCenterToView(_ view: UILayoutGuide,
                                   constantX: CGFloat = 0,
                                   constantY: CGFloat = 0,
                                   active: Bool = true) -> [NSLayoutConstraint] {
        var anchors = [NSLayoutConstraint]()
        
        anchors +=  anchorCenterXToView(view, constant: constantX, active: active)
        anchors +=  anchorCenterYToView(view, constant: constantY, active: active)
        
        return anchors
    }
    
    @discardableResult
    public func anchorCenterSuperview(constantX: CGFloat = 0,
                                      constantY: CGFloat = 0,
                                      active: Bool = true) -> [NSLayoutConstraint] {
        var anchors = [NSLayoutConstraint]()
        
        if let superview = superview {
            anchors +=  anchorCenterXToView(superview, constant: constantX, active: active)
            anchors +=  anchorCenterYToView(superview, constant: constantY, active: active)
        }
        return anchors
    }
    
    @discardableResult
    public func equalWidthToHeight(multiplier: CGFloat = 1.0, active: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(equalTo: heightAnchor, multiplier: multiplier)
        constraint.isActive = active
        
        return [constraint]
    }
    
    @discardableResult
    public func equalHeightToWidth(multiplier: CGFloat = 1.0, active: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = heightAnchor.constraint(equalTo: widthAnchor, multiplier: multiplier)
        constraint.isActive = active
        
        return [constraint]
    }
    
    @discardableResult
    public func anchorBottomPriority(bottom: NSLayoutYAxisAnchor,
                                     priority: UILayoutPriority,
                                     constant: CGFloat = 0,
                                     active: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = bottomAnchor.constraint(equalTo: bottom, constant: constant)
        constraint.priority = .defaultHigh
        constraint.isActive = active
        
        return [constraint]
    }
}
