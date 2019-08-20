# Docker/kubernetes shortcuts

alias d='docker'
alias k='kubectl'
alias kp='k get pod'
alias dps='d ps'
alias di='d images'
alias dco='docker-compose'
alias dcou="docker-compose up $1"
alias dcod="docker-compose down"
alias dcol="docker-compose logs -f"

alias k8s-prod="gcloud container clusters get-credentials production --region us-east4 --project bbrands-production"
alias k8s-staging="gcloud container clusters get-credentials staging-cluster --zone us-east4-a --project staging-203611"

function dke() {
   containerSearch=${PWD##*/}
   if [ "$1" != "" ]
   then
       containerSearch=$1
   fi

   container=`docker ps | grep web | grep $containerSearch | awk '{ print $1 }' | head -n 1`
   if [ "$container" = "" ]
   then
   container=`docker ps | grep $containerSearch | awk '{ print $1}' | head -n 1`
   fi

   docker exec -it $container su docker
}

function k8spod() {
   if [ "$1" != "" ]
   then
       pod=`kubectl get pod | grep $1 | grep -v Evicted | head -n 1 | awk '{ print $1 }'`
       echo $pod
   fi
}

function k8scontainer() {
   if [ "$1" != "" ]
   then
       container=`kubectl get pods $2 -o jsonpath='{.spec.containers[*].name}' | tr ' ' '\n' | grep $1`
       echo $container
   fi
}

function k8se() {
   cmd='bash';
   if [ "$2" != "" ]
   then
	cmd=$2
   fi

   if [ "$1" != "" ]
   then
       pod=`k8spod $1`
       container=`k8scontainer $1 $pod`
       kubectl exec -it $pod --container=$container $cmd
   fi
}

function k8sl() {
   if [ "$1" != "" ]
   then
       pod=`k8spod $1`
       container=`k8scontainer $1 $pod`
       kubectl logs -f $pod $container
   fi
}

function k8scp() {
   if [ "$1" != "" ]
   then
       pod=`k8spod $1`
       container=`k8scontainer $1 $pod`
       echo "kubectl cp -c $container $pod:$2 $3"
       kubectl cp -c $container $pod:$2 $3
   fi
}


