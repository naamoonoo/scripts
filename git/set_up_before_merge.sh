#!/usr/bin/env bash

echo `git rebase dev`
echo `git checkout dev`
echo `git pull --rebase=preserve`
