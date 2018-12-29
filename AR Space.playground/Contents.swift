//#-hidden-code
//  Created by Steven Tan on 2/4/18.
//  Email Address: steven.tanwengfoo@gmail.com
//  Copyright © 2018 Steven Tan. All rights reserved.

import ARKit
import UIKit
import PlaygroundSupport
import SceneKit

//#-end-hidden-code
//#-editable-code
//: ![](solarSystem1.png)
//: ## Hey!
/*:
 
 My name is Steven and I currently live in Malaysia.
 
 I have many hobbies, but two that I really love: Coding and Astronomy.
 
 Astronomy is an uncommon topic these days and not many people are into it, espcially in my country.
 
 With this playground, I hope I would be able to bring more people into it. So today, we will be using Augmented Reality to explore Space in our own rooms.
 
 You will be introduced to a few critical concepts in Astronomy. Let's see how many you can pick up.
 
 - important:
 For best experience, make sure there is enough lighting for the camera to recognize objects in your surrounding. I would also encourage you to get into a bigger room for a more immersive experience.\
 \
 After that, try continue running the playground but with the camera covered and be amazed :D\
 \
 Now tap on the screen for the camera to focus on an object
 
 You will also notice that the planets start the rotation on the same line (x-axis), that's intentional to demonstrate the concept of orbital speed. Given enough time, it will evolve gradually to simulate an actual solar system.
 
 Natural satellites of Earth and Mars have also been included. Have a close at them by walking to Earth and Mars respectively.
 
 Explore by walking to the furthest planets and back, experience it yourself.
 
 */

//: ![](solarSystem5.png)

/*:
 
 In this playground, we will be using a relative scale for setting the planets' sizes using a range from 0 to 1 which would generally be enough.
 
 >I have only included from Sun-Mercury-Venus-Earth-Mars to be in our simulated Solar System (excl. natural satellites), as too many of them may compromise the learning experience, unless a larger physcial space is available.
 
 >I am only an enthusiast, not an astronomical expert, my apologies if the reference sheets for distance and sizes provided below are inaccurate.
 
 - important:
 Here's a cheat sheet for the radius of each planet :P\
 -Sun - 695,700 km\
 -Mercury - 2,440 km\
 -Venus - 6,052 km\
 -Earth - 6,371 km\
 -Mars - 3,390 km\
 -Moon - 1,737 km\
 -Phobos - 11 km\
 -Deimos - 6 km
 
 */

var sunSize:CGFloat = 0.85
var mercurySize:CGFloat = 0.30
var venusSize:CGFloat = 0.65
var earthSize:CGFloat = 0.65
var marsSize:CGFloat = 0.30
var moonSize:CGFloat = 0.20
var phobosSize:CGFloat = 0.10
var deimosSize:CGFloat = 0.10



//: ## Up next
/*:
 
 We will continue by setting how fast each planet can rotate. A higher rotational speed would result in shorter duration for one complete rotation around its axis of rotation.
 
 - important:
 Average Orbital Speed of Each Planet around its Centre of Mass:\
 -Sun - 1.997 km/h\
 -Mercury - 10.892 km/h\
 -Venus - 6.52 km/h\
 -Earth - 107,220 km/h\
 -Mars - 105,300 km/h\
 -Moon - 3600 km/h\
 -Phobos - 7.2 km/h\
 -Deimos - 1.3 km/h
 
 */

var sunDuration = 5
var mercuryDuration = 5
var venusDuration = 8
var earthDuration = 2
var marsDuration = 3
var moonDuration = 4
var phobosDuration = 6
var deimosDuration = 4

//: ![](solarSystem2.png)
//: ## Revolving around the Sun

/*:
 
 Also not forgetting, each planet orbit around the sun at a different speed. So, we will implement that too in our system :D
 
 Again, the values we would be inputting is in relative scale. Longer Orbital Period, shorter Orbit-Duration for its rotation.
 
 - important:
 Orbital Period around the Sun as the Centre\
 -Mercury - 88 Days\
 -Venus - 225 Days\
 -Earth - 365 Days
 -Mars - 687 Days\
 -Moon - 27 Days\
 -Phobos - 0 Day 8 Hours\
 -Deimos - 0 Day 30 Hours
 
 */

