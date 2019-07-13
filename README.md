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


Initialize Cluster with Kubeadm
=================================

ubuntu@e8225f:~$ sudo su -
	root@e8225f:~#
	root@e8225f:~#
	root@e8225f:~# kubeadm init --apiserver-advertise-address 10.196.47.110
	[init] Using Kubernetes version: v1.13.3
	[preflight] Running pre-flight checks
	[preflight] Pulling images required for setting up a Kubernetes cluster
	[preflight] This might take a minute or two, depending on the speed of your internet connection
	[preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
	[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
	[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
	[kubelet-start] Activating the kubelet service
	[certs] Using certificateDir folder "/etc/kubernetes/pki"
	[certs] Generating "ca" certificate and key
	[certs] Generating "apiserver-kubelet-client" certificate and key
	[certs] Generating "apiserver" certificate and key
	[certs] apiserver serving cert is signed for DNS names [e8225f kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 10.196.47.110]
	[certs] Generating "front-proxy-ca" certificate and key
	[certs] Generating "front-proxy-client" certificate and key
	[certs] Generating "etcd/ca" certificate and key
	[certs] Generating "etcd/peer" certificate and key
	[certs] etcd/peer serving cert is signed for DNS names [e8225f localhost] and IPs [10.196.47.110 127.0.0.1 ::1]
	[certs] Generating "etcd/healthcheck-client" certificate and key
	[certs] Generating "etcd/server" certificate and key
	[certs] etcd/server serving cert is signed for DNS names [e8225f localhost] and IPs [10.196.47.110 127.0.0.1 ::1]
	[certs] Generating "apiserver-etcd-client" certificate and key
	[certs] Generating "sa" key and public key
	[kubeconfig] Using kubeconfig folder "/etc/kubernetes"
	[kubeconfig] Writing "admin.conf" kubeconfig file
	[kubeconfig] Writing "kubelet.conf" kubeconfig file
	[kubeconfig] Writing "controller-manager.conf" kubeconfig file
	[kubeconfig] Writing "scheduler.conf" kubeconfig file
	[control-plane] Using manifest folder "/etc/kubernetes/manifests"
	[control-plane] Creating static Pod manifest for "kube-apiserver"
	[control-plane] Creating static Pod manifest for "kube-controller-manager"
	[control-plane] Creating static Pod manifest for "kube-scheduler"
	[etcd] Creating static Pod manifest for local etcd in "/etc/kubernetes/manifests"
	[wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up to 4m0s
	[apiclient] All control plane components are healthy after 22.002254 seconds
	[uploadconfig] storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
	[kubelet] Creating a ConfigMap "kubelet-config-1.13" in namespace kube-system with the configuration for the kubelets in the cluster
	[patchnode] Uploading the CRI Socket information "/var/run/dockershim.sock" to the Node API object "e8225f" as an annotation
	[mark-control-plane] Marking the node e8225f as control-plane by adding the label "node-role.kubernetes.io/master=''"
	[mark-control-plane] Marking the node e8225f as control-plane by adding the taints [node-role.kubernetes.io/master:NoSchedule]
	[bootstrap-token] Using token: 5ieym7.0br74gn02nnwnslz
	[bootstrap-token] Configuring bootstrap tokens, cluster-info ConfigMap, RBAC Roles
	[bootstraptoken] configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
	[bootstraptoken] configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
	[bootstraptoken] configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
	[bootstraptoken] creating the "cluster-info" ConfigMap in the "kube-public" namespace
	[addons] Applied essential addon: CoreDNS
	[addons] Applied essential addon: kube-proxy
	
	Your Kubernetes master has initialized successfully!
	
	To start using your cluster, you need to run the following as a regular user:
	
	  mkdir -p $HOME/.kube
	  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
	  sudo chown $(id -u):$(id -g) $HOME/.kube/config
	
	You should now deploy a pod network to the cluster.
	Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
	  https://kubernetes.io/docs/concepts/cluster-administration/addons/
	
	You can now join any number of machines by running the following on each node
	as root:
	
	  kubeadm join 10.196.47.110:6443 --token 5ieym7.0br74gn02nnwnslz --discovery-token-ca-cert-hash sha256:ca103b5d852c581700d08a09d94a73a64d24e70f84441abd4c6fb041901536e7
	
root@e8225f:~#


Configure cluster environment for the root user 
==============================================
	
	root@e8225f:~# kubectl get nodes
	The connection to the server localhost:8080 was refused - did you specify the right host or port?
	root@e8225f:~#
	root@e8225f:~#   mkdir -p $HOME/.kube
	root@e8225f:~#   sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
	root@e8225f:~#   sudo chown $(id -u):$(id -g) $HOME/.kube/config
	root@e8225f:~#
	root@e8225f:~# kubectl get nodes
	NAME     STATUS     ROLES    AGE   VERSION
	e8225f   NotReady   master   33m   v1.13.3
	root@e8225f:~#
	root@e8225f:~#

Joining nodes to K8s cluster
==============================

	root@ff302a:~# kubeadm join 10.196.47.110:6443 --token 5ieym7.0br74gn02nnwnslz --discovery-token-ca-cert-hash sha256:ca103b5d852c581700d08a09d94a73a64d24e70f84441abd4c6fb041901536e7
	[preflight] Running pre-flight checks
	[discovery] Trying to connect to API Server "10.196.47.110:6443"
	[discovery] Created cluster-info discovery client, requesting info from "https://10.196.47.110:6443"
	[discovery] Requesting info from "https://10.196.47.110:6443" again to validate TLS against the pinned public key
	[discovery] Cluster info signature and contents are valid and TLS certificate validates against pinned roots, will use API Server "10.196.47.110:6443"
	[discovery] Successfully established connection with API Server "10.196.47.110:6443"
	[join] Reading configuration from the cluster...
	[join] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
	[kubelet] Downloading configuration for the kubelet from the "kubelet-config-1.13" ConfigMap in the kube-system namespace
	[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
	[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
	[kubelet-start] Activating the kubelet service
	[tlsbootstrap] Waiting for the kubelet to perform the TLS Bootstrap...
	[patchnode] Uploading the CRI Socket information "/var/run/dockershim.sock" to the Node API object "ff302a" as an annotation
	
	This node has joined the cluster:
	* Certificate signing request was sent to apiserver and a response was received.
	* The Kubelet was informed of the new secure connection details.
	
	Run 'kubectl get nodes' on the master to see this node join the cluster.
	
	root@ff302a:~#
	
	
  List K8s cluster and node details 
  ====================================
	
	root@e8225f:~# kubectl get nodes -o wide
	NAME     STATUS     ROLES    AGE   VERSION   INTERNAL-IP     EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
	d1079f   NotReady   <none>   14m   v1.13.3   10.196.41.162   <none>        Ubuntu 16.04.5 LTS   4.4.0-142-generic   docker://18.6.1
	e8225f   NotReady   master   50m   v1.13.3   10.196.47.110   <none>        Ubuntu 16.04.4 LTS   4.4.0-128-generic   docker://18.6.1
	ff302a   NotReady   <none>   13m   v1.13.3   10.196.41.58    <none>        Ubuntu 16.04.5 LTS   4.4.0-142-generic   docker://18.6.1
	root@e8225f:~#
  
	Copy the below file from master node to all other nodes 
	========================================================
  /etc/kubernetes/admin.conf  to all other nodes at location $HOME/.kube/config 
	
  Setting up Weave CNI - Container Network Interface
  ==================================================
		root@e8225f:~# kubectl get pods
		No resources found.
		root@e8225f:~#
		root@e8225f:~#
		root@e8225f:~# kubectl cluster-info
		Kubernetes master is running at https://10.196.47.110:6443
		KubeDNS is running at https://10.196.47.110:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
		To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
		root@e8225f:~#
		root@e8225f:~#
		
		root@ff302a:~# export kubever=$(kubectl version | base64 | tr -d '\n')
		root@ff302a:~# kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$kubever"
		serviceaccount/weave-net created
		clusterrole.rbac.authorization.k8s.io/weave-net created
		clusterrolebinding.rbac.authorization.k8s.io/weave-net created
		role.rbac.authorization.k8s.io/weave-net created
		rolebinding.rbac.authorization.k8s.io/weave-net created
		daemonset.extensions/weave-net created
		root@ff302a:~# kubectl get pods
		No resources found.
		root@ff302a:~#
		root@ff302a:~#
		
		Every 1.0s: kubectl get nodes,pods -o wide                                                                                        Wed Feb 13 15:19:10 2019
		
		NAME          STATUS   ROLES    AGE    VERSION   INTERNAL-IP     EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
		node/d1079f   Ready    <none>   69m    v1.13.3   10.196.41.162   <none>        Ubuntu 16.04.5 LTS   4.4.0-142-generic   docker://18.6.1
		node/e8225f   Ready    master   106m   v1.13.3   10.196.47.110   <none>        Ubuntu 16.04.4 LTS   4.4.0-128-generic   docker://18.6.1
		node/ff302a   Ready    <none>   68m    v1.13.3   10.196.41.58    <none>        Ubuntu 16.04.5 LTS   4.4.0-142-generic   docker://18.6.1
```
  
  

2.	Install nginx ingress controller on the cluster. For now, we consider that the user will add public IP of ingress LoadBalancer to their /etc/hosts file for all hostnames to be used. So do not worry about DNS resolution.

```
Test 1 
```
