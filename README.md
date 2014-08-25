brms-5.2.0-maven-patches
========================

#Description
Easily install the patched BRMS artifacts into maven. 

Based on Eric Scabell's maven artifact creation [script](http://www.schabell.org/2013/02/jboss-brms-update-howto-mavenize.html).

#Instructions

1. Download the attached zip and extract it. You'll likely need to chmod u+x install_deployables.sh.
2. Download the JBoss BRMS Deployable from access.redhat.com (brms-p-5.2.0.GA-deployable.zip)
4. Move zip into the installs directory. 
5. run the install_deployables.sh from the brms-5.2.1-maven-patches folder. The script will cd into a directory and it expects the script to be run from the root folder.
