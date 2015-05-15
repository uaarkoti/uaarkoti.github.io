---
layout: post
title: Breaking Builds ... NOT!
modified:
categories:
excerpt: "Improve your developer productivity by eliminating the fear of breaking builds"
tags: [Jenkins, CD, Best Practices, CloudBees]
comments: true
image:
  feature:
date: 2015-05-14T08:17:37-07:00
---
<figure>
	<a href="/images/breaking_builds.jpg"><img src="/images/breaking_builds.jpg"></a>
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

## Scenario
You are working on a new feature that some high profile prospects are waiting for and you have a code freeze by the end of day. This is a highly advertised feature for the next release and you worked really hard on it for weeks. This is the last mile and you have a much deserved week long vacation coming up. You do your due diligence to test your changes regularly locally and everything seems good. You do one last test run and everything looks good. You checkin the code. You pack-up your bags and can almost smell the beach, the turquoise water and a cold beer in your hands.

You land and switch on the phone. You see 26 text messages starting with casual "where are you?" with the last one with some expletive words from your manager.

## Broken builds
The scenario described above might sound like an exaggeration but it happens quite often.

So you broke the build and the release might be at risk because no one else knows enough to fix it in time. Is it possible to avoid this? Good news is that it is quite easy to fix broken builds issue.

### Implications
1. Delayed releases
2. Productivity loss
3. Cost of development

### Tackling broken builds
One of the principles of Continuous Integration is to fail early and [fail fast](http://www.martinfowler.com/ieeeSoftware/failFast.pdf)[^1]. In order to do that few things need to be in place

1. Proper [unit testing](http://en.wikipedia.org/wiki/Unit_testing)
2. [Code coverage](http://en.wikipedia.org/wiki/Code_coverage) part of every build
3. Recreate environment for every build. Don't run builds/tests on developer laptops.
4. Check in code frequently
5. **Don't penalize developers for breaking builds**

I believe developers shouldn't have to worry about breaking builds. It is not productive to add an additional task on developers to make sure their checkin won't break the build.

## Solution

### Meet Validated Merge[^2]

[Validated Merge](https://jenkins-enterprise.cloudbees.com/docs/user-guide-14.5/validated-merge.html) lets developer commit their changes to an intermediate, magical, repository (Jenkins) that triggers a build on Jenkins that will build / test the build and only when successful commits to the upstream repository. If the build fail for whatever reason, the commit is not pushed to the upstream. That way the chance of a checkin causing a failure upstream goes down significantly.

This doesn't not eliminate broken builds completely but reduces them significantly such that developers don't feel intimidated to checkin code changes often for the fear of breaking builds.

> NOTE: [Validated Merge](https://jenkins-enterprise.cloudbees.com/docs/user-guide-14.5/validated-merge.html) is part of Jenkins Enterprise By CloudBees

## Conclusion
Cost of development is constantly going up[^3]. Encouraging developers to focus on writing software while automating testing and providing fast feedback eliminates unplanned work [^4]. Validated Merge eliminates one such unplanned work in your SDLC.

[^1]: http://www.martinfowler.com/ieeeSoftware/failFast.pdf
[^2]: https://www.cloudbees.com/products/jenkins-enterprise/plugins/validated-merge-plugin
[^3]: http://www.cnbc.com/id/101677461
[^4]: http://www.computerworld.com/article/2563263/it-management/unplanned-work-is-silently-killing-it-departments.html
