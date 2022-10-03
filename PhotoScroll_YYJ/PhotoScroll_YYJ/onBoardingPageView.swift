import UIKit

class OnBoardingPageView: UIPageViewController {
    
    var pages = [UIViewController]()
    var bottomButton: NSLayoutConstraint?  // 버튼 관련 클래스 호출
    var pageControll = UIPageControl()      // 페이지 컨드롤러 호출
    var currentIndex = 0 {                  // currentIndex가 변할때마다 pageControll.currentPage 값을 변경
        didSet{
            pageControll.currentPage = currentIndex
            print(currentIndex)
        }
    }
    
    /**
     각 페이지를 호출 및 셋팅
     */
    func makeView(){
        let itemVC1 = OnBoardingViewController.init(nibName: "OnBoardingViewController", bundle: nil)
        itemVC1.mainLabelText = "첫번째 페이지 입니다."
        itemVC1.subLabelText = "해당 페이지는 첫번째 페이지로 셋팅되어있습니다. 아아아ㅏ아아ㅏ아아ㅏ아아ㅏ아ㅏ아아ㅏ"
        itemVC1.imageNameText = UIImage(named: "onboarding1")
        
        let itemVC2 = OnBoardingViewController.init(nibName: "OnBoardingViewController", bundle: nil)
        itemVC2.mainLabelText = "두번째 페이지 입니다."
        itemVC2.subLabelText = "해당 페이지는 두번째 페이지로 셋팅되어있습니다. 아아아ㅏ아아ㅏ아아ㅏ아아ㅏ아ㅏ아아ㅏ"
        itemVC2.imageNameText = UIImage(named: "onboarding2")
        
        let itemVC3 = OnBoardingViewController.init(nibName: "OnBoardingViewController", bundle: nil)
        itemVC3.mainLabelText = "세번째 페이지 입니다."
        itemVC3.subLabelText = "해당 페이지는 세번째 페이지로 셋팅되어있습니다. 아아아ㅏ아아ㅏ아아ㅏ아아ㅏ아ㅏ아아ㅏ"
        itemVC3.imageNameText = UIImage(named: "onboarding3")
        
        pages.append(itemVC1)
        pages.append(itemVC2)
        pages.append(itemVC3)
        
        setViewControllers([itemVC1], direction: .forward, animated: true, completion: nil)
        
        self.dataSource = self
        self.delegate = self
    }
    
    /**
     버튼 셋팅
     */
    func makeButton() {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(dismissPage), for: .touchUpInside)
        
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        button.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        bottomButton = button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        bottomButton?.isActive = true
        
        hideButton()
    }
    
    /**
     페이지 컨트롤러 셋팅
     */
    func makeControll() {
        self.view.addSubview(pageControll)
        
        pageControll.translatesAutoresizingMaskIntoConstraints = false
        pageControll.currentPageIndicatorTintColor = .black
        pageControll.pageIndicatorTintColor = .lightGray
        pageControll.numberOfPages = pages.count
        pageControll.currentPage = currentIndex
        
        pageControll.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -80).isActive = true
        pageControll.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        pageControll.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
    }
    
    /**
     페이지 컨르롤러의 해당 페이지 Index를 클릭하면 해당 페이지로 이동하게 하는 함수
     */
    @objc func pageControlTapped(sender: UIPageControl) {
        self.setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
    
    @objc func dismissPage(){
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeView()
        makeButton()
        makeControll()
    }
}

/**
 페이지 전환에 대해서 확장 선언
 */
extension OnBoardingPageView: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        self.currentIndex = currentIndex
        
        if currentIndex == 0 {
            return pages.last
        }
        
        return pages[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        self.currentIndex = currentIndex
        
        if currentIndex == pages.count - 1 {
            return pages.first
        }
            
        return pages[currentIndex + 1]
    }
}

/**
 확인 버튼을 마지막 페이지에서만 보이게끔 개발
 */
extension OnBoardingPageView: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        guard let currentVC = pageViewController.viewControllers?.first else {
            return
        }
        guard let currentIndex = pages.firstIndex(of: currentVC) else {
            return
        }
        
        if currentIndex == pages.count - 1{
            self.showButton()
        } else {
            self.hideButton()
        }
        
        UIView.animate(withDuration: 0.25){
            self.view.layoutIfNeeded()
        }
    }
    
    func showButton() {
        bottomButton?.constant = 0
    }
    
    func hideButton() {
        bottomButton?.constant = 100
    }
    
}
