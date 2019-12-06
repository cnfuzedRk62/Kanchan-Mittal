//
//  menuController.swift
//  MyDemo
//


import UIKit

class menuController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    var sections = ["","Supports","Share And Feedback",""]
    var sec1 = ["Motivational speech", "Gallery","Quotes","Appointment","Request For Prayer"]
    var sec2 = ["Get In touch", "Call Support"]
    var sec3 = ["Send Feedback","Rate us on App store", "Share app"]
    var sec4 = ["Pastor kanchan Mittal","About Ministers"]
    var sec1images : [UIImage] = [#imageLiteral(resourceName: "icProfileeColored"),#imageLiteral(resourceName: "gallery"),#imageLiteral(resourceName: "quote"),#imageLiteral(resourceName: "appointment"),#imageLiteral(resourceName: "Donation")]
    var sec2images : [UIImage] = [#imageLiteral(resourceName: "calling"),#imageLiteral(resourceName: "callsupport")]
    var sec3images : [UIImage] = [#imageLiteral(resourceName: "feedback-1"),#imageLiteral(resourceName: "review"),#imageLiteral(resourceName: "shareapp")]
    var sec4images : [UIImage] = [#imageLiteral(resourceName: "aboutkmm"),#imageLiteral(resourceName: "HomeSelected")]
    var navVc: UINavigationController?
     ///BaseView i.e Side Menu View
     var maximum_x = CGFloat()
     var blurView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = 45
        profileImage.clipsToBounds = true
        tableView.separatorStyle = .none
        self.maximum_x = self.view.frame.maxX
        AddPanGesture()
        self.registerXib()
    }
    func registerXib(){
         tableView.register(UINib(nibName: "SideOptionTableViewCell", bundle: nil), forCellReuseIdentifier: "SideOptionTableViewCell")
         tableView.tableFooterView = UIView()
    }
    func AddPanGesture() {
        //Observer to update Button Text to record
        let gesture : UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action:#selector(self.handlePanGesture(panGesture:)))
            self.view.addGestureRecognizer(gesture)
    }
    
    //MARK: Pan gesture Handler
    @objc func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        self.handleGesture(panGesture: panGesture)
    }
    
    func handleGesture(panGesture: UIPanGestureRecognizer) {
        //Get the changes
        let translation = panGesture.translation(in: self.view)
        //Make View move to left side of Frame
        if CGFloat(round(Double((panGesture.view?.frame.origin.x)!))) <= 0 {
            panGesture.view!.center = CGPoint(x: panGesture.view!.center.x + translation.x, y: panGesture.view!.center.y)
            panGesture.setTranslation(CGPoint.zero, in: self.view)
        }
        
        //Do not let View go beyond origin as 0
        if CGFloat(round(Double((panGesture.view?.frame.origin.x)!))) > 0 {
            panGesture.view?.frame.origin.x = 0
            panGesture.setTranslation(CGPoint.zero, in: self.view)
        }
        
        ///States When Dragging
        switch panGesture.state
        {
        case .changed:
            self.setAlphaOfBlurView(origin: (panGesture.view?.frame.maxX)!)
        case .ended:
            if CGFloat(round(Double((panGesture.view?.frame.maxX)!))) >= self.view.frame.size.width*0.75            {
                UIView.animate(withDuration: 0.7, animations: {
                    panGesture.view?.frame.origin.x = 0
                    panGesture.setTranslation(CGPoint.zero, in: self.view)
                })
            }
            else
            {
                UIView.animate(withDuration: 0.4, animations: {
                    panGesture.view?.frame.origin.x -= self.maximum_x
                    panGesture.setTranslation(CGPoint.zero, in: self.view)
                }, completion: { (success) in
                    if (success) {
                        self.dismissController()
                    }
                })
            }
            break
        default:
            print("Default Case")

        }
    }
    
    func setAlphaOfBlurView(origin : CGFloat)
    {
        if origin <= maximum_x {
            blurView.alpha = 0.5
        } else if origin > self.view.frame.size.width*0.7 {
            blurView.alpha = 0.3
        } else if origin > self.view.frame.size.width*0.5 {
            blurView.alpha = 0.0
        }

        ///Reload view
        blurView.setNeedsDisplay()
        
    }
    
    func dismissController() {
        self.blurView.alpha = 0
        dismiss(animated: true, completion: nil)
    }
   
}
extension menuController: UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        switch section {
        case 0:
            return sec1.count
        case 1:
             return sec2.count
        case 2:
             return sec3.count
        default:
            return sec4.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideOptionTableViewCell", for: indexPath) as! SideOptionTableViewCell
        
        switch indexPath.section {
        case 0:
            cell.sideLable.text = sec1[indexPath.row]
            cell.sideimageView.image = sec1images[indexPath.row]
        case 1:
            cell.sideLable.text = sec2[indexPath.row]
            cell.sideimageView.image = sec2images[indexPath.row]
        case 2:
            cell.sideLable.text = sec3[indexPath.row]
            cell.sideimageView.image = sec3images[indexPath.row]
        default:
            cell.sideLable.text = sec4[indexPath.row]
            cell.sideimageView.image = sec4images[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        let view = UIView()
        let label = UILabel()
        let underLineVIew = UIView()
        label.frame = CGRect(x: 20, y: 0, width: 500, height: 35)
        underLineVIew.backgroundColor = UIColor.lightGray
        underLineVIew.frame = CGRect(x: 20, y: 0, width: self.tableView.frame.width, height: 1)
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        label.textColor = UIColor.gray
        label.text = self.sections[section]
        view.addSubview(label)
        view.addSubview(underLineVIew)
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0.1
        case 1 :
            return 40
        case 2 :
            return 40
        default:
            return 0.1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
            
        case 0:
            switch indexPath.row {
            case 0:
                
                let object = self.storyboard?.instantiateViewController(withIdentifier: "SpeechersViewController") as! SpeechersViewController
                self.dismiss(animated: true, completion: {
                    self.navVc?.pushViewController(object, animated: true)
                })
            case 1:
               let object = self.storyboard?.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
                        self.dismiss(animated: true, completion: {
                        self.navVc?.pushViewController(object, animated: true)
                   })
            case 2:
                let object = self.storyboard?.instantiateViewController(withIdentifier: "QuetesViewController") as! QuetesViewController
                   self.dismiss(animated: true, completion: {
                       self.navVc?.pushViewController(object, animated: true)
                   })
            case 3:
                let object = self.storyboard?.instantiateViewController(withIdentifier: "BookAppointMentViewController") as! BookAppointMentViewController
                     self.dismiss(animated: true, completion: {
                         self.navVc?.pushViewController(object, animated: true)
                     })
            default:
                  let object = self.storyboard?.instantiateViewController(withIdentifier: "RequestPrayerViewController") as! RequestPrayerViewController
                self.dismiss(animated: true, completion: {
                    self.navVc?.pushViewController(object, animated: true)
                })
            }
            
        case 1:
          switch indexPath.row {
          case 0:
            let object = self.storyboard?.instantiateViewController(withIdentifier: "GetinTouchViewController") as! GetinTouchViewController
                     self.dismiss(animated: true, completion: {
                         self.navVc?.pushViewController(object, animated: true)
            })
        
          default:
            print("Call support")
            self.callNumber(phoneNumber: "+917710353800")
    }
      
        case 2 :
        
            switch indexPath.row {
            case 0:
                 let object = self.storyboard?.instantiateViewController(withIdentifier: "SendFeedBackViewController") as! SendFeedBackViewController
                         self.dismiss(animated: true, completion: {
                             self.navVc?.pushViewController(object, animated: true)
                })
            case 1:
                print("Rate us on")
            default:
                  let object = self.storyboard?.instantiateViewController(withIdentifier: "ShareAppViewController") as! ShareAppViewController
                         self.dismiss(animated: true, completion: {
                             self.navVc?.pushViewController(object, animated: true)
                })
            }
            
        case 3 :
            
        switch indexPath.row {
            case 0:
              let object = self.storyboard?.instantiateViewController(withIdentifier: "PaosterVC") as! PaosterVC
                       self.dismiss(animated: true, completion: {
                           self.navVc?.pushViewController(object, animated: true)
              })
  
          default:
                let object = self.storyboard?.instantiateViewController(withIdentifier: "PaosterVC") as! PaosterVC
               object.checkAbout = true
                            self.dismiss(animated: true, completion: {
                                self.navVc?.pushViewController(object, animated: true)
                   })
          }
      
        default:
            print("GGGG")
        }
        
        
    }
    
    private func callNumber(phoneNumber:String) {

        if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {

            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                     application.openURL(phoneCallURL as URL)

                }
            }
        }
    }
    
}
