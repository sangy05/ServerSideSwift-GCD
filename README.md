# ServerSideSwift-GCD
Asynchronous Server Side Swift Progamming with GCD and Operation

Article Reference:
https://developer.ibm.com/swift/2018/05/22/server-side-swift-using-gcd/

Execution:
1. Clone the code
2. Go to folder and use command 'swift build' to fetch the dependancy and build.
3. Run the ./.build/x86_64-apple-macosx10.10/debug/server-swift-GCD 
4. Use any Rest client to execute the following scenario
      
      URL end points: // all are GET method
      
      1. http://localhost/dataIntensiveJobGCD/dependent
      2. http://localhost/dataIntensiveJobGCD/independent
      3. http://localhost/dataIntensiveJobAsync/dependent
      4. http://localhost/dataIntensiveJobAsync/independent
      5. http://localhost/dataIntensiveJobGCD/iterate
      6. http://localhost/dataIntensiveJobAsync/iterate
      
    
      
      Author:
      Sangeeth K Sivakumar
      https://www.linkedin.com/in/sangeethksivakumar/
