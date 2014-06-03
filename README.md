brms-5.3.1-maven-patches
========================

#Description
Easily install the patched BRMS artifacts into maven. 

Based on Eric Scabell's maven artifact creation [script](http://www.schabell.org/2013/02/jboss-brms-update-howto-mavenize.html).

#Instructions

1. Download the attached zip and extract it. You'll likely need to chmod u+x install_deployables.sh.
2. Download the JBoss BRMS Deployable for EAP 6 from access.redhat.com (brms-p-5.3.1.GA-deployable-ee6.zip)
3. Download the BRMS 5.3.1 Rollup Patch #4 from access.redhat.com, in the Security Advisories section (BZ-1022758.zip)
4. Move both zips into the installs directory. 
5. run the install_deployables.sh from the brms-5.3.1-maven-patches folder. The script will cd into a directory and it expects the script to be run from the root folder.
