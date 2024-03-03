## University of Warwick CSVS-PMA-5579496
#### Read the following file carefully!
*** 
#### Background
- We were tasked by our fictional clients to harden their applications before their deployment on cloud. 
- Employee 1337dev0Ps1N7ErN from the company was our point of contact during the audit.

***
#### DISCLAIMER :

This is an already hardened image. To mount and run it from scratch make sure to remove the applicability of control groups and capabilities and run it.
Once the database server is mounted you can delete the images and containers and revert the changes to make sure the hardened application is up and running.

Set the path in the playbook to your source folder.
##### ![image](https://github.com/nazeefkhan2372/Container-Security/assets/67185628/4a38c2e4-dee7-4059-b8c8-fd4d6c595d12)
Delete the highlighted values.
##### ![image](https://github.com/nazeefkhan2372/Container-Security/assets/67185628/b286ab2d-7a80-4592-a38f-839e4910d53c)
Also, set the user to root since to mount the database initially requires root permissions.
##### ![image](https://github.com/nazeefkhan2372/Container-Security/assets/67185628/a93e73aa-e27d-41fb-9f83-15e5638898aa)



*** 

#### INSTALLATION :

Container-Security project requires ansible installed to run it.
```
$ sudo apt update
```
```
$ sudo apt install ansible
```
```
$ git clone https://github.com/nazeefkhan2372/Container-Security.git
```

#### USAGE :
The docker image and containers can be run by navigating to the playbook directory and running the following command:  
```
$ ansible-playbook dbstack.yml --ask-vault-pass
```
When prompted the Vault password enter:
```
$ Password123!
```

### WEBSERVER

#### You should now be able to browse to http://localhost:8080/ to view the web application!

## NOTE: If you have issues getting the basic setup working, ask for help!
DO NOT FORGET TO ADD THE CAPABILITIES ONCE THE DATABASE IS MOUNTED.

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/nazeef-hasan-khan/)
