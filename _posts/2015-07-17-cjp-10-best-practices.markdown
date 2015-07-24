---
layout: post
title: "10 Best Practices with CloudBees Jenkins Platform"
modified:
categories:
excerpt: "Getting started with CloudBees Jenkins Platform while following best practices"
tags: [CJP, CloudBees, Jenkins]
comments: true
image:
  feature:
date: 2015-07-17T14:53:02-07:00
---
<figure>
	<a href="http://www.cloudbees.com"><img src="/images/cloudbees-jenkins-enterprise.png"></a>
</figure>
<section id="table-of-contents" class="toc">
  <header>
    <h3>Overview</h3>
  </header>
<div id="drawer" markdown="1">
*  Auto generated table of contents
{:toc}
</div>
</section><!-- /#table-of-contents -->

## CloudBees Jenkins Platform (CJP)?

Organizations small and large, as they are implementing Continuous Delivery, are evaluating various solutions in the market including commercial, open source and hosted solutions. There are benefits to each of those solutions but in this article I will be covering CloudBees Jenkins Platform [^1] which is based on the a popular opensource project (Jenkins).

[Jenkins CI](http://jenkins-ci.org) is an [extremely popular](http://zeroturnaround.com/rebellabs/10-kick-ass-technologies-modern-developers-love/6/) solution in the CI/CD space because its open source and provides well over 1000 plugins to integrate with a variety of tools to automate [CD pipelines](http://udaypal.com/2015-04-08-continuous-delivery-using-jenkins-workflow/).

[CloudBees Jenkins Platform](https://www.cloudbees.com/products/cloudbees-jenkins-platform) is built on top of [Jenkins Open Source](http://jenkins-ci.org) and provides additional capabilities mostly geared towards enterprise use cases like Security, HA, Scalability, Performance, Management, Analytics, Optimization etc... which are critical for organizations. Beyond that CloudBees provides 24 X 7 support which is also important to organizations that are serious about their DevOps / CD implementation and need a support model around it.

In many ways CloudBees has a very similar model as Red Hat that brought Linux to the mainstream and made it the defacto standard for running mission critical workloads today.

## Common CJP related questions

1. What are some of the best practices of CloudBees Jenkins Platform?
2. Where do we start with CJP?
3. What's the reference architecture for CJP?
4. What should a Pilot for CJP include?

We will try and answer all these questions through best practices below. So wether you are starting new or migrating from Jenkins Open Source to CJP or looking for follow the best practices, the follow best practices and reference architecture is the way to go.

## Best Practices

1. Start with CJOC - If HA required, setup
2. Monitoring and Analytics - Alerts, Analytics, Dashboards, Backups
3. Setup RBAC
4. Update center
5. Templates
6. Shared slaves - cleanup used slaves or make sure to label them if certain services are required. Use Docker when there are diverse needs
7. Organize - Folders and views
8. Workflow - Shared Libraries, Checkpoints, Workflow Templates
9.
10.

[^1]: Disclaimer : I am an employee of CloudBees.
