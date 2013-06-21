# App::Sqitch commands to load & dump data
Commands extending `App::Sqitch` for managing data with schema changes

[![Build Status](https://secure.travis-ci.org/dictyBase/App-Sqitch-data.png?branch=develop)](https://travis-ci.org/dictyBase/App-Sqitch-data) [![Coverage Status](https://coveralls.io/repos/dictyBase/App-Sqitch-data/badge.png)](https://coveralls.io/r/dictyBase/App-Sqitch-data)

## Background
* Data management along with schema changes

## Getting started
1. Edit `sqitch.conf` and add following under `[core]`

```yaml
data_dir = data
```
