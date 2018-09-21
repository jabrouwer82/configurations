#!/bin/bash

gr +@vim ~/.vim/bundle/*
gr @vim cat .git/config | grep url | sed "s/.*= \(.*\)/\1/" > vimplugins.txt
