---
layout: post
title: "The Orchestrator, tasks and the executors"
description: "Continuous delivery involves integrating with several tool chains. What does it take to support all the tool chains?"
modified:
categories:
excerpt:
tags: []
image:
  feature:
date: 2015-05-30T23:09:47-07:00
---
## Continuous Delivery Tool Chain
Implementing [Continuous Delivery](http://en.wikipedia.org/wiki/Continuous_delivery) usually involves integrating with your development teams tool chain. In some cases its a single set of tool chain but more often than note there are multiple tool chains to support.

With a growing focus on Continuous Delivery, your engineering teams will be looking for ways to optimize their CD pipelines.

So how does one go about supporting this ever changing landscape of tools and tool chains and have a solution that is future proof?

## The Orchestrator

In order to support this type of complex matrix requirements for CD you'll need a solution that can act as an Orchestrator. So what is an Orchestrator you ask?

An Orchestrator is a component of your CD solution that is responsible for integrating your tool chain and delegating the execution to the individual tools. Lets take an example - Your 


Here are

1. SCM (Git, Mercurial, Perforce etc...)
2. Build (Ant, Maven, Gradle, MSBuild etc...)
3. Code Coverage (Corbetura, JaCoCo, Sonar etc...)
4. Test (JUnit, Selenium, etc...)
5. Bug Tracking (JIRA, BugZilla, Trac etc...)
6. Deployment tools (Chef, puppet, uDeploy, XLDeploy etc...)
7. Deployment platforms (Onpermise, PaaS, Cloud etc...)

These are just a few common areas of integration but the list goes on and on.

### The Orchestrator

### The tasks

### The Executors
