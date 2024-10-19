---
title: Infrastructure Overview
draft: false
tags:
  - infra
---

# Architecture

> [!Note]
> Some of the Architecture below includes future plans, where noted

## Overview

![[Base Architecture.drawio.png]]

**[[Chatbot UI/Overview|Chatbot UI]]:** Is the front end user interface of our application created using Next.JS

**[[EmbeddingService]]:** Backend service used for prompt engineering when communicating with the vLLM runtime

**vLLM:** Our Model Runtime served with OpenAI (Kube Objects created with ArgoCD but mocks the Open AI Serving Methods)
> [!Info]
> Currently we have two LLM runtimes we are using. 
> 
> The Ollama runtime can use CPUs but is slow. It is currently deployed as part of the App of Apps.
> 
> The vLLM runtime requires GPUs but is very fast. This runtime will be a centralized or series of centralized instances 

**[[Infrastructure/Supabase/Overview|Supabase]]:** A series of microservices backed by a Postgre DB used for data storage/authentication/etc. This is an Opensource alternative to Firebase

## Authentication Flow

![[Auth Flow Architecture.drawio.png]]
Our authentication currently only allows users with a `@redhat.com` email address and uses Googles oAuth server directly, but there are future plans for using Keycloak.

It should also be noted that our API gateway (Kong) is not included in this diagram but all request to all Supabase Services flow through the API gateway.

> [!Note]
> The team disabled JWT authentication through Kong due to implementation issues during the dev process. It would be a good idea to reenable Kong's auth (the code commented out  [here](https://gitlab.consulting.redhat.com/redprojectai/infrastructure/appdeploy/-/blob/main/supabase/configs/kong.yaml?ref_type=heads#L94)) and put all services behind this API gateway to prevent unauthorized calls

## Chat Flow

![[Chat Architecture.drawio.png]]

The Chat Flow:

* Request Model Info from the vLLM Runtime
	* This populates the list of "In-Cluster" models the top right dropdown
* User types prompt
* Prompt is sent to `/chat` endpoint in the embedding service
* Embedding Service uses the model to create a "Sanitized Question" that is better understood by the Model
* Embedding Service uses builtin promp engineering to inject extra context in order to return a more appropriate answer
* Embedding Service request response from Model
* Embedding Service streams response to Chat UI
> [!Important]
> This flow has not yet been implemented


## RAG Flow

![[RAG Architecture.drawio.png]]

The Rag Flow works similarly to the chat flow with a few notable exceptions:
* Chat UI passes [[Creating Assistants|Assistant]] data
* Embedding Service queries the Vector DB based on the information from the Assistant
* Embedding Service includes results from Vector DB in vLLM query
