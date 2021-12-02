//
//  ARViewController.swift
//  HowMuch
//
//  Created by 심찬영 on 2021/11/01.
//

import UIKit
import ARKit

class ARViewController : UIViewController, ARSCNViewDelegate {
    @IBOutlet weak var sceneView: ARSCNView!
    
    // planes
    var dictPlanes = [ARPlaneAnchor: Plane]()
    
    // distance label
    @IBOutlet weak var lblMeasurementDetails : UILabel!
        
    
    var dotNodes = [SCNNode]()
    var textNode = SCNNode()
    
    var length : String = ""

    func addDot( at hitResult: ARHitTestResult ) {
        // the size of the green circle
        let dotGeometry = SCNSphere(radius: 0.005)

        let material = SCNMaterial()
        material.diffuse.contents = UIColor.systemGreen

        dotGeometry.materials = [material]

        // the "dot" element
        let dotNode = SCNNode(geometry: dotGeometry)
        dotNode.position = SCNVector3(
            hitResult.worldTransform.columns.3.x,
            hitResult.worldTransform.columns.3.y,
            hitResult.worldTransform.columns.3.z)

        sceneView.scene.rootNode.addChildNode(dotNode)

        dotNodes.append(dotNode)

        // we have 2 points on scree, try to calculate distance
        if dotNodes.count >= 2 {
            calculateDistance()
        }
    }

    func resetDots() {
         for dot in dotNodes {
             dot.removeFromParentNode()
         }
         dotNodes = [SCNNode]()
    }

    func calculateDistance() {
        let start = dotNodes.first!
        let end = dotNodes.last!

        var distance = sqrt(
            pow(end.position.x - start.position.x, 2) +
            pow(end.position.y - start.position.y, 2) +
            pow(end.position.z - start.position.z, 2)
        )

        // convert to cm
        distance *= 100
        
        let str = String(format: "%2d", abs(distance))
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        self.length = formatter.string(from: NSNumber(value: distance))!

        let distanceFormatted = String(format: "%.2f cm", abs(distance))
        updateText(text: distanceFormatted, atPosition: end.position)
    }

    func updateText( text: String, atPosition: SCNVector3 ) {
         textNode.removeFromParentNode()
                
         let textGeometry = SCNText(string: text, extrusionDepth: 1.0)
         textGeometry.firstMaterial?.diffuse.contents = UIColor.systemRed

         textNode = SCNNode(geometry: textGeometry)
         textNode.position = SCNVector3(
             atPosition.x,
             atPosition.y + 0.01,
             atPosition.z
         )

         textNode.scale = SCNVector3(0.01, 0.01, 0.01)
         sceneView.scene.rootNode.addChildNode(textNode)
     }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//     if dotNodes.count >= 2 { resetDots() }
//
//     if let touchLocation = touches.first?.location(in: sceneView) {
////          let hitTestResults = sceneView.hitTest(touchLocation, types: .featurePoint)
//
//         let hitTestResults = sceneView.hitTest(view.center, types: .featurePoint)
//          if let hitResult = hitTestResults.first {
//              addDot(at: hitResult)
//          }
//      }
//     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup scene
        self.setupScene()
        
        
    }
    
//
//    // start node
//        var startNode: SCNNode?
//
        //MARK: - Action
        @IBAction func onAddButtonClick(_ sender: UIButton) {
            if dotNodes.count >= 2 { resetDots() }
            
            let hitTestResults = sceneView.hitTest(view.center, types: .featurePoint)
            
             if let hitResult = hitTestResults.first {
                 addDot(at: hitResult)
             }
        }
    
    
    //        @IBAction func onAddButtonClick(_ sender: UIButton) {
    //
    //            if let position = self.doHitTestOnExistingPlanes() {
    //                // add node at hit-position
    //                let node = self.nodeWithPosition(position)
    //                sceneView.scene.rootNode.addChildNode(node)
    //
    //                // set start node
    //                startNode = node
    //            }
    //        }
    
    
