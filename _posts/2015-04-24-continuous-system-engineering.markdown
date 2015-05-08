---
layout: post
title: Continuous Systems Engineering (CSE)
modified:
categories:
excerpt: "Continuous Delivery of your Infrastructure As Code"
tags: [Jenkins, Chef, ChefConf2015, Continuous Delivery, CSE]
comments: true
image:
  feature:
date: 2015-04-24T20:12:30-07:00
---
<figure>
	<a href="/images/jenkins-chef.jpg"><img src="/images/jenkins-chef.jpg"></a>
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

<iframe src="//player.vimeo.com/video/127217116" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>

## Configuration Management
Tools like [Chef](http://chef.io), [Puppet](http://puppetlabs.com), [Ansible](http://ansible.com), [Saltstack](http://saltstack.com) help you streamline configuration management of your infrastructure by letting you describe the state of the same as code and enforcing the state in realtime as you commit changes to the code.

## Benefits
Irrespective of the [tool of your choice](http://www.infoworld.com/article/2609482/data-center/data-center-review-puppet-vs-chef-vs-ansible-vs-salt.html) configuration management has [many benefits](http://www.scriptrock.com/blog/5-configuration-management-boss). The focus of this blog though is around your ability to apply the same practices application developers use such as agile development, test driven development and continuous delivery etc... to improve code quality.

## Continuous Code Quality
CI/CD tools such as [Jenkins](http://jenkins-ci.org) help automate repetitive tasks such as linting, unit testing, integration tests required to maintain code quality before deploying code to pre-prod or prod environments. System Engineering (or DevOps teams which ever name you use) responsible for the blueprints of the infrastructure can fully automate testing and deployment of their code to production using the same CI/CD tools.

## CSE Using Jenkins and Chef
Application developers use a variety of different tools at each stage of their SDLC depending on their choice of language, framework and runtime. Depending on your choice of configuration management tools, you will use a different set of tools. In this blog, I will show how to use Chef and related tools in its ecosystem to show how to implement "Continuous systems engineering".

## Getting Started

### Requirements

- CI Tool - Jenkins
- Chef - Configuration Management tool
- VirtualBox - Desktop Virtualization technology
- Vagrant - To easily setup your dev/test environments
- Vagrant Plugins - To help extend vagrant

### Installation

- CI / CD Tool - Jenkins 1.580 or higher
  - Install JDK 7 or higher
  - Install [Jenkins Enterprise by CloudBees](http://nectar-downloads.cloudbees.com/jenkins-enterprise/) or [Jenkins OSS](http://jenkins-ci.org)
  - Start Jenkins (depends on how you installed jenkins)
    - The easiest way is by downloading jenkins.war and executing `$ java -jar /path/to/jenkins.war`
    - On Linux, when installed as a service execute `$ sudo service jenkins start`
- Configuration Management tool - Chef
  - `curl -L http://www.getchef.com/chef/install.sh | sudo bash -s -- -P chefdk`
  - `chef shell-init`
  - `gem install rspec chefspec rspec_junit_formatter`
{% highlight bash %}
  Usage: chef shell-init

`chef shell-init` modifies your shell environment to make ChefDK your default
ruby.

  To enable for just the current shell session:

    In sh, bash, and zsh:
      eval "$(chef shell-init SHELL_NAME)"
    In Powershell:
      chef shell-init powershell | Invoke-Expression

  To permanently enable:

    In sh, bash, and zsh:
      echo 'eval "$(chef shell-init SHELL_NAME)"' >> ~/.YOUR_SHELL_RC_FILE
    In Powershell
      "chef shell-init powershell | Invoke-Expression" >> $PROFILE
{% endhighlight %}

> **NOTE** `chef shell-init` eliminates a lot of heartburn because of ruby incompatibilities and because of hard dependencies of chef on the version of ruby and related binaries

- Virtualization Software - VirtualBox
  - [Install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- Vagrant & relevant plugins
  - [Install Vagrant](http://www.vagrantup.com/downloads)
  - Vagrant Plugins
    - [vagrant-berkshelf](https://github.com/berkshelf/vagrant-berkshelf)
    - [vagrant-chef-zero](https://github.com/schubergphilis/vagrant-chef-zero)
    - [vagrant-omnibus](https://github.com/chef/vagrant-omnibus)
- ChefDK
- Foodcritic (Bundled with ChefDK)

## CSE in Action

### Developing Code
It all starts with writing code and using the right methodologies to support CSE.

- [Use a SCM](http://www.slideshare.net/udaypal1/continuous-integration-43989656/12) (like git) to checkin all your chef code centrally
- [Write tests](http://www.slideshare.net/udaypal1/continuous-integration-43989656/13)
- Enable collaboration and peer code reviewing using tools like [Gerrit](https://code.google.com/p/gerrit/) or [GitHub PullRequests](https://help.github.com/articles/using-pull-requests/#reviewing-proposed-changes)
- Setup Jenkins to automatically trigger jobs whenever code is checked-in to get fast feedback
- Repeat

### Different types of testing
Developers use a variety of tests[^1] to ensure the quality of code but for CSE we will use a subset of those.

[^1]: http://en.wikipedia.org/wiki/Software_testing

1. [Static code analysis](https://www.owasp.org/index.php/Static_Code_Analysis) and lint checking
2. [Unit testing](http://en.wikipedia.org/wiki/Unit_testing)
3. [Integration testing](http://en.wikipedia.org/wiki/Integration_testing)
4. [Smoke testing](http://en.wikipedia.org/wiki/Smoke_testing_(software)) - As applicable

### Lint Testing
We will be using FoodCritic[^2] for static code analysis. Foodcritic is a helpful lint tool you can use to check your Chef cookbooks for common problems.

[^2]: https://foodcritic.io/

It comes with 47 built-in rules that identify problems ranging from simple style inconsistencies to difficult to diagnose issues that will hurt in production.

Here is a way to run FoodCritic and publish the results to jenkins

{% highlight bash %}
if [[ ! -d chef-ci-tools ]]; then
  git clone https://github.com/woohgit/chef-ci-tools.git
fi

cd ${WORKSPACE}

bash chef-ci-tools/bin/chef-foodcritic-publisher.sh -X spec -f any -t "~FC003"
{% endhighlight %}

### Unit Testing

We will be using ChefSpec[^3] for unit testing.

[^3]: https://docs.chef.io/chefspec.html

Use ChefSpec to simulate the convergence of resources on a node:

- Run the chef-client on your local machine
- Use chef-zero or chef-solo
- Is an extension of RSpec, a behavior-driven development (BDD) framework for Ruby
- Is the fastest way to test resources

Here is a way to run ChefSpec and publish the results to jenkins. The assumption is that you have several cookbooks you are testing together (not a single cookbook).

{% highlight bash %}
rm -rf rspec_results
mkdir rspec_results

for cbname in `find cookbooks -maxdepth 1 -mindepth 1 -type d`;
do
  rspec $cbname --format RspecJunitFormatter --out rspec_results/${cbname}-results.xml
done
{% endhighlight %}

### Integration

We're using Minitest for integration testing.

We're spinning up a Vagrant virtual instance. Run chef-solo on it and analyzing the results.

Why using integration tests if we have unit tests? Well to make sure it does what it should do in a clean environment each time.

Here is a way to run minitest and publish the results to jenkins

{% highlight bash %}
cd tests/webserver

vagrant destroy -f
vagrant up

OPTIONS=`vagrant ssh-config | awk -v ORS=' ' '{print "-o " $1 "=" $2}'`

ssh ${OPTIONS} vagrant@127.0.0.1 "sudo chmod -R a+r /var/chef/"

echo "copy strace out.. if any..."
scp ${OPTIONS} vagrant@127.0.0.1:/var/chef/cache/chef-stacktrace.out ${WORKSPACE}/chef-stacktrace.out

echo "copy chef-solo-ci-reports..."
scp -r ${OPTIONS} vagrant@$127.0.0.1:/tmp/chef-solo-ci-reports ${WORKSPACE}/

vagrant destroy -f
{% endhighlight %}

## Quick start
Follow the [installation instructions](#installation) and download the [git repository](https://github.com/uaarkoti/chefconf-2015) to get started.

{% highlight bash %}
$ git clone https://github.com/uaarkoti/chefconf-2015.git
$ java -DJENKINS_HOME=/path/to/jenkins_home -jar /path/to/jenkins.war
$ cd chefconf-2015
$ wget --no-check-certificate http://localhost:8080/jnlpJars/jenkins-cli.jar
$ java -jar ./jenkins-cli.jar -s http://localhost:8080/ create-job cookbooks-lint-check < jenkins_jobs/cookbooks-lint-check.config.xml
$ java -jar ./jenkins-cli.jar -s http://localhost:8080/ create-job cookbooks-unit-tests < jenkins_jobs/cookbooks-unit-tests.config.xml
$ java -jar ./jenkins-cli.jar -s http://localhost:8080/ create-job cookbooks-integration-tests < jenkins_jobs/cookbooks-integration-tests.config.xml
{% endhighlight %}

Browse to `http://localhost:8080` and trigger the `cookbooks-lint-check` job by clicking on `Build now` or wait for 5 minutes for it to trigger automatically. If the `cookbooks-lint-check` is successful you should see it trigger `cookbooks-unit-tests` and that trigger `cookbooks-integration-tests`.

If you prefer to run the [workflow](https://github.com/uaarkoti/chefconf-2015/blob/master/flow.groovy) that contains the end-to-end pipeline you can import the workflow job and trigger the same.

> **NOTE** Make sure you have the latest workflow plugins (`Manage Jenkins -> Manage Plugins -> Update`) before importing / running the workflow job.

{% highlight bash %}
$ java -jar ./jenkins-cli.jar -s http://localhost:8080/ create-job cookbooks-workflow < jenkins_jobs/cookbooks-workflow.config.xml
{% endhighlight %}
