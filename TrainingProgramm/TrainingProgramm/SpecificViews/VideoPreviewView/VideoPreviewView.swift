//
//  VideoPreviewView.swift
//  TrainingProgramm
//
//  Created by Vitali on 8/29/20.
//

import UIKit
import CommonViews

public protocol VideoPreviewViewDelegate: class {
    func videoPreviewViewDidTap(_ sender: VideoPreviewView)
}

@IBDesignable
public class VideoPreviewView: UIViewExtended {
    // MARK: - Views
    private weak var imageView: UIImageView!
    // MARK: - Properties
    weak var viewDelegate: VideoPreviewViewDelegate?
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initCommon()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initCommon()
    }
    
    private func initCommon() {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView = imageView
        addSubview(imageView)
        imageView.constraintAllSidesToSuperview()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(recognizer)
        let iconView = VidePreviewIconView()
        iconView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconView)
        iconView.constraintAllSidesToSuperview()
        
        cornerRadius = 10
    }
    
    // MARK: - Actions and Action Callbacks
    @objc
    private func handleTap() {
        viewDelegate?.videoPreviewViewDidTap(self)
    }
    
    // MARK: - Other
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        let ibImage = Asset.TrainingProgramm.SupportImages.trainingProgrammSupportImageVideoPreview.image
        image = ibImage
    }
}

@IBDesignable
private class VidePreviewIconView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCommon()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initCommon()
    }
    
    private func initCommon() {
        backgroundColor = .clear
    }
    
    // MARK: - Drawning Play Icon
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let radius = min(rect.width, rect.height) / 6
        let outlineRect = CGRect.fromCenter(rect.center, width: radius * 2, height: radius * 2)
        let path = UIBezierPath(ovalIn: outlineRect)
        UIColor.white.setStroke()
        path.stroke()
        let rightPointXOffset = radius * 0.4
        let topBottomLeftPointXOffset = -radius * 0.2
        let topLeftPointYOffset = -radius * 0.4
        let bottomLeftPointYOffset = radius * 0.4
        let topLeftPoint = CGPoint(x: rect.center.x + topBottomLeftPointXOffset,
                                   y: rect.center.y + topLeftPointYOffset)
        let bottomLeftPoint = CGPoint(x: rect.center.x + topBottomLeftPointXOffset,
                                      y: rect.center.y + bottomLeftPointYOffset)
        let rightPoint = CGPoint(x: rect.center.x + rightPointXOffset, y: rect.center.y)
        let trianglePath = UIBezierPath()
        trianglePath.move(to: topLeftPoint)
        trianglePath.addLine(to: rightPoint)
        trianglePath.addLine(to: bottomLeftPoint)
        trianglePath.addLine(to: topLeftPoint)
        trianglePath.stroke()
        trianglePath.close()
    }
}
