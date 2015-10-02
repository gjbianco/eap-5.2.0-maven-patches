#!/usr/bin/env bash
SRC_DIR=./installs
EAP=jboss-eap-5.2.0.zip
VERSION=5.2.0

command -v mvn -q >/dev/null 2>&1 || { echo >&2 "Maven is required but not installed yet... aborting."; exit 1; }

installPom() {
    mvn -q install:install-file -Dfile=./$SRC_DIR/parents/$3/$2-$3.pom.xml -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -Dpackaging=pom;
}

installBinary() {
    # unzip -q -u $2.jar META-INF/maven/$1/$2/pom.xml;
    # mvn -q install:install-file -DpomFile=./META-INF/maven/$1/$2/pom.xml -Dfile=$2.jar -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -Dpackaging=jar;
    mvn -q install:install-file -Dfile=$2.jar -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -DgeneratePom=true -DcreateChecksum=true -Dpackaging=jar;
}

echo
echo Installing the EAP binaries into the Maven repository...
echo

unzip -q $SRC_DIR/$EAP -d $VERSION

echo Installing parent POMs...
echo
installPom com.redhat.jboss.eap eap $VERSION

cd $VERSION/jboss-eap-5.2/jboss-as/common/lib

echo Installing EAP binaries...
echo
installBinary com.redhat.jboss.eap jboss-common-jdbc-wrapper $VERSION
installBinary jboss.jbossts jbossjts 4.6.1.GA_CP12 # this should be CP13?
installBinary org.jboss.ejb3 jboss-ejb3-core 1.3.8
installBinary org.jboss.ejb3 jboss-ejb3-interceptors 1.0.7
installBinary javax.jms jms 1.1

cd ../../..
rm -rf $VERSION

echo Installation of binaries "for" EAP $VERSION complete.
echo
