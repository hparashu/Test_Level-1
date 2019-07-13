# Test_Level-1
DevOps/SysOps role – Level#1

Tasks:
1.	Create a Kubernetes cluster on GCP (GCP gives free credits on signup so those should suffice for this exercise). If possible share a script / code which can be used to create the cluster.

  Since I'm an employee of Oracle and familiar with Oracle Cloud, I have created this K8s cluster on Oracle Cloud for learning purpose and share the steps I followed sometime back; 
  
```
root@e8225f:~# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
OK
root@e8225f:~# 
root@e8225f:~# 
root@e8225f:~# apt-key fingerprint 0EBFCD88
pub   4096R/0EBFCD88 2017-02-22
      Key fingerprint = 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid                  Docker Release (CE deb) <docker@docker.com>
sub   4096R/F273FCD8 2017-02-22
root@e8225f:~# 
root@e8225f:~# 
root@e8225f:~#  
root@e8225f:~# add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linus/ubuntu \
$(lsb_release -cs) \
stable"
root@e8225f:~#
root@e8225f:~# apt-get update    // to update docker repository  


root@e8225f:~# apt-get install -yq docker.io
Reading package lists...
Building dependency tree...
Reading state information...
The following additional packages will be installed:
  bridge-utils cgroupfs-mount libltdl7 pigz ubuntu-fan
Suggested packages:
  mountall aufs-tools debootstrap docker-doc rinse zfs-fuse | zfsutils
The following NEW packages will be installed:
  bridge-utils cgroupfs-mount docker.io libltdl7 pigz ubuntu-fan
0 upgraded, 6 newly installed, 0 to remove and 54 not upgraded.
Need to get 40.4 MB of archives.
After this operation, 198 MB of additional disk space will be used.
Get:1 http://oracle.clouds.archive.ubuntu.com/ubuntu xenial/universe amd64 pigz amd64 2.3.1-2 [61.1 kB]
Get:2 http://oracle.clouds.archive.ubuntu.com/ubuntu xenial/main amd64 bridge-utils amd64 1.5-9ubuntu1 [28.6 kB]
Get:3 http://oracle.clouds.archive.ubuntu.com/ubuntu xenial/universe amd64 cgroupfs-mount all 1.2 [4,970 B]
Get:4 http://oracle.clouds.archive.ubuntu.com/ubuntu xenial/main amd64 libltdl7 amd64 2.4.6-0.1 [38.3 kB]
Get:5 http://oracle.clouds.archive.ubuntu.com/ubuntu xenial-updates/universe amd64 docker.io amd64 18.06.1-0ubuntu1~16.04.2 [40.3 MB]
Get:6 http://oracle.clouds.archive.ubuntu.com/ubuntu xenial-updates/main amd64 ubuntu-fan all 0.12.8~16.04.2 [35.6 kB]
Fetched 40.4 MB in 3s (11.9 MB/s)
Preconfiguring packages ...
Selecting previously unselected package pigz.
(Reading database ... 110108 files and directories currently installed.)
Preparing to unpack .../pigz_2.3.1-2_amd64.deb ...
Unpacking pigz (2.3.1-2) ...
Selecting previously unselected package bridge-utils.
Preparing to unpack .../bridge-utils_1.5-9ubuntu1_amd64.deb ...
Unpacking bridge-utils (1.5-9ubuntu1) ...
Selecting previously unselected package cgroupfs-mount.
Preparing to unpack .../cgroupfs-mount_1.2_all.deb … ikokl
Unpacking cgroupfs-mount (1.2) ...
Selecting previously unselected package libltdl7:amd64.
Preparing to unpack .../libltdl7_2.4.6-0.1_amd64.deb ...
Unpacking libltdl7:amd64 (2.4.6-0.1) ...
Selecting previously unselected package docker.io.
Preparing to unpack .../docker.io_18.06.1-0ubuntu1~16.04.2_amd64.deb ...
Unpacking docker.io (18.06.1-0ubuntu1~16.04.2) ...
Selecting previously unselected package ubuntu-fan.
Preparing to unpack .../ubuntu-fan_0.12.8~16.04.2_all.deb ...
Unpacking ubuntu-fan (0.12.8~16.04.2) ...
Processing triggers for man-db (2.7.5-1) ...
Processing triggers for ureadahead (0.100.0-19) ...
Processing triggers for systemd (229-4ubuntu21.15) ...
Processing triggers for libc-bin (2.23-0ubuntu10) ...
Setting up pigz (2.3.1-2) ...
Setting up bridge-utils (1.5-9ubuntu1) ...
Setting up cgroupfs-mount (1.2) ...
Setting up libltdl7:amd64 (2.4.6-0.1) ...
Setting up docker.io (18.06.1-0ubuntu1~16.04.2) ...
Adding group `docker' (GID 116) ...
Done.
Setting up ubuntu-fan (0.12.8~16.04.2) ...
Processing triggers for systemd (229-4ubuntu21.15) ...
Processing triggers for ureadahead (0.100.0-19) ...
Processing triggers for libc-bin (2.23-0ubuntu10) ...
root@e8225f:~#
root@e8225f:~# which docker
/usr/bin/docker
root@e8225f:~# docker --version
Docker version 18.06.1-ce, build e68fc7a
root@e8225f:~#
root@e8225f:~# docker version
Client:
 Version:           18.06.1-ce
 API version:       1.38
 Go version:        go1.10.4
 Git commit:        e68fc7a
 Built:             Thu Nov 15 21:12:47 2018
 OS/Arch:           linux/amd64
 Experimental:      false

Server:
 Engine:
  Version:          18.06.1-ce
  API version:      1.38 (minimum version 1.12)
  Go version:       go1.10.4
  Git commit:       e68fc7a
  Built:            Sun Nov 11 21:53:22 2018
  OS/Arch:          linux/amd64
  Experimental:     false
root@e8225f:~#



curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - 

sudo cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/  kubernetes-xenial main
EOF

sudo apt-get update -y 
sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni
sudo sysctl net.bridge.bridge-nf-call-iptables=1
sudo rm -rf /var/lib/kubelet/* 



root@e8225f:~# kubectl version
Client Version: version.Info{Major:"1", Minor:"13", GitVersion:"v1.13.3", GitCommit:"721bfa751924da8d1680787490c54b9179b1fed0", GitTreeState:"clean", BuildDate:"2019-02-01T20:08:12Z", GoVersion:"go1.11.5", Compiler:"gc", Platform:"linux/amd64"}
The connection to the server localhost:8080 was refused - did you specify the right host or port?
root@e8225f:~#

root@e8225f:~# kubeadm version
kubeadm version: &version.Info{Major:"1", Minor:"13", GitVersion:"v1.13.3", GitCommit:"721bfa751924da8d1680787490c54b9179b1fed0", GitTreeState:"clean", BuildDate:"2019-02-01T20:05:53Z", GoVersion:"go1.11.5", Compiler:"gc", Platform:"linux/amd64"}
root@e8225f:~#
root@e8225f:~# kubelet --version
Kubernetes v1.13.3
root@e8225f:~#
```
  
  

2.	Install nginx ingress controller on the cluster. For now, we consider that the user will add public IP of ingress LoadBalancer to their /etc/hosts file for all hostnames to be used. So do not worry about DNS resolution.

```
Test 1 
```
