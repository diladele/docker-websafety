Web Safety 6.2 in Docker with Squid 3.5.27
==========================================

This project provides a full Docker image for Web Safety, including Squid proxy rebuilt to enable SSL decryption and HTTPS filtering (version 3.5.27).

Web Safety for Squid Proxy is the ICAP web filtering server that provides rich content and web filtering functionality to sanitize Internet traffic passing into an internal home/enterprise network. It may be used to block illegal or potentially malicious file downloads, remove annoying advertisements, prevent access to various categories of web sites and block resources with explicit content. The application is easily deployed and managed, requires minimal external dependencies, very robust and runs with the excellent performance. 

It supports all major Linux distributions (Ubuntu, Debian, CentOS) and partially FreeBSD (pfSense). With the latest release of Docker it can also run on Windows 10 Professional, Windows Server 2016 and Apple MacOS X.

***Check [the upgrade documentation](https://docs.diladele.com/administrator_guide_6_2/upgrade/index.html) for more informaion about the changes and hints at a potential upgrade path from previous images.***

# Running the image from Docker Hub

Please install docker from www.docker.com.

If you had the image already deployed please see how you can [clean before updating to the newest version](# Removing existing images and containers).

In order to run the product please execute the following commands:
```
    docker run -it --name websafety-config diladele/websafety:6.2 /usr/local/bin/firstrun.sh
    docker run -dt --name websafety --dns=8.8.8.8 --volumes-from websafety-config -p 8000:80 -p 3128:3128 diladele/websafety:6.2
```
After executing these commands, you can connect to the Admin Console typing [http://localhost:8000](http://localhost:8000) in your browser.

The Squid proxy is listening on port 3128. 

To stop the container, please run:

    docker stop websafety

To start the container again, please run:

    docker start websafety

The full tutorial explaining how to run this Docker container on Windows 10 can be found [here](https://docs.diladele.com/docker/docker_windows_10/index.html).

# Removing existing images and containers

In order to remove the previous version of websafety, please perform the following steps:
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
See how you can [install the new version](#running-the-image-from-docker-hub).

# Building the image on your machine

Please install docker from www.docker.com. After cloning the project, build it with

    ./build.sh

Run the container with

    ./run.sh

Stop with

    docker stop websafety

Start again with

    docker start websafety


# Licensing

The docker image comes with a pre-installed license. If it expires, please request the license at support@diladele.com

# Support

In case of any questions, please contact support@diladele.com

# References

* For standalone VMware ESXi/vSphere or Microsoft-HyperV virtual appliance visit [Web Safety Virtual Appliance](https://www.diladele.com/virtual_appliance.html).
* Virtual Appliance can also be deployed from Microsoft Azure Market Place using the following link https://azuremarketplace.microsoft.com/en-us/marketplace/apps/diladele.websafety?tab=Overview   
* Documentation for the project is [available online](https://docs.diladele.com)
* Support requests should be directed to support@diladele.com.

# Contributors

Our big thanks go to Ian Bashford for his invaluable contributions. Also a lot of thanks to Johann Richard for moving to version 5.0.