//        @IBAction func onAddButtonClick(_ sender: UIButton) {
//
//            if let position = self.doHitTestOnExistingPlanes() {
//                // add node at hit-position
//                let node = self.nodeWithPosition(position)
//                sceneView.scene.rootNode.addChildNode(node)
//
//                // set start node
//                startNode = node
//            }
//        }
//
    
    
//        func doHitTestOnExistingPlanes() -> SCNVector3? {
//            // hit-test of view's center with existing-planes
//            let results = sceneView.hitTest(view.center,
//                                            types: .existingPlaneUsingExtent)
//            // check if result is available
//            if let result = results.first {
//                // get vector from transform
//                let hitPos = self.positionFromTransform(result.worldTransform)
//                return hitPos
//            }
//            return nil
//        }
//
//        // get position 'vector' from 'transform'
//        func positionFromTransform(_ transform: matrix_float4x4) -> SCNVector3 {
//            return SCNVector3Make(transform.columns.3.x,
//                                  transform.columns.3.y,
//                                  transform.columns.3.z)
//        }
//
//        // add dot node with given position
//        func nodeWithPosition(_ position: SCNVector3) -> SCNNode {
//            // create sphere geometry with radius
//            let sphere = SCNSphere(radius: 0.003)
//            // set color
//            sphere.firstMaterial?.diffuse.contents = UIColor(red: 255/255.0,
//                                                             green: 153/255.0,
//                                                             blue: 83/255.0,
//                                                             alpha: 1)
//            // set lighting model
//            sphere.firstMaterial?.lightingModel = .constant
//            sphere.firstMaterial?.isDoubleSided = true
//            // create node with 'sphere' geometry
//            let node = SCNNode(geometry: sphere)
//            node.position = position
//
//            return node
//        }
//
//
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.setupARSession()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        sceneView.session.pause()
    }

    func setupARSession() {
        let configuration = ARWorldTrackingConfiguration()

        configuration.planeDetection = .vertical

        self.sceneView.session.run(configuration)
    }

    // setup scene
    func setupScene() {
        // set delegate - ARSCNViewDelegate
        self.sceneView.delegate = self

//        // showing statistics (fps, timing info)
//        self.sceneView.showsStatistics = true
//        self.sceneView.autoenablesDefaultLighting = true

//        // debug points
//        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]

        // create new scene
        let scene = SCNScene()
        self.sceneView.scene = scene
    }
