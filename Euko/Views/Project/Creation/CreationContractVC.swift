//
//  CreationContractVC.swift
//  Euko
//
//  Created by Victor Lucas on 14/03/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit

class CreationContractVC: UIViewController, SHFSignatureProtocol {

    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var drawSpaceView: SHFSignatureView!
    
    @IBOutlet weak var contractTitle: UILabel!
    @IBOutlet weak var approuvedContent: UILabel!
    @IBOutlet weak var contractContent: UITextView!
    @IBOutlet weak var validateButton: UIButton!
    
    var signatureImage:UIImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.drawSpaceView.delegate = self
        self.clearButton.layer.borderWidth = 2
        self.clearButton.layer.borderColor = UIColor(red: 59/255, green: 84/255, blue: 213/255, alpha: 1).cgColor
        self.clearButton.roundBorder()
        
        self.validateButton.roundBorder()
        //self.contractContent.text = "Je soussignée Julien Pernot,\nné à Paris le 25 Novembre 1991,\m'engage à régler la somme de\n275 euros, soit deux cent soixante\nquinze euros à Monsieur Yvan\nDupont.\n\nCette somme comprend ma\ndemande de prêt initiale de 250\neuros ainsi que les intérêts de 10%,\nsoient 25 euros.\n\nJe m'engage à régler la somme à \ntravers des mensualités de 33 euros\ndurant les 3 mois consécutifs, à\ncompter du 01 Février 2019."
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func validateAction(_ sender: Any) {
        //TODO: Appel API pour valider le contrat
    }
    
    func drawingSignature() {
    }
    
    func image(_ signature: UIImage?) {
        self.signatureImage = signature ?? UIImage()
    }

    @IBAction func clearAction(_ sender: Any) {
        self.drawSpaceView.clear()
        self.signatureImage = UIImage()
    }
}
