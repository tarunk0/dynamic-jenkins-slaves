# Dynamic Jenkins Slaves:

Jenkins has powerful feature of master slave architecture which enables distributed builds.

In this repository we are going to see how can we set up jenkins slaves using docker and kubernetes and standalone linux instances. 

![image](https://user-images.githubusercontent.com/92631457/189498378-ef933826-4b03-4fdd-a544-38eb6706fdda.png)

![image](https://user-images.githubusercontent.com/92631457/189498420-b4056a64-fe33-4808-bfe9-8b17b75cb6fc.png)

![image](https://user-images.githubusercontent.com/92631457/189498441-fd650c60-2685-4e18-827f-8c44fb3e7128.png)


 ## Let us learn more about Jenkins master and slave:

 ### Jenkins Master:
 
 - Your main Jenkins server is the Master. The Master’s job is to handle:

   - Scheduling build jobs.
   - Dispatching builds to the slaves for the actual execution.
   - Monitor the slaves (possibly taking them online and offline as required).
   - Recording and presenting the build results.
   - A Master instance of Jenkins can also execute build jobs directly.

 ### Jenkins Slave:
 
 - A Slave is a Java executable that runs on a remote machine. Following are the characteristics of Jenkins Slaves:
   - It hears requests from the Jenkins Master instance.
   - Slaves can run on a variety of operating systems.
   - The job of a Slave is to do as they are told to, which involves executing build jobs dispatched by the Master.
   - You can configure a project to always run on a particular Slave machine, or a particular type of Slave machine, or simply let Jenkins pick the next available Slave.