var mercuryOrbitalDuration = 400
var venusOrbitalDuration = 700
var earthOrbitalDuration = 1200
var marsOrbitalDuration = 1000

// Orbital-Duration for Natural Satellites
var moonOrbitalDuration = 300
var phobosOrbitalDuration = 250
var deimosOrbitalDuration = 200

//: ## Distance from Sun
/*:
 
 Each planet orbits at a different distance from Sun and we want that too in our system.
 
 Again, we are setting the distance in relative scale.
 
 >As Moon is the natural satellite revolving around Mother Earth, so are Phobos and Deimos to Mars.\ Be sure to leave enough space in between so they wont collide!
 
 - important:
 Distance of Each Planet from Sun:\
 -Mercury - 57.9 mil km\
 -Venus - 108.2 mil km\
 -Earth - 149.6 mil km\
 -Mars - 227.9 mil km\
 Distance of Each Satellite from its Parent:\
 -Moon - 384,399 km\
 -Phobos - 9,376 km\
 -Deimos - 23,463 km
 
 */


var mercuryDistance = 2.0
var venusDistance = 5.5
var earthDistance = 11
var marsDistance = 17

var moonDistance = 2.5
var phobosDistance = 2.5
var deimosDistance = 2.5


//#-end-editable-code
//#-hidden-code


var numberAllowed = 1
var systemExisted = 0


// Creation of a helper node
// as the Centre of Rotation around Sun
let mercuryHelperNode = SCNNode()
let venusHelperNode = SCNNode()
let earthHelperNode = SCNNode()
let marsHelperNode = SCNNode()
let moonHelperNode = SCNNode()
let phobosHelperNode = SCNNode()
let deimosHelperNode = SCNNode()

// Planet Sun, Venus, Earth and Mars
// Note for future use:
// Not creating a general class to allow tweaking of orbital-duration by users
// Best way is to pre-configure each Planet using SceneKit Editor and with a Class
// But it would come at a cost that users/kids (new to coding concepts)
// -would not get to see the actual code within each Planet, and
// -hence in this context, decided to keep it simple for easy understanding

class SunNode: SCNNode {
    override init() {
        super.init()
        self.geometry = SCNSphere(radius: sunSize)
        self.geometry?.firstMaterial?.diffuse.contents = UIImage(named:"Sun")
        self.geometry?.firstMaterial?.emission.contents = UIImage(named:"Sun")

        self.geometry?.firstMaterial?.shininess = 50
        
        let action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(x:0, y:1, z:0), duration: TimeInterval(sunDuration))
        
