brms-5.3.1-maven-patches
========================

Instructions:

1) Download the attached zip and extract it. You'll likely need to chmod u+x install_deployables.sh.
2) Download the JBoss BRMS Deployable for EAP 6 from access.redhat.com (brms-p-5.3.1.GA-deployable-ee6.zip)
3) Download the BRMS 5.3.1 Rollup Patch #3 from access.redhat.com, in the Security Advisories section (BZ-986451.zip)
4) Move both zips into the installs directory. 
5) run the install_deployables.sh from the brms_maven_install folder. The script will cd into a directory and it expects the script to be run from the root folder.
