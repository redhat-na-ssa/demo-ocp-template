# Intro

[![Spelling](https://github.com/redhat-na-ssa/demo-ai-gitops-catalog/actions/workflows/spellcheck.yaml/badge.svg)](https://github.com/redhat-na-ssa/demo-ai-gitops-catalog/actions/workflows/spellcheck.yaml)
[![Linting](https://github.com/redhat-na-ssa/demo-ai-gitops-catalog/actions/workflows/linting.yaml/badge.svg)](https://github.com/redhat-na-ssa/demo-ai-gitops-catalog/actions/workflows/linting.yaml)

The intention of this repository is to help support practical use of OpenShift for workloads and provide a collection of configurations / demos / workshops.

Please look at the [GitOps Catalog](https://github.com/redhat-cop/gitops-catalog) if you only need to automate an operator install.

In this repo, look at various [kustomized configs](modules/) and [argo apps](modules/argocd/apps) for ideas.

For issues with `oc apply -k` see the [known issues](#known-issues) section below.

## Prerequisites - Get a cluster

- OpenShift 4.16+
  - role: `cluster-admin` - for all [demo](demos) or [cluster](clusters) configs
  - role: `self-provisioner` - for namespaced components

[Red Hat Demo Platform](https://demo.redhat.com) Options (Tested)

NOTE: The node sizes below are the **recommended minimum** to select for provisioning

- <a href="https://demo.redhat.com/catalog?item=babylon-catalog-prod/sandboxes-gpte.sandbox-ocp.prod&utm_source=webapp&utm_medium=share-link" target="_blank">AWS with OpenShift Open Environment</a>
  - 1 x Control Plane - `m6a.2xlarge`
  - 0 x Workers - `m6a.2xlarge`
- <a href="https://demo.redhat.com/catalog?item=babylon-catalog-prod/sandboxes-gpte.ocp4-single-node.prod&utm_source=webapp&utm_medium=share-link" target="_blank">One Node OpenShift</a>
  - 1 x Control Plane - `m6a.2xlarge`
- <a href="https://demo.redhat.com/catalog?item=babylon-catalog-prod/community-content.com-mlops-wksp.prod&utm_source=webapp&utm_medium=share-link" target="_blank">MLOps Demo: Data Science & Edge Practice</a>

## Getting Started

### Install the [OpenShift Web Terminal](https://docs.openshift.com/container-platform/4.12/web_console/web_terminal/installing-web-terminal.html)

The following icon should appear in the top right of the OpenShift web console after you have installed the operator. Clicking this icon launches the web terminal.

![Web Terminal](docs/images/web-terminal.png "Web Terminal")

NOTE: Reload the page in your browser if you do not see the icon after installing the operator.

Make the enhanced web terminal permanent

```sh
# apply the enhanced web terminal
oc apply -k https://github.com/redhat-na-ssa/demo-ai-gitops-catalog/demos/components/install-web-terminal

# delete old web terminal
$(wtoctl | grep 'oc delete')
```

Enhance the terminal for one time use (ephemeral)

```sh
# bootstrap the enhanced web terminal
YOLO_URL=https://raw.githubusercontent.com/redhat-na-ssa/demo-ai-gitops-catalog/main/scripts/library/term.sh

. <(curl -s "${YOLO_URL}")

term_init
```

NOTE: open a new terminal to full activate the new configuration

---

### ALTERNATIVE - Use a local environment / shell

1. Verify you are logged into your cluster using `oc`.
1. Clone this repository

NOTE: See the [tools section below](#tools) for more info

```sh
# verify oc login
oc whoami

# git clone this repo
git clone https://github.com/redhat-na-ssa/demo-ai-gitops-catalog
cd demo-ai-gitops-catalog

# load functions into a bash shell
. scripts/functions.sh
```

## Apply Configurations / Demos

Setup basic cluster config

```sh
until oc apply -k demo/default; do : ; done
```

## Development

### Tools

The following cli tools are required:

- `bash`, `git`
- `oc` - Download [mac](https://formulae.brew.sh/formula/openshift-cli), [linux](https://mirror.openshift.com/pub/openshift-v4/clients/ocp), [windows](https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/openshift-client-windows.zip)
- `kubectl` (optional) - Included in `oc` bundle
- `kustomize` (optional) - Download [mac](https://formulae.brew.sh/formula/kustomize), [linux](https://github.com/kubernetes-sigs/kustomize/releases)

NOTE: `bash`, `git`, and `oc` are available in the [OpenShift Web Terminal](https://docs.openshift.com/container-platform/4.12/web_console/web_terminal/installing-web-terminal.html)

The following are used to encrypt secrets and are optional:

- `age` - [Info](https://github.com/FiloSottile/age)
- `sops` - [Info](https://github.com/getsops/sops)

### Contributing

Please run the following before submitting a PR / commit

```sh
scripts/lint.sh
```

## Additional Info

### Internal Docs

- [Local Docs](docs)
- [Notes Dump](docs/notes/)

## External Links

General

- [GitOps Catalog](https://github.com/redhat-cop/gitops-catalog)
- [Helm Chart Catalog](https://github.com/redhat-cop/helm-charts)
- [Enhanced Web Terminal Container](https://github.com/redhat-na-ssa/ocp-web-terminal-enhanced)
- [OpenShift - Automation](https://github.com/jharmison-redhat/openshift-setup)

ArgoCD

- [ArgoCD - Example](https://github.com/gnunn-gitops/cluster-config)
- [ArgoCD - Patterns](https://github.com/gnunn-gitops/standards)
