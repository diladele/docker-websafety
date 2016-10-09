Diladele Web Safety 4.7 in Docker with Squid 3.5.19
=============================================

This project provides a full Docker image for Diladele Web Safety, including Squid with SSL support(version 3.5.19) and Apache.

Running the image from Docker Hub
---
Please install docker from www.docker.com.

In order to run the product please execute the following commands:
    
    docker run -it --name websafety-config diladele/websafety:4.7-beta /usr/local/bin/firstrun.sh
    docker run -d --name websafety-runtime --volumes-from websafety-config -p 8881:80 -p 8882:3128 -t diladele/websafety:4.7-beta

After executing these commands, you can connect to the Web UI typing [http://localhost:8881](http://localhost:8881) in your browser.

The Squid is listening on port 8882. 

To stop the image, please run:

    docker stop websafety-runtime

To start the image again, please run:

    docker start websafety-runtime

Full tutorial can be found here.

Building and running the image on your machine
---
Please install docker from www.docker.com.
After cloning the project, build it with

    ./build.sh

Run with

    ./run.sh

Stop with

    docker stop websafety-runtime

Start again with

    docker start websafety-runtime

Support
---
In case of any questions, please contact support@diladele.com

References
---
* For an image with the standalone Web Safety please visit [Diladele Web Safety Docker Cluster](https://github.com/diladele/docker-cluster)
* For Squid on Windows installer please click [here](https://github.com/diladele/squid3-windows)
