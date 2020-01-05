//
//  PageTitleView.swift
//  DYZB
//
//  Created by Smy_D on 2020/1/3.
//  Copyright © 2020 Smy_D. All rights reserved.
//

import UIKit

// 表示协议只能被类遵守，如果不写可能被结构体遵守，也可能被枚举遵守，就不能把代理属性定义为可选类型了
// MARK: - 定义协议
protocol PageTitleViewDelegate: class {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int)
}

// MARK: - 定义常量
private let kScrollLineH: CGFloat = 2
private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85) //灰色
private let kSelectColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)//橘色

// MARK: - 定义PageTitleView类
class PageTitleView: UIView {

    // MARK: - 定义属性
    private var currentIndex: Int = 0
    private var titles: [String]
    private var titleLabels: [UILabel] = [UILabel]()
    weak var delegate: PageTitleViewDelegate?
    
    // MARK: - 懒加载属性
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        return scrollView
    }()
    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    // MARK: - 自定义构造函数, 必须重写init(coder)
    init(frame: CGRect, titles:[String]) {
        self.titles = titles
        
        super.init(frame: frame)
        // 设置UI界面
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageTitleView {
    private func setupUI(){
        // 1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2.添加title对应的label
        setupTitleLabels()
        
        // 3.设置底线和滚动的滑块
        setupBottomMenuAndScrollLine()
    }
    
    private func setupTitleLabels(){
        for (index, title) in titles.enumerated() {
            
            // 0.确定label的一些frame值
            let labelY: CGFloat = 0
            let labelW: CGFloat = frame.width / CGFloat(titles.count)
            let labelH: CGFloat = frame.height - kScrollLineH
            
            // 1.创建UILabel
            let label = UILabel()
            
            // 2.设置UILabel的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = kRGBColor(kNormalColor.0, kNormalColor.1, kNormalColor.2)
            label.textAlignment = .center
            
            // 3.设置label的Frame
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 4.将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            // 5.给Label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
            
        }
    }
    
    private func setupBottomMenuAndScrollLine(){
        // 1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 2.添加scrollLine
        // 2.1获取第一个label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = kRGBColor(kSelectColor.0, kSelectColor.1, kSelectColor.2)
        // 2.2设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}


// MARK: - 监听Label的点击
extension PageTitleView {
    
    // 事件监听需要加上@objc
    @objc private func titleLabelClick(tapGes: UITapGestureRecognizer) {
     
        // 1.获取当前的label下标值
        guard let currentLabel = tapGes.view as? UILabel else {return}
        
        // 2.获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        // 3.保存最新的label下标值
        currentIndex = currentLabel.tag
        
        // 4.切换文字的颜色
        currentLabel.textColor = kRGBColor(kSelectColor.0, kSelectColor.1, kSelectColor.2)
        oldLabel.textColor = kRGBColor(kNormalColor.0, kNormalColor.1, kNormalColor.2)
        
        // 5.滚动条位置发生改变
        let scrollLineX = CGFloat(currentLabel.tag)*scrollLine.frame.width
        UIView.animate(withDuration: 0.15) { [weak self] in
            self?.scrollLine.frame.origin.x = scrollLineX
        }
        
        // 6.通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
    
}


// Mark: - 对外暴露的方法
extension PageTitleView {
    func setTitleWithProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int){
        // 1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 3.颜色的渐变
        // 3.1 取出变化的范围
        let colordelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        // 3.2 变化sourceLabel
        sourceLabel.textColor = kRGBColor(kSelectColor.0 - colordelta.0 * progress, kSelectColor.1 - colordelta.1 * progress, kSelectColor.2 - colordelta.2 * progress)
        // 3.2 变化targetLabel
        targetLabel.textColor = kRGBColor(kNormalColor.0 + colordelta.0 * progress, kNormalColor.1 + colordelta.1 * progress, kNormalColor.2 + colordelta.2 * progress)
        
        // 4.记录最新的 index
        currentIndex = targetIndex
    }
}
