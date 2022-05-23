Web Safety 8.1 in Docker with Squid 5.5
=======================================

This project provides a full Docker image for Web Safety, including Squid proxy rebuilt to enable SSL decryption and HTTPS filtering (version 5.5).

Web Safety for Squid Proxy is the ICAP web filtering server that provides rich content and web filtering functionality to sanitize Internet traffic passing into an internal home/enterprise network. It may be used to block illegal or potentially malicious file downloads, remove annoying advertisements, prevent access to various categories of web sites and block resources with explicit content. The application is easily deployed and managed, requires minimal external dependencies, very robust and runs with the excellent performance. 

It supports all major Linux distributions (Ubuntu, Debian, RedHat). With the latest release of Docker it can also run on Microsoft Windows and Apple MacOS X.

***Check [the upgrade documentation](https://docs.diladele.com/administrator_guide_stable/upgrade/index.html) for more informaion about the changes and hints at a potential upgrade path from previous images.***

# Running the image from Docker Hub

Please install docker from www.docker.com.

If you had the image already deployed please see how you can [clean before updating to the newest version](#removing-existing-images-and-containers).

In order to run the product please execute the following commands:
```
    docker run --rm -dt --name websafety --dns=8.8.8.8 -p 8000:80 -p 8443:443 -p 3128:3128 -e TIME_ZONE="Europe/Berlin" diladele/websafety:8.1
```
After executing these commands, you can connect to the Admin Console typing [https://localhost:8443](https://localhost:8443) in your browser. Note that version 8.1 now runs using HTTPS.

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
```

  * remove outdated image (optional):
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

# Push to DockerHub

```
    docker login --username=blabla
    docker push diladele/websafety:8.1
    
    docker tag diladele/websafety:8.1 diladele/websafety:latest
    docker push diladele/websafety:latest
```

# Licensing

The docker image comes with a pre-installed license. If it expires, please request the license at support@diladele.com or purchase at https://www.diladele.com/licensing.html

# Support

In case of any questions, please contact support@diladele.com

# References

* If you need a native Microsoft Windows proxy, look at the [Web Filtering Proxy](https://webproxy.diladele.com/) project.
* For standalone VMware ESXi/vSphere or Microsoft-HyperV virtual appliance visit [Web Safety Virtual Appliance](https://www.diladele.com/download.html).
* Virtual Appliance can also be deployed from Microsoft Azure Market Place using the following link https://azuremarketplace.microsoft.com/en-us/marketplace/apps/diladele.websafety?tab=Overview or Amazon AWS https://aws.amazon.com/marketplace/pp/B07KJHLHKC?qid=1542298277826&sr=0-1&ref_=srh_res_product_title
* Documentation for the project is [available online](https://docs.diladele.com)
* Support requests should be directed to support@diladele.com.

# Contributors

Our big thanks go to Ian Bashford for his invaluable contributions. Also a lot of thanks to Johann Richard for moving to version 5.0.
