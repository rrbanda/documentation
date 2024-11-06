---
title: Install Instructions
draft: false
tags:
  - infra
---

# Introduction
Below are the instructions for deploying the v2 version of Composer AI. This an evolving document, and your feedback is greatly appreciated.  For questions or concerns, reach out to the [#proj-rhcai-general](https://redhat.enterprise.slack.com/archives/C07DZB40LAH) slack channel
# Composer AI Setup
Fork the following repos:

https://github.com/jland-redhat/ai-accelerator

https://github.com/redhat-composer-ai/appOfApps
## Configuring the correct clusterDomain

Update the cluster domain to point to your cluster domain.  There are two spefic places you need to do this at

**here:** https://github.com/redhat-composer-ai/appOfApps/blob/main/appOfApps/values.yaml#L16

and **here:** https://github.com/jland-redhat/ai-accelerator/blob/composer-updates/tenants/composer-ai/app-of-apps/base/patch-app-of-apps.yaml

## AI Accelerator Repo
Use Branch: **composer-updates**
Replace the following to point to your **App of Apps** forked repository:

https://github.com/jland-redhat/ai-accelerator/blob/composer-updates/tenants/composer-ai/app-of-apps/base/app-of-apps-application.yaml#L14
# Install
Run Bootstrap in the AI Accelerator Repo, inserting your base domain:
./bootstrap.sh --bootstrap_dir=rhoai-fast-aws-gpu --ocp_version=4.16 --update_base_domain=<insert_base_domain> -f

# Secrets
This is an area we need to improve.  You will need to create three secrets that Composer AI will need to run.  

1. huggingface api key
    - to pull models from huggingface
2. DataSciencePipelineApplication secret
    - to run the ingestion pipeline
3. a dataconnection to an s3 bucket
    - to connect to an s3 compatable object storage containing the model which you wish to run

# Ingestion Pipeline
1. Run the Ingestion Pipeline
   - Makes sure to wait til both the pod `document-ingestion-xxx-xxx` finishes running before the index is populated. Takes a while
   - The second one where you start seeing logs that look like this `Uploading document to collection red_hat_openshift_ai_self_managed_en_US_2_8`
2. Delete the UI Deployment (in order for it to pull the new image)

