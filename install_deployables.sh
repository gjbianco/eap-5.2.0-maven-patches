#!/usr/bin/env bash
SRC_DIR=./installs
BRMS=brms-p-5.2.0.GA-deployable.zip
VERSION=5.2.0.BRMS
$MVEL_VERSION=2.1.Beta6

command -v mvn -q >/dev/null 2>&1 || { echo >&2 "Maven is required but not installed yet... aborting."; exit 1; }

installPom() {
    mvn -q install:install-file -Dfile=../$SRC_DIR/parents/$3/$2-$3.pom.xml -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -Dpackaging=pom;
}


installBinary() {
    unzip -q -u $2-$3.jar META-INF/maven/$1/$2/pom.xml;
    mvn -q install:install-file -DpomFile=./META-INF/maven/$1/$2/pom.xml -Dfile=$2-$3.jar -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -Dpackaging=jar;
}

installUpdatedBinary() {
    unzip -q -u $UPDATE_DIR/$2-$3.jar META-INF/maven/$1/$2/pom.xml;
    mvn -q install:install-file -DpomFile=./META-INF/maven/$1/$2/pom.xml -Dfile=$UPDATE_DIR/$2-$3.jar -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -Dpackaging=jar;

}

echo
echo Installing the BRMS binaries into the Maven repository...
echo

unzip -q $SRC_DIR/$BRMS jboss-brms-engine.zip
unzip -q jboss-brms-engine.zip binaries/*

cd binaries

echo Installing parent POMs...
echo
#installPom org.drools droolsjbpm-parent
installPom org.drools droolsjbpm-parent $VERSION
installPom org.drools droolsjbpm-knowledge $VERSION
installPom org.drools droolsjbpm-tools $VERSION
installPom org.drools drools-multiproject $VERSION
installPom org.drools guvnor $VERSION
installPom org.jbpm jbpm $VERSION

echo Installing Drools binaries...
echo
# droolsjbpm-knowledge
installBinary org.drools knowledge-api $VERSION
# drools-multiproject
installBinary org.drools drools-core $VERSION
installBinary org.drools drools-compiler $VERSION
installBinary org.drools drools-jsr94  $VERSION
installBinary org.drools drools-verifier $VERSION
installBinary org.drools drools-persistence-jpa $VERSION
installBinary org.drools drools-templates $VERSION
installBinary org.drools drools-decisiontables $VERSION
# droolsjbpm-tools
installBinary org.drools drools-ant $VERSION
# droolsjbpm-integration
installBinary org.drools drools-camel $VERSION
# guvnor
installBinary org.drools droolsjbpm-ide-common $VERSION

#special mvel2 version
installBinary org.mvel mvel2 $MVEL_VERSION

echo Installing jBPM binaries...
echo
installBinary org.jbpm jbpm-flow $VERSION
installBinary org.jbpm jbpm-flow-builder $VERSION
installBinary org.jbpm jbpm-persistence-jpa $VERSION

cd ..
rm -rf binaries
rm jboss-brms-engine.zip

echo Installation of binaries "for" BRMS $VERSION complete.
echo


