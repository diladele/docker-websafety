Diladele Web Safety 4.7 in Docker with Squid 3.5.19
=============================================

This project provides a full Docker image for Diladele Web Safety, including Squid with SSL support(version 3.5.19) and Apache.
Diladele Web Safety for Squid Proxy is an ICAP web filtering server that provides rich content and web filtering functionality to sanitize Internet traffic passing into an internal home/enterprise network. It may be used to block illegal or potentially malicious file downloads, remove annoying advertisements, prevent access to various categories of web sites and block resources with explicit content. The application is easily deployed and managed, requires minimal external dependencies, very robust and runs with the excellent performance. It supports all major Linux distributions (Ubuntu, RedHat, Debian, CentOS), FreeBSD (pfSense) and Raspberry PI (2). With the latest release of Docker it can also run on Windows 10 Professional.

#Running the image from Docker Hub
---
Please install docker from www.docker.com.

If you had the image already deployed please see how you can [clean before updating to the newest version](#Removing existing images and containers).

In order to run the product please execute the following commands:
```
    docker run -it --name websafety-config diladele/websafety /usr/local/bin/firstrun.sh
    docker run -d --name websafety --volumes-from websafety-config -p 8000:80 -p 3128:3128 -t diladele/websafety
```
After executing these commands, you can connect to the Web UI typing [http://localhost:8000](http://localhost:8000) in your browser.

The Squid is listening on port 3128. 

To stop the image, please run:

    docker stop websafety

To start the image again, please run:

    docker start websafety

Full tutorial can be found here.

#Removing existing images and containers
---
In order to remove previous version of websafety, please perform the following steps:
  * stop running container with the following command:
```
    docker stop websafety
```

  * remove data and runtime containers:
```
    docker rm websafety 
    docker rm websafety-config
```

  * remove outdatad image (optional):
```
    docker rmi diladele/websafety
```

#Building and running the image on your machine
---
Please install docker from www.docker.com.
After cloning the project, build it with

    ./build.sh

Run with

    ./run.sh

Stop with

    docker stop websafety

Start again with

    docker start websafety


Licensing
---
The docker image comes with a pre-installed license. If it expires, please request the license at support@diladele.com

Support
---
In case of any questions, please contact support@diladele.com

References
---
* For an image with the standalone Web Safety please visit [Diladele Web Safety Docker Cluster](https://github.com/diladele/docker-cluster)
* For Squid on Windows installer please click [here](https://github.com/diladele/squid3-windows)

Contributors
---
Our big thanks go to Ian Bashford for his invaluable contributions!
