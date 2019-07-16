#!/bin/bash

# Install docker & k8s cluster


apt-get update
apt-get install -y git wget 
apt-get install \
	apt-transport-https \
	ca-certificates \	
	curl \  
	software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository 
	\"deb [arch=amd64] https://download.docker.com/linus/ubuntu \
	$(lsb_release -cs) \
	stable"
apt-get update
apt-get install -yq docker.io
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - 

sudo cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/  kubernetes-xenial main
EOF

sudo apt-get update -y 
sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni
sudo sysctl net.bridge.bridge-nf-call-iptables=1

kubeadm init --apiserver-advertise-address 10.196.47.110

# Configure cluster environment for the root user 
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl get nodes

# Install Weave Net - CNI
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$kubever"

# Creating the Service Account, and the Ingress Controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/mandatory.yaml

# Create ingress controller service as a load balancer service:
kubectl apply -f cloud-generic.yaml
kubectl get svc -n ingress-nginx

# Install guest-book application on both namespaces.
git clone https://github.com/kubernetes/examples.git

# Creating Redis Master and Slave services 
kubectl apply -f redis-master-deployment.yaml -f redis-master-service.yaml -n staging 
kubectl apply -f redis-slave-deployment.yaml -f redis-slave-service.yaml -n staging
kubectl apply  -f frontend-deployment.yaml -f frontend-service.yaml -n staging
kubectl get pods,service -n staging
kubectl apply -f redis-master-deployment.yaml -f redis-master-service.yaml -n production 
kubectl apply -f redis-slave-deployment.yaml -f redis-slave-service.yaml -n production
kubectl apply  -f frontend-deployment.yaml -f frontend-service.yaml -n production
kubectl get pods,service -n production

# Expose staging application on hostname staging-guestbook.mstakx.io
kubectl apply -f staging-frontend-ingress.yaml -f production-frontend-ingress.yaml
kubectl get Ingress -n staging
kubectl get Ingress -n production 

# Implement a pod autoscaler 
kubectl apply -f staging-autoscale.yaml
kubectl get hpa -n staging

kubectl apply -f production-autoscale.yaml
kubectl get hpa -n production 















