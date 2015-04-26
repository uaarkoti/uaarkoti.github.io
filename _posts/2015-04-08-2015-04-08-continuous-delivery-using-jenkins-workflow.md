---
layout: post
title: Continuous Delivery using Jenkins Workflow
modified: 2015-04-08
categories:
excerpt: "Building complex CD pipeline using Jenkins Worflow"
tags: [Jenkins, Docker, Continuous Delivery]
comments: true
image:
  feature:
date: 2015-02-08T12:29:05-07:00
---
<figure>
	<a href="/images/cd-custom-2.jpg"><img src="/images/cd-custom-2.jpg"></a>
</figure>

## Continuous Integration
Cruise Control, Hudson, Jenkins ... if you are familiar with any of those names as it relates to [Continuous Integration](http://en.wikipedia.org/wiki/Continuous_integration) then you know that developers have been trying to automate their builds for over a decade now. For the most part, developers have been successful in building basic automation and are now trying to push it further beyond development environments. That typically means automating their unit, regression, functional, integration testing and potentially promoting/deploying to higher environments and eventually pushing code to production in an automated way.

### Jenkins CI
[Jenkins has played a major role](http://zeroturnaround.com/rebellabs/10-kick-ass-technologies-modern-developers-love/6/) in it with over 1000+ plugins giving the developers a variety of choices and integration with tools they use throughout their SDLC. Now developers are looking to extend their use of Jenkins beyond CI and towards CD.

## Continuous Delivery
Many organizations are implementing [Continuous Delivery](http://en.wikipedia.org/wiki/Continuous_delivery) (CD) with a goal to completely automate their software delivery process. There are many ways to implement CD using Jenkins. You could use the traditional [Job Chaining](http://zeroturnaround.com/rebellabs/how-to-use-jenkins-for-job-chaining-and-visualizations/) method or you could use specific plugins such as the [Build Flow plugin](https://wiki.jenkins-ci.org/display/JENKINS/Build+Flow+Plugin) and add some visualization to it using plugins such as [Build Pipeline](https://wiki.jenkins-ci.org/display/JENKINS/Build+Pipeline+Plugin), [Delivery Pipeline](https://wiki.jenkins-ci.org/display/JENKINS/Delivery+Pipeline+Plugin) & [Build Graph View](https://wiki.jenkins-ci.org/display/JENKINS/Build+Graph+View+Plugin).

<figure class="half">
  <figcaption>Job Chaining & Build Pipeline</figcaption>
  <a href="/images/job-chaining.jpg"><img src="/images/job-chaining.jpg"></a>
  <a href="/images/build-pipeline.jpg"><img src="/images/build-pipeline.jpg"></a>
</figure>
<figure class="half">
  <figcaption>Build Flow & Build delivery</figcaption>
  <a href="/images/build-flow.jpg"><img src="/images/build-flow.jpg"></a>
  <a href="/images/build-delivery.jpg"><img src="/images/build-delivery.jpg"></a>
</figure>

## Problem
While all of these plugins have been used to varying degree of success, each have their own strengths and weaknesses. We won't necessarily go into the details but at a high level these are some of the short comings amongst these plugins

* **Non Sequential Logic** - Support things like loops, try/catch block when invoking other jobs/steps
* **Surive Outages** - Ability to continue after network or service outages or manual reboots
* **Manual Steps** - Support human interaction as part of the pipeline
* **Reusability** - Reduce duplication and provide ways to reuse logic among different pipelines
* **Comprehensive Scripting** - Very easy and concise scripting support

## Solution
[Jenkins Workflow](https://github.com/jenkinsci/workflow-plugin) was built from ground up to provide users a way to address all the above limitations and support features such as

1. **Single Job** - Entire CD Pipeline in a single workflow (or job)
2. **Complex logic** - Support complex logic like for-loops, if-then-else, try-catch, fork-join etc...
3. **Survive restarts** - While the workflow is running
4. **Human approval/input** - Integrated human interaction into the workflow
5. **Allocate resources** - Dynamically allocate slaves and workspaces
6. **Versioning** - Supports checking workflow into version control system
7. **Checkpoints** - CloudBees feature to be able to resume from a safe point
8. **Visualization** - Stage view of workflow

<figure class="half">
  <figcaption>Stage View & Running Steps</figcaption>
  <a href="/images/wf-stage-view.jpg"><img src="/images/wf-stage-view.jpg"></a>
  <a href="/images/wf-run-steps.jpg"><img src="/images/wf-run-steps.jpg"></a>
</figure>

### Sample Workflow
{% highlight groovy %}

// Run this part of the job on a node with a name or label of 'linux-64bit'
node('linux-64bit') {

    // Checkout my source
    git url: '/var/lib/jenkins/workflow-plugin-pipeline-demo'

    // Set a particular maven install to use for this build
    env.PATH="${tool 'Maven 3.x'}/bin:${env.PATH}"

    // Start 'Dev' stage
    stage 'Dev'

    // Execute maven build
    sh 'mvn -o clean package'

    // Archive the artifacts from the above build
    archive 'target/x.war'

    stage 'QA'

    // Start two tests (longerTests, quickerTests) in parallel
    parallel(longerTests: {
        runWithServer {url ->
            sh "mvn -o -f sometests/pom.xml test -Durl=${url} -Dduration=30"
        }
    }, quickerTests: {
        runWithServer {url ->
            sh "mvn -o -f sometests/pom.xml test -Durl=${url} -Dduration=20"
        }
    })

    // Start a new stage and make sure only one build can enter this stage
    stage name: 'Staging', concurrency: 1

    // Call deploy function defined below
    deploy 'target/x.war', 'staging'
}

// Wait for human interaction
input message: "Does http://localhost:8080/staging/ look good?"

// Start a try catch block
try {
    /**
     * Assuming significant time was spent up until this point, establish a
     * safe point so this build can be run from here if this build fails after
     * this.
     */
    checkpoint('Before production')
} catch (NoSuchMethodError _) {
    // Since Checkpoints is a feature of CloudBees jenkins enterprise, log it
    // and continue with the rest of the workflow
    echo 'Checkpoint feature available in Jenkins Enterprise by CloudBees.'
}

stage name: 'Production', concurrency: 1

// Run this part of the job on a node with name or label of 'windows-32bit'
node('windows-32bit') {

    // Exceute a command
    sh 'wget -O - -S http://localhost:8080/staging/'
    unarchive mapping: ['target/x.war' : 'x.war']
    deploy 'x.war', 'production'
    echo 'Deployed to http://localhost:8080/production/'
}

/**
 * Function to deploy artifacts
 */
def deploy(war, id) {
    sh "cp ${war} /tmp/webapps/${id}.war"
}

/**
 * Function to undeploy artifacts
 */
def undeploy(id) {
    sh "rm /tmp/webapps/${id}.war"
}

/**
 * Function to create a random Id for testing
 */
def runWithServer(body) {
    def id = UUID.randomUUID().toString()
    deploy 'target/x.war', id
    try {
        body.call "http://localhost:8080/${id}/"
    } finally {
        undeploy id
    }
}
{% endhighlight %}

## Next
In following blog post, I'll share more on how you can get started with Jenkins Workflow
