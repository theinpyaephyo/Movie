//
//  CastListCollectionViewCell.swift
//  Movie
//
//  Created by THEIN PYAE PHYO on 2020/12/17.
//  Copyright © 2020 THEIN PYAE PHYO. All rights reserved.
//

import UIKit
import SDWebImage

class CastListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CastListCollectionViewCell"

    @IBOutlet weak var lblCastName: UILabel!
    @IBOutlet weak var imgCast: UIImageView!
    
    var castList: ProductionCompaniesVO? {
        didSet {
            if let castList = castList {
                let url = SharedConstants.posterPath + (castList.logoPath ?? "")
                imgCast.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "empty_logo"))
                
                lblCastName.text = castList.name
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
