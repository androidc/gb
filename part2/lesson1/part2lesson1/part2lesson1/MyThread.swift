//
//  MyThread.swift
//  part2lesson1
//
//  Created by Артем on 22.02.2023.
//

import Foundation

class ThreadPrintPalm: Thread {
    override func main() {
        while !isCancelled {
            print("\u{1F436}")
        }
        
        if isCancelled {
            print("thread is over")
        }
    }
}
