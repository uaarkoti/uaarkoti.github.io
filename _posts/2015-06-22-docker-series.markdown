---
layout: post
title: "A Continuous Delivery Beginners Guide, Part 1"
modified:
categories:
excerpt:
tags: []
comments: true
image:
  feature:
date: 2015-06-22T19:04:39-07:00
---
<figure>
	<a href="http://jenkins-ci.org"><img src="/images/Jenkins_Docker.png"></a>
</figure>

This is the first of a six-part series on building cost effective, scalable Continuous Delivery system using Jenkins.

It was not by choice but I ended up working for a variety of Telco companies (startups to the giants) early in my carrier and one the first thing I observed is that making changes to these systems was not an easy task because of the scale, impact, cost, risk and state of tools. New releases were huge events that everyone in the organization knew about from Dev, QA, Operations, Marketing, Sales and beyond. Delays in releases were not measured in days or weeks but months.

Fast forward to today. Releases are now done in months, weeks, days or even multiple times a day. Anyone releasing less frequent than a few months will fade away while their competition will start eating away their market share with new features, having a better understanding of their customer base and releasing more frequently.

A few examples that come to mind are Blockbuster vs Netflix, MapQuest vs Google Maps.

In this article, the first of six, we will look at the culture

## Traditional Methods

All the Telco's and others alike, used [Waterfall methodology](https://en.wikipedia.org/wiki/Waterfall_model) to build software.

"A culture is a way of life of a **group of people** --the behaviors, beliefs, values, and symbols that they accept, generally **without thinking** about them"


In this series of posts, I'll show you how to leverage the newly released [plugins from CloudBees](https://www.cloudbees.com/continuous-delivery/jenkins-docker) to build the next generation of CD pipelines to take advantage of integration of these two complementing technologies.

## Integration Points

As I mentioned in my earlier [post](http://udaypal.com/jenkins-and-docker-the-possibilities/) there are several integration points and in each of the posts, we will dig deeper into each

1. Docker Hub Notification
2. Docker Traceability
3. Build and Publish docker images
4. Build in Docker Slaves
5.

## References

[1] http://info.thoughtworks.com/putting-continuous-delivery-into-practice-slideshare.html
[2] https://www.chef.io/blog/chefconf-talks/creating-a-culture-for-continuous-delivery-john-esser/
[3] http://blogs.atlassian.com/tag/cd-skeptics/
