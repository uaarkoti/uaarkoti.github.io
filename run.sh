#!/bin/bash

# This works on mac only
open http://localhost:4000

bundle exec jekyll serve --config _config.yml,local.yml
