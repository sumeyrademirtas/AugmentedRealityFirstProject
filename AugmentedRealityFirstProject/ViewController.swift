//
//  ViewController.swift
//  AugmentedRealityFirstProject
//
//  Created by Sümeyra Demirtaş on 11/12/24.
//

import ARKit
import SceneKit
import UIKit

class ViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Telefonun a9 chipe sahip olmasi gerekiyor. iphone 6s sonrasi.
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let shipScene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = shipScene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration() // bir objeyi kendi odaniz icerisine koydugunuzda, o odada nerede konumlanacagini bulup kendini sabitliyor.

        // Run the view's session
        sceneView.session.run(configuration)
        
        for node in sceneView.scene.rootNode.childNodes {
            // AR sahnesindeki tüm nesneleri (node'ları) tek tek alıyoruz.

            let moveShip = SCNAction.moveBy(x: 1, y: 0.5, z: -0.5, duration: 1)
            // 'moveShip' hareketini oluşturuyoruz:
            // Bu hareket, nesneyi sağa doğru (x: 1), yukarı (y: 0.5) ve bize doğru (z: -0.5) hareket ettiriyor.
            // Bu hareketin tamamlanması 1 saniye sürüyor.

            let fadeOut = SCNAction.fadeOpacity(to: 0.5, duration: 1)
            // 'fadeOut' hareketi ile nesneyi yarı şeffaf hale getiriyoruz (opaklık 0.5'e düşüyor).
            // Yarı şeffaf hale gelmesi 1 saniye sürüyor.

            let fadeIn = SCNAction.fadeOpacity(to: 1, duration: 1)
            // 'fadeIn' hareketi ile nesneyi tekrar tam görünür hale getiriyoruz (opaklık 1 oluyor).
            // Tam görünür hale gelmesi 1 saniye sürüyor.

            let sequence = SCNAction.sequence([moveShip, fadeOut, fadeIn])
            // Yukarıdaki üç hareketi bir sıraya koyuyoruz:
            // İlk olarak nesne hareket ediyor, ardından yarı şeffaflaşıyor, sonra tekrar görünür oluyor.

            let repeatForever = SCNAction.repeatForever(sequence)
            // Bu sırayı sonsuz döngüye alıyoruz:
            // Nesne sürekli olarak hareket edip şeffaflaşıp tekrar görünecek.

            node.runAction(repeatForever)
            // Bu animasyonu sahnedeki her nesneye (node'a) uyguluyoruz.
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
         let node = SCNNode()
     
         return node
     }
     */
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
    }
}
