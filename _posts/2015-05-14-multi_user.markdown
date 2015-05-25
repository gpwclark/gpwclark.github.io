---
layout: post
title: Getting my Linux Machine Properly Permiss-ed 
date: 2015-05-14 02:19:53

---

I am getting to the point now where I need to share my homeserver with others for development (Most notably [Pettr](https://hub.jazz.net/project/gpwclark/pettr/overview)). So, I'm biting the bullet and mucking around with file permissions, user groups, etc... also because I'm tired of remembering to type sudo all the time.  
 
 
 
### First: Undoing a bad practice of mine

I use services like Zend Eclipse for PHP Developers and to simplify things I just gave it my root login. No more, I am disabling root access via ssh on my computer. Doing so is simple,   

`sudo nano /etc/ssh/sshd_config // use ctrl + W to find the line that says... 
 PermitRootLogin yes`  

 Simply change the value from yes to no and then save the change.  
 
 
 
### Second: Creating users/groups and keeping it consistent

 First we need a new user (with a password), and they need to belong to a group.  

  `sudo useradd developer // new user created   
  sudo passwd developer // will prompt you to enter new UNIX password  
   sudo groupadd developers // new group created   
   sudo usermod -a -G developers developer // user is in the group`  

 Now for file permissions. I am bias given IBM was nice enough to hire me but
 [this is the most fantastic document](http://www.ibm.com/developerworks/library/l-lpic1-v3-104-5/) 
 I've found to walk you through file permissions and group ownership. It's a little verbose so below I will discuss what I've done.  

 As far as file permissions are concerned, make sure you understand what all 10 (or 11 now?) bits mean when you see a listing like:  

  `-rw-rw-r-- 1 remote remote 10025 Mar 31 21:35 built-editor.css  
   -rw-rw-r-- 1 remote remote 8188 Mar 31 21:35 built-editor.js  
   drwxr-xr-x 6 root root 4096 Feb 26 23:48 eclipse  
   -rw-rw-r-- 1 remote remote 59012644 Mar 27 22:26 eclipse-orion.gtk.x86_64.zip  
   drwxr-xr-x 8 root root 4096 May 22 02:39 org.eclipse.orion.client`   

Let's be honest though, you may end up memorizing a few of the octal commands for chmod but I think the most intuitive way of going about it is detailed in the IBM developerworks article. If you want to change the permissions for the user, or group, or other, simply use:

  `sudo chmod [u|g|o]+[r|w|x] filename`  

  i.e.  

  `sudo chmod ugo+rwx filename // gives all access to everyone  
   sudo chmod ug+rw filename // gives user and group read/write access  
   sudo chmod o+rx filename // gives others read and execute privileges.`   


I think it is a little easier to think about setting file permissions that explicitly, especially when starting out. Now, to put them to use. In my scenario, I want to place a folder, which I'll call developers, at the root of my website so users have access to a testing environment immediately viewable on the web.  

  `sudo mkdir /var/www/development // folder created  
   sudo chgrp developers /var/www/development // group ownership changed`  
 
 
 
 
### Third: Ensuring groups have proper permissions for all children files/folders

If you have done some light mucking around with file permissions in the past chances are you've gotten annoyed that a file/folder you created doesn't necessarily enforce the permission/ownership rights of it's parents. This is important, the administrator may want to add files to a folder that someone else created without necessarily giving them access. However, if you create a folder for a development group, you want every folder/file that is a child of that new development folder to be readable, writable, and executable by your group. Furthermore, you want this to be automatic, i.e. after each 'mkdir' and 'touch'. Enter the setuid and setgid bits for file permissions. By setting these, you can allow a user or a group to run executables as if they were the root user. On the other end, setting these bits on folders allow any child of the folder to **inherit that folder's group ID** The IBM developerworks article I added has all the necessary background, so I'll skip ahead to the code part:

  `/*  
    * group write access and assurance that all children   
    * in development folder will be owned by group  
    */  
   sudo chmod g+ws development`   

*Note: any files already in the folder will not be affected by this command. [This wikipedia article](http://en.wikipedia.org/wiki/Setuid#setgid_on_directories) has the line of code you would want to use to set the extant children's folders with the permissions you intend with chmod g+s.
 
 
 
 
 
### Fourth: What else will a user need? -- The ability to run... programs
