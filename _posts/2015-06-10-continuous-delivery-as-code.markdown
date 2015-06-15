---
layout: post
title: "Continuous Delivery As Code"
modified:
categories:
excerpt: "End to End Continuous Delivery can potentially involve complex processes that are hard to implement with simple constructs. With Jenkins Workflow its possible to treat Continuous Delivery as yet another development effort with full blown programming capabilites to handle complex scenarios."
tags: []
image:
  feature:
date: 2015-06-10T22:29:42-07:00
---
<section id="table-of-contents" class="toc">
  <header>
    <h3>Overview</h3>
  </header>
<div id="drawer" markdown="1">
*  Auto generated table of contents
{:toc}
</div>
</section><!-- /#table-of-contents -->

## Scenario

Continuous Delivery by definition is an end-to-end process of taking code through several iterations and stages (from development, QA, staging, UAT) before releasing it to production. Deploying software to production in realtime in itself could be a fairly complex process depending on the type of approach used. There should also be additional checks and balances in place to ensure that what is released to production is performing as expected. Failure is part and parcel of CD so there should be measures in place to be able to recover from the failures either by reverting to a last known stable release or through some other proven mechanism automatically.

## What's the complexity?

1. Infrastructure
  - Operating Systems - OS - Linux, Windows, Mac
  - Virtualization - VMware, KVM, Zen
  - Infrastructure as a Service (IaaS)
    - Public - AWS, Azure
    - Private - OpenStack, vCloud
  - Platform as a service (PaaS) - Openshift, CloudFoundry
  - Containers - Docker, Rocket
  - Configuration Management - Puppet, Chef, Ansible, Saltstack
2. Programming
  - Languages - Java, .NET, C/C++, Ruby, Python, Php, Javascript
  - Testing Frameworks - Selenium, JUnit, TestNG
  - Code coverage - Jacoco, Corbetura, Sonar
  - Bug tracking - JIRA, BugZilla, ServiceNow, IssueTrac
  - Build tools - Ant, Maven, make, MSBuild
3. Source Control Management
  - Git, GitHub, SVN, Mercurial, Perforce, Stash
4. Binary Repository
  - Artifactory, Nexus, filesystem

The biggest challenge with the above is being able to handle the sheer number of choices developers and IT departments have while at the sametime not compromising and being flexible to adopt newer technologies as they mature. In otherwords, being future proof while supporting today's cutting edge technologies.

## Jenkins to the rescue

Jenkins popularity and its [plugin architecture](https://wiki.jenkins-ci.org/display/JENKINS/Extend+Jenkins) made it extremely easily for developers to adopt and extend supporting a [wide variety](https://wiki.jenkins-ci.org/display/JENKINS/Plugins#Plugins-Pluginsbytopic) of tools in their CI automation.

Irrespective of the programming language or the tool chain developers chose for their SDLC, Jenkins provided a good set of choices for implementing CI. As a next steps developers are not looking to extend those capabilities to CD.

## Jenkins Workflow

Jenkins Workflow was created with [CD in mind](http://www.networkworld.com/article/2919563/software/how-workflow-capabilities-benefit-continuous-delivery-environments.html) while addressing some of the [limitations / gaps](http://localhost:4000/2015-04-08-continuous-delivery-using-jenkins-workflow/#problem) in Jenkins core to support use cases necessary to implement CD.

### Jenkins Workflow Advantages

1. Single Job to describe entire CD pipeline
2. Support Complex logic incuding for-loops, if-then-else, try-catch, fork-join etc…
3. Ability to surive restart
4. Support Human interaction for approval/input
5. Dynamic allocation of resources
6. Version control and manage your workflows
7. Ability to start from a safe point - Checkpoints
8. Visualize workflow executions
9. Modularize workflows &
10. Code reuse
