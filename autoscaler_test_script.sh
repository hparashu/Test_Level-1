#!/bin/bash

# Stess CPU of the container and HPA will autoscale the PODs
echo -e "==== CPU and Memory Utilization & List of PODs ==== \n"
kubectl top pods -n staging | grep frontend; echo -e "\n"
kubectl get hpa -n staging; echo -e "\n"
podname=$(kubectl -n staging get pods | grep frontend | awk '{print $1;exit}')

# Injecting CPU load in one of the container
echo -e "Injecting CPU load in POD container $podname …..\n"
kubectl -n staging exec $podname --  bash -c "yes > /dev/null 2> /dev/null &"

# Waiting for 5mins after injecting CPU load and then check the CPU load and check if PODs have been autoscaled or not
echo -e "Sleeping for 5mins…..\n"; sleep 5m
echo -e "==== CPU and Memory Utilization & List of PODs ==== \n"
kubectl top pods -n staging | grep frontend; echo -e "\n"
kubectl get hpa -n staging; echo -e "\n"

# Stopping CPU load 
echo -e "Stopping CPU load in POD container $podname …..\n"
kubectl -n staging exec $podname --  bash -c "killall yes"

# Waiting for 5mins after stopping CPU load and then check CPU load has been decreased and PODs have been scaled down 
echo -e "Sleeping for 5mins…..\n"; sleep 5m
echo -e "==== CPU and Memory Utilization & List of PODs ==== \n"
kubectl top pods -n staging | grep frontend; echo -e "\n"
kubectl get hpa -n staging; 