# Project-1

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![diagram](Diagrams/Diagram%20Robinson%20Dinh.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the .yml file may be used to install only certain pieces of it, such as Filebeat.

  - Enter the playbook file.

~~~
---
- name: Configure Elk VM with Docker
  hosts: elk
  remote_user: azadmin
  become: true
  tasks:
    - name: Install docker.io
      apt:
        update_cache: yes
        force_apt_get: yes
        name: docker.io
        state: present

    - name: Install python3-pip
      apt:
        force_apt_get: yes
        name: python3-pip
        state: present

    - name: Install Docker python module
      pip:
        name: docker
        state: present

    - name: Use more memory
      sysctl:
        name: vm.max_map_count
        value: "262144"
        state: present
        reload: yes

    - name: download and launch a docker elk container
      docker_container:
        name: elk
        image: sebp/elk:761
        state: started
        restart_policy: always
        published_ports:
          - 5601:5601
          - 9200:9200
          - 5044:5044

    - name: Enable service docker on boot
      systemd:
        name: docker
        enabled: yes
~~~

This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.
- What aspect of security do load balancers protect? What is the advantage of a jump box?
   - The Load Balancer serves as a way to distribute the traffic evenly between the Web1 and Web2 VMs to prevent the machines from being overloaded with traffic.
   - The Jump Box is used as a gateway for access from a remote network, it creates a separation from the home work station. In the case of the home workstation being compromised, the asset is protected.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the LOGS and system RESOURCES.
- What does Filebeat watch for?
   - Filebeat is used to monitor for system logs and relay any changes to Elasticsearch.
- What does Metricbeat record?
   - Metricbeat is used to monitor metrics and relays the information to Elasticsearch.

The configuration details of each machine may be found below.


| Name     | Function             | IP Address | Operating System |
|----------|----------------------|------------|------------------|
| Jump Box | Gateway              | 10.0.0.1   | Linux Ubuntu     |
| Web1     | Web Server           | 10.0.0.6   | Linux Ubuntu     |
| Web2     | Web server           | 10.0.0.5   | Linux Ubuntu     |
| ELK      | Elasticsearch Server | 10.1.0.4   | Linux Ubuntu     |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the ELK SERVER machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 80.249.xxx.xxx

Machines within the network can only be accessed by Workstation and JUMP-Box-Provisioner.
- Which machine did you allow to access your ELK VM? What was its IP address?
  - Jump-Box-Provisioner (10.0.0.4) 

A summary of the access policies in place can be found in the table below.

| Name       | Publicly Accessible | Allowed IP Addresses |
|------------|---------------------|----------------------|
| Jump Box   | No                  | 80.249.xxx.xxx       |
| Web1       | No                  | 10.0.0.4             |
| Web2       | No                  | 10.0.0.4             |
| ELK-Server | No                  | 80.249.xxx.xxx       |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- What is the main advantage of automating configuration with Ansible?
  - Using Ansible allows for quick and easy deploying of applications. By writing tasks in an ansible playbook, they are automated and configured automatically to work on the system it is installing on.

The playbook implements the following tasks:
- Install Docker: installing Docker which is required for installing and attaching the ELK container.
- Install Python3_pip: an installation module which can allow easier installation of additional modules.
- Increase memory use: ELK Docker container has a prerequisite amount of memory needed to run.
- Download ELK container: downloads the ELK container to run on the ELK server.
- Publishing ports: publish the specific ports: 
  - 5601:5601 
  - 9200:9200 
  - 5044:5044

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![docker ps](https://github.com/Cruisey-RD/Project-1/blob/main/Diagrams/Docker%20ps.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web1: 10.0.0.5
- Web2: 10.0.0.6

We have installed the following Beats on these machines:
- FileBeat
- MetricBeat

These Beats allow us to collect the following information from each machine:
- FileBeat will collect log data and you can expect to see Logs containing events from the server.
- MetricBeat will collect metrics from the server and you can expect to see system statistics.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the elk_install.yml file to /etc/ansible/roles/elk_install.yml.
- Update the hosts file to include:

~~~
 [webservers]  
 #alpha.example.org
 #beta.example.org
 #192.168.1.100
 #192.168.1.110
 10.0.0.5 ansible_python_interpreter=/usr/bin/python3
 10.0.0.6 ansible_python_interpreter=/usr/bin/python3

 [elk]
 10.1.0.4 ansible_python_interpreter=/usr/bin/python3
~~~

- Run the playbook, and navigate to http://[your.ELK-VM.External.IP]:5601/app/kibana to check that the installation worked as expected.

Answer the following questions to fill in the blanks
- Which file is the playbook? Where do you copy it?
  - filebeat-playbook.yml and metricbeat-playbook.yml will be the playbook files and you would copy them to the following directory /etc/ansible/roles/
- Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on? 
   - You would update the hosts file (/etc/ansible/hosts). 
   - To specify which machine to install the ELK server on you would specify the host as [elk] in the install_elk.yml file 
- Which URL do you navigate to in order to check that the ELK server is running? 
   - http://[your.ELK-VM.External.IP]:5601/app/kibana

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._

For the playbook that will install the ELK server run:
~~~
curl https://github.com/Cruisey-RD/Project-1/blob/main/Ansible/install_elk.yml > /etc/ansible/install_elk.yml
~~~
~~~
ansible-playbook install_elk.yml
~~~

For the playbook that will install FileBeat run:
~~~
curl https://github.com/Cruisey-RD/Project-1/blob/main/Ansible/filebeat-playbook.yml > /etc/ansible/roles/filebeat-playbook.yml
~~~
~~~
ansible-playbook filebeat-playbook.yml
~~~

For the playbook that will install MetricBeat run:
~~~
curl https://github.com/Cruisey-RD/Project-1/blob/main/Ansible/metricbeat-playbook.yml > /etc/ansible/role/metricbeat-playbook.yml
~~~
~~~
ansible-playbook metricbeat-playbook.yml
~~~
