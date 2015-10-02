eap-5.2.0-maven-patches
========================

#Description
Easily install the patched EAP artifacts into maven.

Based on Eric Scabell's maven artifact creation [script](http://www.schabell.org/2013/02/jboss-brms-update-howto-mavenize.html).

#Instructions

1. Download the attached zip and extract it. You'll likely need to chmod u+x install_deployables.sh.
2. Download the JBoss EAP 5.2.0 from access.redhat.com (jboss-eap-5.2.0.zip)
3. Move zip into the installs directory.
4. Run the install_deployables.sh from the eap-5.2.0-maven-patches folder. The script will cd into a directory and it expects the script to be run from the root folder.

#Issues

Currently, this only gets very specific dependencies with specific versions. More will be added as necessary.
