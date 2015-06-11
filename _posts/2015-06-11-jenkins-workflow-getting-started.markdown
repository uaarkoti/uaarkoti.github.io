---
layout: post
title: "Jenkins Workflow Getting Started"
modified:
categories:
excerpt: "Building a sample end-to-end CD pipeline using Jenkins Workflow"
tags: [Jenkins, Workflow, CD]
image:
  feature:
date: 2015-06-11T00:39:29-07:00
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

In a previous [post](http://udaypal.com/2015-04-08-continuous-delivery-using-jenkins-workflow/) I covered Continuous Delivery (CD) using Jenkins Workflow. This is a followup to show how to get started and build a CD pipleline using Jenkins Workflow.

## Getting started

In this example you'll see how to build, test and deploy a simple java web application. To simulate a real world use, you'll see how to deploy the application to different environments before pushing it to production.

Hopefully this will serve as a template for anyone looking to getting started with Jenkins Workflow and can help build on it.

### Requirements

1. Latest Jenkins 1.580+
2. JDK 1.7+
3. Tomcat 6.0.43+
4. Git client latest (1.9.5+)
5. Maven 3.2+

### Installation

1. [Download and install](http://www.oracle.com/technetwork/java/javase/downloads/index.html) JDK 1.7 or higher
2. [Download](https://jenkins-ci.org/) and [install](https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins) Jenkins
3. [Start Jenkins](https://wiki.jenkins-ci.org/display/JENKINS/Starting+and+Accessing+Jenkins)
4. [Download and install](https://tomcat.apache.org/download-60.cgi) Tomcat 6.0+

### Setup Tomcat

- **Change Default Port** - Make sure Tomcat runs on a [different port](http://www.mkyong.com/tomcat/how-to-change-tomcat-default-port/) than Jenkins. In my example setup, Jenkins is setup to run on port 8080 while Tomcat is setup to run on 8180 on localhost.

Here is a code snippet of the two lines of `$CATALINA_HOME/conf/server.xml` that need to be modified
{% highlight xml %}
<Connector port="8180" protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="8443" />
<Connector port="8109" protocol="AJP/1.3" redirectPort="8443" />
{% endhighlight %}

- **Manage Users** - Tomcat users `$CATALINA_HOME/conf/tomcat-users.xml` file should have `admin` user with roles `admin` and `manager`

{% highlight xml %}
<?xml version='1.0' encoding='utf-8'?>
<tomcat-users>
  <role rolename="tomcat"/>
  <role rolename="role1"/>
  <role rolename="admin"/>
  <role rolename="manager"/>
  <user username="tomcat" password="tomcat" roles="tomcat"/>
  <user username="admin" password="tomcat" roles="admin,manager"/>
</tomcat-users>
{% endhighlight %}

### Setup Jenkins

- **Update plugins** - Make sure you have the latest Workflow plugins by going to Manage Jenkins --> Manage Plugins -> Updates and selecting and `Workflow` related updates. Restart Jenkins after the updates are complete. As of this writing the latest version is 1.6
- **Global libraries Repo** - Jenkins exposes a Git repository for hosting global libraries meant to be reused across multiple CD pipelines managed on the Master. We will setup this repository so you can build on it to create your own custom libraries. If this is a fresh Jenkins Install and you haven't setup this git repository, follow these instructions to setup.

>> Before proceeding to the next steps, make sure your Jenkins instance is running


{% highlight bash %}
git clone http://hostname:port/workflowLibs.git
{% endhighlight %}

From here on, I'll reference the Jenkins Url as `http://localhost:8080`
Output from executing the above command

{% highlight bash %}
git clone http://localhost:8080/workflowLibs.git
Cloning into 'workflowLibs'...
Checking connectivity... done.
warning: remote HEAD refers to nonexistent ref, unable to checkout.
{% endhighlight %}

Lets seed the empty repository with some groovy libraries

{% highlight bash %}
cd workflowLibs
git checkout -b master
mkdir -p src/com/cb/{web,util}
wget -O src/com/cb/web/Tomcat.groovy https://raw.githubusercontent.com/uaarkoti/cd-workflow-global/master/src/com/cb/web/Tomcat.groovy
wget -O src/com/cb/util/BasicUtilities.groovy https://raw.githubusercontent.com/uaarkoti/cd-workflow-global/master/src/com/cb/util/BasicUtilities.groovy
git add .
git commit -am "Added web and util scripts"
git push --set-upstream origin master
{% endhighlight %}

If everything goes fine, you should something like this

{% highlight bash %}
Counting objects: 9, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (4/4), done.
Writing objects: 100% (9/9), 853 bytes | 0 bytes/s, done.
Total 9 (delta 0), reused 0 (delta 0)
remote: Updating references: 100% (1/1)
To http://localhost:8080/workflowLibs.git
 * [new branch]      master -> master
Branch master set up to track remote branch master from origin.
{% endhighlight %}

**NOTE** - In future, if you make any changes to the global libraries, simply commit and push them to the above git repository to be able to use them in your workflow.
{: .notice}

- **Import Job**

{% highlight bash %}
wget -O /tmp/jenkins-cli.jar http://localhost:8080/jnlpJars/jenkins-cli.jar
wget -O /tmp/config.xml https://raw.githubusercontent.com/uaarkoti/cd-workflow-global/master/jobs/web-app-cd.xml
java -jar /tmp/jenkins-cli.jar -s http://localhost:8080 create-job
java -jar /tmp/jenkins-cli.jar -s http://localhost:8081 create-job webapp-workflow < /tmp/config.xml
{% endhighlight %}

This is the actual groovy script of the workflow
{% gist uaarkoti/fe688bdbefa0e8594990 %}

- **Edit Job**

The above instructions should have created a job by name `webapp-workflow` on the Jenkins Master. Edit the job and make sure that the first line `tomcat = new com.cb.web.Tomcat(hostname: "localhost", port: "8180", adminUser: "admin", adminPassword: "tomcat")` reflects the correct information about your tomcat instance.

- **Run Job**
  - At this point you should see a job named "webapp-workflow" on your Jenkins Master.
  - The whole point of this excerise is to see application deployed to production if everything goes well. To simulate that, this job, if run successfully should deploy a sample web applicaiton to staging first (simulated @ `http://localhost:8080/staging`) and when the changes are approved will result in deployment to production (simulated @ `http://localhost:8080/production`).
  - Go ahead and try the staging and production URL's to make sure the application is not deployed there.
  - This is it - Time to see CD in action - Go ahead and build the job by clicking on "Build Now". If everything goes well, the workflow will pause for input shortly. At this point, go ahead and verify the application is actually deployed to staging @ `http://localhost:8080/staging`
  - Click on the `Proceed` or `Abort` button to complete the execution. If you did click on `Proceed` you should be able to see that the application is how deployed to `http://localhost:8080/production`

For reference, the [console logs](https://gist.github.com/uaarkoti/2fe83745d361a261a387) for the execution of this workflow.

### What can you do next?

Go ahead and make changes to the job definition, or to the groovy script. If you make changes to groovy, be sure to commit/push your changes to Global git repo for your changes to be visible to the job.

You could try and move the job definition to an SCM (like github) and use the `Groovy CPS DSL from SCM` option to execute the script. The benefit of this approach is that you can make changes to your job definition without access Jenkins while also keeping the version history of the job.

If you want to be more adventurous use the `Snippet Generator` from the job config page to learn about other Workflow commands and make use of them. For example, setup security in Jenkins to make sure only certain users can approve code promotion to `production`.

You can also try and restart your Jenkins instance while the workflow is running and see the behavior once Jenkins is backup and running.

### Docker Container

For those that simply want to play with the demo, I created a docker container that contains the entire implementation. To run 

{% highlight bash %}
docker run -p 8080:8080 -p 8180:8180 -it uday/workflow-getting-started
{% endhighlight %}

## Summary

Hopefully this gave you a good idea of how to create a Workflow and implement continuous delivery using Jenkins Workflow. The features that were highlighted in this sample are

1. Global shared libraries for code reuse
2. Human interaction
3. Defining multiple stages in your workflow
4. Complex logic (try/catch, parallel jobs, concurrency)
5. Using plugins like Git, Archive,
6. Workflow DSL like `sh`, `echo`, `git`, `archive`, `parallel` etc...
7. Checkpoints - Only for CloudBees Jenkins Enterprise users
8. Visualization - Only for CloudBees Jenkins Enterprise users

## Conclusion

Continuous Delivery is not an easy task but with Jenkins Workflow, you can manage the complexity through use a full blown object oriented programming language. Features like Global shared libraries will help centralize and abstract functionality hiding complexity from developers while encouraging code reuse and best practices.