//
//
//    // MARK: - ARSCNViewDelegate
//
//    // line-node
//    var line_node: SCNNode?
//
//    // renderer callback method
//    func renderer(_ renderer: SCNSceneRenderer,
//                  updateAtTime time: TimeInterval) {
//
//        DispatchQueue.main.async {
//            // get current hit position
//            // and check if start-node is available
//            guard let currentPosition = self.doHitTestOnExistingPlanes(),
//                let start = self.startNode else {
//                return
//            }
//
//            // line-node
//            self.line_node?.removeFromParentNode()
//            self.line_node = self.getDrawnLineFrom(pos1: currentPosition,
//                                                   toPos2: start.position)
//            self.sceneView.scene.rootNode.addChildNode(self.line_node!)
//
//            // distance-string
//            let desc = self.getDistanceStringBeween(pos1: currentPosition,
//                                                    pos2: start.position)
//            DispatchQueue.main.async {
//                self.lblMeasurementDetails.text = desc
//            }
//        }
//    }
//
//    // draw line-node between two vectors
//    func getDrawnLineFrom(pos1: SCNVector3,
//                          toPos2: SCNVector3) -> SCNNode {
//
//        let line = lineFrom(vector: pos1, toVector: toPos2)
//        let lineInBetween1 = SCNNode(geometry: line)
//        return lineInBetween1
//    }
//
//    // get line geometry between two vectors
//    func lineFrom(vector vector1: SCNVector3,
//                  toVector vector2: SCNVector3) -> SCNGeometry {
//
//        let indices: [Int32] = [0, 1]
//        let source = SCNGeometrySource(vertices: [vector1, vector2])
//        let element = SCNGeometryElement(indices: indices,
//                                         primitiveType: .line)
//        return SCNGeometry(sources: [source], elements: [element])
//    }
//
//    /**
//     Distance string
//     */
//    func getDistanceStringBeween(pos1: SCNVector3?,
//                                 pos2: SCNVector3?) -> String {
//
//        if pos1 == nil || pos2 == nil {
//            return "0"
//        }
//        let d = self.distanceBetweenPoints(A: pos1!, B: pos2!)
//
//        var result = ""
//
//        let meter = stringValue(v: Float(d), unit: "meters")
//        result.append(meter)
//        result.append("\n")
//
//        let f = self.foot_fromMeter(m: Float(d))
//        let feet = stringValue(v: Float(f), unit: "feet")
//        result.append(feet)
//        result.append("\n")
//
//        let inch = self.Inch_fromMeter(m: Float(d))
//        let inches = stringValue(v: Float(inch), unit: "inch")
//        result.append(inches)
//        result.append("\n")
//
//        let cm = self.CM_fromMeter(m: Float(d))
//        let cms = stringValue(v: Float(cm), unit: "cm")
//        result.append(cms)
//
//        return result
//    }
//
//    /**
//     Distance between 2 points
//     */
//    func distanceBetweenPoints(A: SCNVector3, B: SCNVector3) -> CGFloat {
//        let l = sqrt(
//            (A.x - B.x) * (A.x - B.x)
//                +   (A.y - B.y) * (A.y - B.y)
//                +   (A.z - B.z) * (A.z - B.z)
//        )
//        return CGFloat(l)
//    }
//
//    /**
//     String with float value and unit
//     */
//    func stringValue(v: Float, unit: String) -> String {
//        let s = String(format: "%.1f %@", v, unit)
//        return s
//    }
//
//    /**
//     Inch from meter
//     */
//    func Inch_fromMeter(m: Float) -> Float {
//        let v = m * 39.3701
//        return v
//    }
//
//    /**
//     centimeter from meter
//     */
//    func CM_fromMeter(m: Float) -> Float {
//        let v = m * 100.0
//        return v
//    }
//
//    /**
//     feet from meter
//     */
//    func foot_fromMeter(m: Float) -> Float {
//        let v = m * 3.28084
//        return v
//    }
//
//    /**
//         Called when a new node has been mapped to the given anchor.
//         */
//        func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
//            print("--> did add node")
//
//            DispatchQueue.main.async {
//                if let planeAnchor = anchor as? ARPlaneAnchor {
//
//                    // create plane with the "PlaneAnchor"
//                    let plane = Plane(anchor: planeAnchor)
//                    // add to the detected
//                    node.addChildNode(plane)
//                    // add to dictionary
//                    self.dictPlanes[planeAnchor] = plane
//                }
//            }
//        }
//
//        /**
//         Called when a node will be updated with data from the given anchor.
//         */
//        func renderer(_ renderer: SCNSceneRenderer, willUpdate node: SCNNode, for anchor: ARAnchor) { }
//
//        /**
//         Called when a node has been updated with data from the given anchor.
//         */
//        func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
//            DispatchQueue.main.async {
//                if let planeAnchor = anchor as? ARPlaneAnchor {
//                    // get plane with anchor
//                    let plane = self.dictPlanes[planeAnchor]
//                    // update
//                    plane?.updateWith(planeAnchor)
//                }
//            }
//        }
//
//        /**
//         Called when a mapped node has been removed from the scene graph for the given anchor.
//         */
//        func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
//
//            if let planeAnchor = anchor as? ARPlaneAnchor {
//                self.dictPlanes.removeValue(forKey: planeAnchor)
//            }
//        }
}
