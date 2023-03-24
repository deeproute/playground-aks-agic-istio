# AKS with Azure Application Gateway (With AGIC) traffic forwarded to Istio Ingress
## Setup

### Deploy
```sh
cd terraform

# Make sure you change the tfvars to your needs
terraform init
terraform apply
```

### Deploy Istio

Follow the official documentation on installing istio. Make sure you install the `istio gateway` so you can configure the Istio's services to link the AGIC Ingress to.
The Istio service can be a `ClusterIP` since its not going to be accessed outside the cluster. The way App GW connects is by the pod ips directly and not by the service itself. You can verify this when you open the backend pools in Azure Portal after AGIC Add-on is enabled in the AKS Cluster and created all resources mentioned below.

### Deploy a sample app

From the root folder of this repo:

```sh
k create ns test-app

k label namespace test-app istio-injection=enabled --overwrite
k apply -f app/.
```

### Install istio's AddOns to monitor the traffic in kiali

```sh
git clone git@github.com:istio/istio.git
cd istio

k apply -f samples/addons/prometheus.yaml
k apply -f samples/addons/kiali.yaml
```

### Deploy a sample app

From the root folder of this repo:

```sh
k create ns test-app

k label namespace test-app istio-injection=enabled --overwrite
k apply -f app/.
```

## References

- [Istio Ingress Health Check](https://github.com/istio/istio/issues/9385#issuecomment-466788157)
- [Example deployment of App GW and Istio](https://itnext.io/using-application-gateway-waf-with-istio-315b907b8ed7)
- [Example code for App GW Module](https://github.com/aztfm/terraform-azurerm-application-gateway/blob/main/main.tf)
- [Enable application gateway ingress controller add-on for an existing AKS cluster with an existing application gateway](https://learn.microsoft.com/en-gb/azure/application-gateway/tutorial-ingress-controller-add-on-existing)
- [App GW TLS Termination](https://learn.microsoft.com/en-us/azure/application-gateway/ssl-overview)