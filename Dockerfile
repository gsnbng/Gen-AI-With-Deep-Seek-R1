FROM ubuntu:22.04

## ARG ##
ARG DEBIAN_FRONTEND=noninteractive

ARG pythonVersion=python3


## ENV SETUP ##
ENV systemUser=genai
# genai

RUN apt-get update && apt-get upgrade -y && apt-get install sudo -y 

## STEP-1: Install git ##
RUN apt-get install -y git 

## STEP-2: install python-dev ##
RUN apt-get install -y python3-dev 

## STEP-3: Install setuptools and pip (Python's Package Manager) ##
RUN apt-get install -y python3-setuptools python3-pip 

## STEP-4: Install virtualenv ##
RUN apt-get install -y virtualenv 


## STEP-5: ADD Sudoers ##
RUN adduser --disabled-password --gecos "" $systemUser \
&& usermod -aG sudo $systemUser \
&& echo "%sudo  ALL=(ALL)  NOPASSWD: ALL" > /etc/sudoers.d/sudoers 

## STEP-6: Set Workdir & User ##
USER $systemUser
WORKDIR /home/$systemUser

## STEP-7: install GEN AI ##
RUN sudo apt-get update && sudo apt-get upgrade -y \
&& git clone https://github.com/gsnbng/Gen-AI-With-Deep-Seek-R1.git \ 
&& cd /home/genai/Gen-AI-With-Deep-Seek-R1 && pip3 install requirements.txt \



## STEP-14: EXpose Ports ##
EXPOSE 8999
