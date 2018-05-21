/*
 * Copyright IBM Corporation 2016
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import Kitura
import Foundation

import HeliumLogger

HeliumLogger.use()

let router = Router()

router.get("/dataIntensiveJobAsync/independent") {
    request, response, next in
  let startTime = Date()
  response.send("Running Independent Data Intensive Job with Nested Async\n\n")
  response.send("Running Time(in Sec): p1 = 3, p2 = 4, p3 = 2, p4 = 6, p5 = 1 \n\n")
  
  let bulkOperationAsyncObject = BulkOperationAsync()
  
  bulkOperationAsyncObject.executeIndependentHeavyProcesses({ (output) in
    response.send("\nExecution Order Output:" + output.description + "\n")
    let endTime = Date()
    let timeInterval: Double = endTime.timeIntervalSince(startTime)
    response.send("\nTotal Execution Time(in Sec): "+timeInterval.description)
    next()
  })

}


router.get("/dataIntensiveJobGCD/independent") {
  request, response, next in
  
  let startTime = Date()
  response.send("Running Independent Data Intensive Job with OperationQueue\n\n")
  response.send("Running Time(in Sec): p1 = 3, p2 = 4, p3 = 2, p4 = 6, p5 = 1 \n\n")
  
  
  let bulkOperationGCDObject = BulkOperationGCD()
  
  bulkOperationGCDObject.executeIndependentHeavyProcesses({ (output) in
    response.send("\nExecution Order Output:" + output.description + "\n")
    let endTime = Date()
    let timeInterval: Double = endTime.timeIntervalSince(startTime)
    response.send("\nTotal Execution Time(in Sec): "+timeInterval.description)
    next()
  })

}



router.get("/dataIntensiveJobAsync/dependent") {
  request, response, next in
  let startTime = Date()
  response.send("Running Dependent Data Intensive Job with Nested Async\n\n")
  response.send("[p1 - p2] && [p3 - p4] \n\n")
  response.send("Running Time(in Sec): p1 = 3, p2 = 4, p3 = 2, p4 = 6 \n\n")
  
  let bulkOperationAsyncObject = BulkOperationAsync()
  
  bulkOperationAsyncObject.executeDependentHeavyProcesses({ (output) in
    response.send("\nExecution Order Output:" + output.description + "\n")
    let endTime = Date()
    let timeInterval: Double = endTime.timeIntervalSince(startTime)
    response.send("\nTotal Execution Time(in Sec): "+timeInterval.description)
    next()
  })
  
}


router.get("/dataIntensiveJobGCD/dependent") {
  request, response, next in
  
  let startTime = Date()
  response.send("Running Dependent Data Intensive Job with GCD\n\n")
  response.send("[p1 - p2] && [p3 - p4] \n\n")
  response.send("Running Time(in Sec): p1 = 3, p2 = 4, p3 = 2, p4 = 6 \n\n")
  
  
  let bulkOperationGCDObject = BulkOperationGCD()
  
  bulkOperationGCDObject.executeDependentHeavyProcesses({ (output) in
    response.send("\nExecution Order Output:" + output.description + "\n")
    let endTime = Date()
    let timeInterval: Double = endTime.timeIntervalSince(startTime)
    response.send("\nTotal Execution Time(in Sec): "+timeInterval.description)
    next()
  })
  
}


router.get("/dataIntensiveJobAsync/iterate") {
  request, response, next in
  let startTime = Date()
  response.send("Iterate(3) & Run Data Intensive Job with Nested Async\n\n")
  response.send("Running Time(in Sec): p1 = 3, p2 = 4, p3 = 2, p4 = 6, p5 = 1 \n\n")
  
  let total = 3;
  var count = 0
  
  for _ in 0...2 {
    
  let bulkOperationAsyncObject = BulkOperationAsync()
  
  bulkOperationAsyncObject.executeIndependentHeavyProcesses({ (output) in
    count = count + 1
    response.send("\nExecution Order Output:" + output.description + "\n")
    
    if (count == total) {
      let endTime = Date()
      let timeInterval: Double = endTime.timeIntervalSince(startTime)
      response.send("\nTotal Execution Time(in Sec): "+timeInterval.description)
      next()
    }
    
  })
    
  }
  
}


router.get("/dataIntensiveJobGCD/iterate") {
  request, response, next in
  
  let startTime = Date()
  response.send("Iterate(3) & Run Depedant Data Intensive Job with GCD\n\n")
  response.send("Running Time(in Sec): p1 = 3, p2 = 4, p3 = 2, p4 = 6,p5 = 1 \n\n")
  
  let dispatchGroup = DispatchGroup()
  let operationQueue = OperationQueue()
  
  for _ in 0...2 {
    
    dispatchGroup.enter()
    let bulkOperationGCDObject = BulkOperationGCD()
    operationQueue.addOperation {
      bulkOperationGCDObject.executeIndependentHeavyProcesses({ (output) in
        response.send("\nExecution Order Output:" + output.description + "\n")
        dispatchGroup.leave()
      })
    }

  }
  
  dispatchGroup.wait()
  
  let endTime = Date()
  let timeInterval: Double = endTime.timeIntervalSince(startTime)
  response.send("\nTotal Execution Time(in Sec): "+timeInterval.description)
  next()
  
}



// Use port 8080 unless overridden by environment variable
let port = Int(ProcessInfo.processInfo.environment["PORT"] ?? "8080") ?? 8080

Kitura.addHTTPServer(onPort: port, with: router)
Kitura.run()
