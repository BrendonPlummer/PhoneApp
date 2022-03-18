//
//  PhoneEntry.swift
//  PhoneApp
//
//  Created by Plummer B D D (FCES) on 18/03/2022.
//

import UIKit

class PhoneEntry:NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey:PropertyKey.name);
        aCoder.encode(phoneNo, forKey:PropertyKey.phoneNo);
        aCoder.encode(photo, forKey:PropertyKey.photo);
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        //Make sure we can decode, otherwise init fail
        guard let name = aDecoder.decodeObject(forKey:PropertyKey.name)as? String else{
            print("Unable to decode the phone entry");
            return nil;
        }
        guard let phoneNo = aDecoder.decodeObject(forKey: PropertyKey.phoneNo) as? String else{
            print("Unable to decode the phone entry");
            return nil;
        }
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage;
        self.init(name:name, phoneNo:phoneNo, photo:photo);
    }
    
    var name:String
    var phoneNo:String
    var photo:UIImage?
    
    init?(name:String, phoneNo:String, photo:UIImage?){
        //Check validity
        if(name.isEmpty || phoneNo.isEmpty){
            return nil;
        }
        
        self.name = name;
        self.phoneNo = phoneNo;
        self.photo = photo;
    }
    
    //Make data savable
    struct PropertyKey{
        static let name = "name";
        static let phoneNo = "phoneNo";
        static let photo = "photo";
    }
    
    //paths to data
    static let DocumentsDirectory = FileManager().urls(for:.documentDirectory, in:.userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("phoneEntries")
}
