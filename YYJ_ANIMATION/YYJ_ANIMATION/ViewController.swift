//
//  ViewController.swift
//  YYJ_ANIMATION
//
//  Created by yoon-yeoungjin on 2022/10/30.
//

import UIKit

let duration = 1.5

class ViewController: UIViewController {

    @IBOutlet weak var animationTableView: UITableView!
    
    let animationCategoryList: [String] = ["2-Color", "Simple 2D Rotation", "Multicolor", "Multi Point Position", "BezierCurve Position", "Color and Frame Change", "View Fade in", "Pop"]
    override func viewDidLoad() {
        super.viewDidLoad()
        animationTableView.dataSource = self
        animationTableView.delegate = self
        let nib = UINib(nibName: "AnimationTableViewCell", bundle: nil)
        animationTableView.register(nib, forCellReuseIdentifier: "AnimationTableViewCell")
        self.title = "Animations"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
    }
    
    func animateTable(){
        animationTableView.reloadData()
        
        let cells = animationTableView.visibleCells
        let tableHeight = animationTableView.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        for cell in cells {
            UIView.animate(withDuration: duration, delay: 0.05 * Double(index),usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: []) {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            index += 1
        }
    }
    
    /* segue 에 등록한 storyboard 에 데이터를 전달한다. */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AnimationViewController, let indexPath = animationTableView.indexPathForSelectedRow {
            destination.animationTitite = animationCategoryList[indexPath.row]
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animationCategoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimationTableViewCell", for: indexPath) as! AnimationTableViewCell
        cell.animationTitle.text = animationCategoryList[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.title = animationCategoryList[indexPath.row]
        performSegue(withIdentifier: "showAnimation", sender: nil)
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Basic Animations"
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}
