//
//  ViewController.swift
//  StringParser
//
//  Created by jam.e.perl@gmail.com on 03/13/2017.
//  Copyright (c) 2017 jam.e.perl@gmail.com. All rights reserved.
//

import UIKit
import StringParser

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let x:Int? = try? "1".parse("$0")
        print("x=", x)
        let (a,b) = try! "hello(123)".parse("$0($1)") as (String, Int)
        print("a=", a, "b=", b)
        let (int, string, bool) = try! "1+1=2 is true".parse("1+1=$0 $1 $2") as (Bool, String, Int)
        print("(bool,string,int)=(\(bool),\(string),\(int))")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

