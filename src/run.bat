docker run --rm -dt --name websafety --dns=8.8.8.8 -p 8000:80 -p 3128:3128 -e TIME_ZONE="Europe/Berlin" diladele/websafety:7.6