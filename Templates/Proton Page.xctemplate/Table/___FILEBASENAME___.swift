//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

import Proton

class ___FILEBASENAMEASIDENTIFIER___: Page {
    
    private var items = TableData<<#ModelClassName#>>()

    override func layout() -> ProtonView {
        return Table(data: items, cells: [])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}