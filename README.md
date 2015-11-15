# Vagrant Ansible Nagios #
This project allows to set up environment on a Vagrant box VM with a monitoring system, a web server and a simple application. System monitors certain application parameter with alerting enabled when parameter exceeds certain threshold.

### Stack of technologies: ###
Following technologies were choosen for task implementation:

1. **Ubuntu 14.04** - operation system
2. **Apache2** - web server
3. **Nagios3** - monitoring system
4. **Bottle Py** - Python framework as a simple application
5. **SSL** - cryptographic protocol

### Preconditions: ###
To get started you should check that following preconditions on your local PC are met

#### Hardware: ####
**"Virtualization"** option is enabled in BIOS setup

#### Software: ####
Next tools should be installed:

1. **Virtual Box** - tool for virtualization
2. **Vagrant** - tool for virtualization
3. **Ansible** - configuration management tool for provisioning
4. **Locust** - load testing tool

If you don't have these tools and you have Debian or RHEL 6.x you can simple install all needed preconditions running:

    sudo ./install_env_preconditions.sh

### Workflow: ###

1. Run **"install_env_preconditions.sh"** script (optional)

2. Run command:

    `vagrant up`

3. After testing environment deployment open next links:

    * [HTML page](http://localhost:3333 "HTML page") - this is a simple HTML page for Apache server testing
    * [Nagios](https://localhost:4444/nagios3/ "Nagios3") - Nagios monitoring system via SSL
    * [Application](https://localhost:4444/app/loadavg "Load avg app") - Simple Application which returns system load average per one minute. Here is implemented a reverse proxy from web server.

4. Credentials for Nagios:
    * login: **nagiosadmin**
    * pass: **nagiosadmin**

5. New plugin services added to Nagios:
    * **APPLICATION** - simple Application monitoring
    * **LINUX STATS CPU** - CPU monitoring
    * **LINUX STATS DISK** - Disk monitoring
    * **LINUX STATS PROCESS** - Processes monitoring

6. Stress testing uses Locust framework to simulate the load of clients and requests. Application Nagios plugin measures system load average per one minute and checks next ranges:
    * **OK** - from 0.00 to 0.05
    * **WARNING** - from 0.05 to 0.1
    * **CRITICAL** - from 0.1 and above

7. Run stress test using Locust wrapper with 100 numbers of clients and 5 rates per second in which clients are spawned by default:

    `./stress_testing.sh`
    

8. Also you can specify number of concurrent clients and rates per second:

    `./stress_testing.sh [CLIENTS] [HATCH-RATE]`

9. Please keep in mind that Nagios plagin updates every few minutes so there may be delays



