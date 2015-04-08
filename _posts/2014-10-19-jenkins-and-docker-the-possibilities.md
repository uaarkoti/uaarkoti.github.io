---
layout: post
title: Jenkins and Docker - The possibilities
excerpt: "Benefits of using Docker in continuous delivery using Jenkins"
modified: 2014-10-19
tags: [Jenkins, Docker, Continuous Delivery]
comments: true
---
<figure>
	<a href="http://jenkins-ci.org"><img src="/images/Jenkins_Docker.png"></a>
</figure>

## Cost of delays
At a time when every millisecond delay has an [impact on revenue](https://news.ycombinator.com/item?id=273900), enterprises are constantly looking for ways to automate and optimize their applications and/or services to minimize the impact of a change while also making sure they provide a steady stream of feature enhancements to stay ahead of their competition.

## Automation is the key
In that vein, enterprises, small and big alike, are looking for ways to fully automate their software delivery process. DevOps, continuous delivery, continuous integration, continuous deployment are all terms used to describe these efforts by people and organizations to achieve a higher degree of automation.

## Continuous Delivery
Significant number of these enterprises have already [adopted Jenkins](http://zeroturnaround.com/rebellabs/10-kick-ass-technologies-modern-developers-love/6/) for [Continuous Integration](http://en.wikipedia.org/wiki/Continuous_integration) (CI), a necessary step in implementing [Continuous Delivery](http://en.wikipedia.org/wiki/Continuous_delivery) (CD).

## Containers
Docker, on the other hand, is a platform for building and running distributed applications and is revolutionizing the way applications are built and deployed in a complex multi-tiered environments. Docker, while still in its nascent stage, offers several advantages over traditional ways of building and deploying applications.

## Advantages 
While each of these technologies have their own benefits in software delivery process, together they can provide a more

* **Consistent** - The most important part of building a CD pipeline is how consistently one can build the pipeline so it is easy to create and maintain. Complexity in a pipeline results in unplanned work that is hard to automate and requires human intervention. A good CD pipeline is one that can self heal or provide accurate data so appropriate measures can be taken.
* **Replicable** - Replicate the implementation from one environment to another or from one project to another or one team to another. Lower barrier to entry for new environments, projects and teams to achieve CD.
* **Portable** - Jenkins and Docker are supported on most popular operating systems. Adding support for new OS's becomes a trivial task.
* **Cost effective** - Docker's optimal use of IT resources, compared to traditional virtualization technologies, and Jenkins plugins ecosystem (1000+ plugins integrating with most common tools required during SDLC needing minimal to no customizations) make them very cost effective.
ways to achieving continuous delivery.

## Benefits
So, how can you benefit from this integration between Jenkins and Docker? Here are some use cases of how you can leverage Jenkins and Docker in your continuous delivery process

* **[On Demand Slaves](https://developer.jboss.org/people/pgier/blog/2014/06/30/on-demand-jenkins-slaves-using-docker)** - Jenkins uses build slaves to execute all the jobs. In a typical environment these build slaves are static, i.e a fixed set of VM's or hardware is dedicated to slaves. With Docker, these slaves can be configured dynamically thus getting better utilization from the underlying hardware.
* **[Repeatable Deployments](http://blog.buddycloud.com/post/80771409167/using-docker-with-github-and-jenkins-for-repeatable)** - Every code commit triggers a Jenkins CD pipeline that ends with a new Docker image in the docker repository and Docker containers being deployed in appropriate environments (QA, Staging, Production) as defined in the CD pipeline.
* **[Ephemeral resources](http://www.activestate.com/blog/2014/01/using-docker-run-ruby-rspec-ci-jenkins)** - Some steps in CD pipeline require a clean environment, particularly test, and resources for the duration of the steps. Having the ability to spin up these resources quickly to run through the steps and destroy them immediately after is very efficient and effective use of resource.  
* **Elastic scaling** - Sometimes its hard to know how many instances of a single application/service are required for a certain task. For ex: Maintaining 1sec SLA under peak load. Stress tests tests limits of an application but its hard to predict the application performance every time a change is made. Having the ability to spin up instances on demand takes the guess work out of the equation when automating these types of tasks.

These are just some ways of leveraging the existing integration between Jenkins and Docker but not the only ways. I believe there will be more and more [integrations](http://www.ebaytechblog.com/2014/05/12/delivering-ebays-ci-solution-with-apache-mesos-part-ii/#.VENjX4eslbw) between the two that may or may not fall into a standard pattern but something that is very unique to a specific environment. Either way Jenkins is extremely flexible and provides several plugins (listed below) to integrate with Docker. If there are use cases that none of these plugins can address, you can [write your own plugin](https://wiki.jenkins-ci.org/display/JENKINS/Plugin+tutorial).

###Jenkins Docker integration plugins

1. **Dynamic Jenkins Slaves** - The aim of the docker plugin is to be able to use a docker host to dynamically provision a slave, run a single build, then tear-down that slave
2. **Build and manage Docker images / containers** - This plugin allows to add various docker commands into you job as a build step
3. **Build / Publish Docker images** - This plugin provides the ability to build projects with a Dockerfile, and publish the resultant tagged image (repo) to the docker registry
4. **Integration with DockerHub** - This plugin offers integration with DockerHub, using dockerhub hook to trigger Jenkins job to interact with docker image and implement continuous delivery pipelines based on Docker

Are you using Jenkins and Docker? If yes, please leave a comment and share your experience.
