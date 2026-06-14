#!/bin/bash
echo "=== Configuring kubectl ==="
aws eks update-kubeconfig --region us-east-1 --name project-bedrock-cluster

echo "=== Creating namespace ==="
kubectl create namespace retail-app --dry-run=client -o yaml | kubectl apply -f -

echo "=== Deploying retail app ==="
kubectl apply -f k8s/retail-app/retail-store.yaml -n retail-app
kubectl apply -f k8s/retail-app/ingress.yaml
kubectl apply -f k8s/retail-app/rbac.yaml

echo "=== Mapping bedrock-dev-view to EKS ==="
eksctl create iamidentitymapping \
  --cluster project-bedrock-cluster \
  --region us-east-1 \
  --arn arn:aws:iam::409837635671:user/bedrock-dev-view \
  --username bedrock-dev-view \
  --group system:authenticated

echo "=== Installing ALB Controller ==="
eksctl create iamserviceaccount \
  --cluster=project-bedrock-cluster \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --attach-policy-arn=arn:aws:iam::409837635671:policy/AWSLoadBalancerControllerIAMPolicy \
  --override-existing-serviceaccounts \
  --approve \
  --region us-east-1

helm repo add eks https://aws.github.io/eks-charts
helm repo update
helm upgrade --install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=project-bedrock-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set region=us-east-1 \
  --set vpcId=$(aws ec2 describe-vpcs --region us-east-1 --filters "Name=tag:Name,Values=project-bedrock-vpc" --query "Vpcs[0].VpcId" --output text)

echo "=== Done! ==="
kubectl get ingress -n retail-app
kubectl get svc -n retail-app ui
