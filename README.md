# google-cloud-run-identity
https://www.jhanley.com/google-cloud-run-identity

Repository for my article: Google Cloud Run - Identity

Introduction

Sometimes your Google Cloud Run app needs to communicate with or consume other services. This can be a simple as reading an object in Cloud Storage, sending an email, or connecting to a database. What identity does Cloud Run use? Can I change the identity? How do I use this identity to security my services?

In this article, I will cover these questions. We will create a service account, create and lock down a Cloud Storage Bucket, encrypt our secrets with Cloud KMS and deploy a Cloud Run instance that securely gets and decrypts secrets from Cloud Storage.

The default Cloud Run Identity is the Compute Engine Default Service Account. Unless you have changed this service account, it has the roles/editor permissions. This role has vast permissions across the Google Cloud Platform. This service account is also shared with other services such as Compute Engine and Cloud Functions.

In the latest Cloud Run Alpha release, Google has added a new command-line option --service-account. This option allows you to specify a service account to use as the Cloud Run identity. This means you can use a different identity for each of your Cloud Run services. This is a big feature for Cloud Run. You need not create and download keys for this service account. No key leakage or management. This is inherently powerful and secure.

When storing parameters and secrets, it is very important to limit who/what can access these secrets. By using a unique identity, you can lock down and secure access to secrets.

This article just touches upon Cloud Run Identity. Other Google Cloud services, such as Pub/Sub, can use the Cloud Run Identity for authorization. You can also use this identity in your calls to your own services. In another article, I will discuss the low-level details of Cloud Run identity and how to verify identities.
