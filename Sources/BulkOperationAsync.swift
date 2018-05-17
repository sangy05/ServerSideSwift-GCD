//
//  BulkOperationAsync.swift
//
//  Created by Sangeeth K Sivakumar on 2018-03-15.
//
//

import Foundation


class BulkOperationAsync {
  
  var output = [String]()
  func executeIndependentHeavyProcesses(_ onCompletion: @escaping (_ outputMessage:[String])-> Void) {
    self.p1 { (output) in
      
      self.output.append(output)
      
      self.p2({ (output) in
        
        self.output.append(output)
        
        self.p3({ (output) in
          
          self.output.append(output)
          
          self.p4({ (output) in
            
            self.output.append(output)
            
            self.p5({ (output) in
              
              self.output.append(output)
              onCompletion(self.output)
            })
            
          })
          
        })
        
      })
    }
    

  }
  
  
  func executeDependentHeavyProcesses(_ onCompletion: @escaping (_ outputMessage:[String])-> Void) {
    self.p1 { (output) in
      
      self.output.append(output)
      
      self.p2({ (output) in
        
        self.output.append(output)
        
        self.p3({ (output) in
          
          self.output.append(output)
          
          self.p4({ (output) in
            
            self.output.append(output)
            onCompletion(self.output)
            
          })
          
        })
        
      })
    }
    
    
  }
  
  
  func p1(_ onCompletion: @escaping (_ output:String)-> Void) {
    sleep(3)
    onCompletion("p1")
  }
  
  func p2(_ onCompletion: @escaping (_ output:String)-> Void) {
    sleep(4)
    onCompletion("p2")
  }
  
  func p3(_ onCompletion: @escaping (_ output:String)-> Void) {
    sleep(2)
    onCompletion("p3")
  }
  
  func p4(_ onCompletion: @escaping (_ output:String)-> Void) {
    sleep(6)
    onCompletion("p4")
  }
  
  func p5(_ onCompletion: @escaping (_ output:String)-> Void) {
    sleep(1)
    onCompletion("p5")
  }
  
  
  
}