        let repeatAction = SCNAction.repeatForever(action)
        self.runAction(repeatAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

class MercuryNode: SCNNode {
    override init() {
        super.init()
        self.geometry = SCNSphere(radius: mercurySize)
        self.geometry?.firstMaterial?.diffuse.contents = UIImage(named:"Mercury")
        self.geometry?.firstMaterial?.emission.contents = UIImage(named:"Mercury")

        
        self.geometry?.firstMaterial?.shininess = 50
        
        let action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(x:0, y:1, z:0), duration: TimeInterval(mercuryDuration))
        
        let repeatAction = SCNAction.repeatForever(action)
        self.runAction(repeatAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

class VenusNode: SCNNode {
    override init() {
        super.init()
        self.geometry = SCNSphere(radius: venusSize)
        self.geometry?.firstMaterial?.diffuse.contents = UIImage(named:"Venus")
        self.geometry?.firstMaterial?.emission.contents = UIImage(named:"Venus")


        self.geometry?.firstMaterial?.shininess = 50

        let action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(x:0, y:1, z:0), duration: TimeInterval(venusDuration))
        
        let repeatAction = SCNAction.repeatForever(action)
        self.runAction(repeatAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

class EarthNode: SCNNode {
    override init() {
        super.init()
        self.geometry = SCNSphere(radius: earthSize)
        self.geometry?.firstMaterial?.diffuse.contents = UIImage(named:"Earth_Diffuse")
        self.geometry?.firstMaterial?.specular.contents = UIImage(named:"Earth_Specular")
        self.geometry?.firstMaterial?.emission.contents = UIImage(named:"Earth_Diffuse")
        self.geometry?.firstMaterial?.normal.contents = UIImage(named:"Earth_Normal")
        
        self.geometry?.firstMaterial?.shininess = 50

        let action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(x:0, y:1, z:0), duration: TimeInterval(earthDuration))
        
        let repeatAction = SCNAction.repeatForever(action)
        self.runAction(repeatAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

class MarsNode: SCNNode {
    override init() {
        super.init()
        self.geometry = SCNSphere(radius: marsSize)
        self.geometry?.firstMaterial?.diffuse.contents = UIImage(named:"Mars")
        self.geometry?.firstMaterial?.emission.contents = UIImage(named:"Mars")

        
        self.geometry?.firstMaterial?.shininess = 50

        let action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(x:0, y:1, z:0), duration: TimeInterval(marsDuration))

        let repeatAction = SCNAction.repeatForever(action)
        self.runAction(repeatAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

class MoonNode: SCNNode {
    override init() {
        super.init()
        self.geometry = SCNSphere(radius: moonSize)
        self.geometry?.firstMaterial?.diffuse.contents = UIImage(named:"Moon")
        self.geometry?.firstMaterial?.emission.contents = UIImage(named:"Moon")

        self.geometry?.firstMaterial?.shininess = 50
        
        let action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(x:0, y:1, z:0), duration: TimeInterval(moonDuration))
        
        let repeatAction = SCNAction.repeatForever(action)
        self.runAction(repeatAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

class PhobosNode: SCNNode {
    override init() {
        super.init()
        self.geometry = SCNSphere(radius: phobosSize)
        self.geometry?.firstMaterial?.diffuse.contents = UIImage(named:"Phobos")
        self.geometry?.firstMaterial?.emission.contents = UIImage(named:"Phobos")

        self.geometry?.firstMaterial?.shininess = 50
        
        let action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(x:0, y:1, z:0), duration: TimeInterval(phobosDuration))
        
        let repeatAction = SCNAction.repeatForever(action)
        self.runAction(repeatAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

class DeimosNode: SCNNode {
    override init() {
        super.init()
        self.geometry = SCNSphere(radius: deimosSize)
        self.geometry?.firstMaterial?.diffuse.contents = UIImage(named:"Deimos")
        self.geometry?.firstMaterial?.emission.contents = UIImage(named:"Deimos")

        
        self.geometry?.firstMaterial?.shininess = 50
        
        let action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(x:0, y:1, z:0), duration: TimeInterval(deimosDuration))
        
        let repeatAction = SCNAction.repeatForever(action)
        self.runAction(repeatAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
/*
    Separation line of  the above Nodes and ViewController down below
 */


class ARViewController : UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    @IBOutlet var sceneView: ARSCNView!

    
    var planeGeometry:SCNPlane!
    let planeIdentifiers = [UUID]()
    var anchors = [ARAnchor]()
    var sceneLight:SCNLight!
    
    override func loadView() {
        sceneView = ARSCNView(frame:CGRect(x: 0.0, y: 0.0, width: 500.0, height: 600.0))
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = false
        let scene = SCNScene()
        sceneView.scene = scene
        sceneLight = SCNLight()
        sceneLight.type = .omni
        let lightNode = SCNNode()
        lightNode.light = sceneLight
        lightNode.position = SCNVector3(x:0,y:10,z:2)
        sceneView.scene.rootNode.addChildNode(lightNode)

        // Create a session configuration
        // The standard, default configuration
        let configuration = ARWorldTrackingConfiguration()

        // For lighting
        configuration.isLightEstimationEnabled = true
        
        // Enable plane detection
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
        
        sceneView.session.delegate = self
        
        self.view = sceneView
        
        // Run the view's session
        sceneView.session.run(configuration)



    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let touch = touches.first
        let location = touch?.location(in: sceneView)

        let hitResults = sceneView.hitTest(location!, types: .featurePoint)

        // Mercury, Venus, Earth and Mars
        if let hitTestResult = hitResults.first{
            if systemExisted < numberAllowed{
                systemExisted += 1
                
                let transform = hitTestResult.worldTransform
                
                let position = SCNVector3(x: transform.columns.3.x, y:transform.columns.3.y, z:transform.columns.3.z)
                
                let sunNode = SunNode()
                sunNode.position = position
                sceneView.scene.rootNode.addChildNode(sunNode)
                
                // adding HelperNode into Sun node as the centre
                sunNode.addChildNode(mercuryHelperNode)
                sunNode.addChildNode(venusHelperNode)
                sunNode.addChildNode(earthHelperNode)
                sunNode.addChildNode(marsHelperNode)

                
                let mercuryNode = MercuryNode()
                mercuryNode.position = SCNVector3(mercuryDistance,0,0)
                mercuryHelperNode.addChildNode(mercuryNode)
                
                let venusNode = VenusNode()
                venusNode.position = SCNVector3(venusDistance,0,0)
                venusHelperNode.addChildNode(venusNode)
                
                let earthNode = EarthNode()
                earthNode.position = SCNVector3(earthDistance,0,0)
                earthHelperNode.addChildNode(earthNode)
                
                earthNode.addChildNode(moonHelperNode)
                
                let moonNode = MoonNode()
                moonNode.position = SCNVector3(moonDistance,0,0)
                moonHelperNode.addChildNode(moonNode)
                
                let marsNode = MarsNode()
                marsNode.position = SCNVector3(marsDistance,0,0)
                marsHelperNode.addChildNode(marsNode)
                
                marsNode.addChildNode(phobosHelperNode)
                marsNode.addChildNode(deimosHelperNode)

                
                let phobosNode = PhobosNode()
                phobosNode.position = SCNVector3(phobosDistance,0,0)
                phobosHelperNode.addChildNode(phobosNode)
                
                let deimosNode = DeimosNode()
                deimosNode.position = SCNVector3(deimosDistance,0,0)
                deimosHelperNode.addChildNode(deimosNode)
                
                var action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(x:0, y:100, z:0), duration: TimeInterval(mercuryOrbitalDuration))
                var repeatAction = SCNAction.repeatForever(action)
                mercuryHelperNode.runAction(repeatAction)
                
                action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(x:0, y:100, z:0), duration: TimeInterval(venusOrbitalDuration))
                repeatAction = SCNAction.repeatForever(action)
                venusHelperNode.runAction(repeatAction)
                
                action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(x:0, y:100, z:0), duration: TimeInterval(earthOrbitalDuration))
                repeatAction = SCNAction.repeatForever(action)
                earthHelperNode.runAction(repeatAction)
                
                action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(x:0, y:100, z:0), duration: TimeInterval(marsOrbitalDuration))
                repeatAction = SCNAction.repeatForever(action)
                marsHelperNode.runAction(repeatAction)
                
                action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(x:0, y:100, z:0), duration: TimeInterval(moonOrbitalDuration))
                repeatAction = SCNAction.repeatForever(action)
                moonHelperNode.runAction(repeatAction)
                
                action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(x:0, y:100, z:0), duration: TimeInterval(phobosOrbitalDuration))
                repeatAction = SCNAction.repeatForever(action)
                phobosHelperNode.runAction(repeatAction)
                
                action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(x:0, y:100, z:0), duration:TimeInterval( deimosOrbitalDuration))
                repeatAction = SCNAction.repeatForever(action)
                deimosHelperNode.runAction(repeatAction)
            }
        }
    }
            
    
    
    // MARK: - ARSKViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if let estimate = self.sceneView.session.currentFrame?.lightEstimate {
            sceneLight.intensity = estimate.ambientIntensity
        }
    }
    
    
}
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
    }

// Ported from Augmented Reality Module of iOS Project into Playground
PlaygroundPage.current.liveView = ARViewController()
PlaygroundPage.current.needsIndefiniteExecution = true


//#-end-hidden-code
