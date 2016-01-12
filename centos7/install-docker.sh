#!/bin/bash

yum update -y \
  && curl -sSL https://get.docker.com/ | sh \
  && systemctl enable docker.service \
  && systemctl start docker
