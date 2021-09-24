## SpringEffectSlidingView
* [General info](#general-info)
* [Technologies](#technologies)
* [Usage](#usage)
* [Animation](#animation)

## General info
The view enables user to drag the view to given point with a curvy sliding effect. Far the point, more is the curve in the animation.
	
## Technologies
Project is created with:
* Xcode : 12
* IOS version: 14
	
## Usage
To run the animation on any view use the following code 

### From Storyboard

Change class of view to *SpringEffectUIView*

![Screenshot 2021-09-24 at 11 50 27 AM](https://user-images.githubusercontent.com/16226329/134627691-e3dc4998-45b8-4700-b981-6a493cbaaefc.png)

Also you can change the background color and sliding view color from storyboard

![Screenshot 2021-09-24 at 11 50 33 AM](https://user-images.githubusercontent.com/16226329/134627804-1672d9e0-47a0-4758-91a8-1680a64d85be.png)

### From Code

```
    var springEffectView : SpringEffectUIView!
    @IBOutlet weak var containerView: UIView!
    func viewDidLoad() {
        super.viewDidLoad()
        springEffectView = SpringEffectUIView.init(frame: .init(x: 0, y: 0, width: self.containerView.frame.width, height: self.containerView.frame.height))
        self.containerView.addSubview(springEffectView)
    }

```

To slide to given point

```
springEffectView.slideTo(distance: 20)
```

## Animation


![ezgif-7-65e17ee39bf8](https://user-images.githubusercontent.com/16226329/134628257-f63333d4-4739-4ba5-bfaf-01b4cb0339ce.gif)



<!---
HimanDhawan/HimanDhawan is a ✨ special ✨ repository because its `README.md` (this file) appears on your GitHub profile.
You can click the Preview link to take a look at your changes.
--->
