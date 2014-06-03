#!/bin/bash
SRC_DIR=./installs
BRMS=brms-p-5.3.1.GA-deployable-ee6.zip
UPDATE=BZ-986451.zip
UPDATE_DIR=./BZ986451
VERSION=5.3.1.BRMS
VERSION_P02=5.3.1.BRMS-P02
VERSION_P04=5.3.1.BRMS-P04

command -v mvn -q >/dev/null 2>&1 || { echo >&2 "Maven is required but not installed yet... aborting."; exit 1; }

installPom() {
    mvn -q install:install-file -Dfile=../$SRC_DIR/parents/$VERSION/$2-$VERSION.pom.xml -DgroupId=$1 -DartifactId=$2 -Dversion=$VERSION -Dpackaging=pom;
}

installPom_P02() {
    mvn -q install:install-file -Dfile=../$SRC_DIR/parents/$VERSION_P02/$2-$VERSION_P02.pom.xml -DgroupId=$1 -DartifactId=$2 -Dversion=$VERSION_P02 -Dpackaging=pom;
}

installPom_P04() {
    mvn -q install:install-file -Dfile=../$SRC_DIR/parents/$VERSION_P04/$2-$VERSION_P04.pom.xml -DgroupId=$1 -DartifactId=$2 -Dversion=$VERSION_P04 -Dpackaging=pom;
}

installBinary() {
    unzip -q $2-$VERSION.jar META-INF/maven/$1/$2/pom.xml;
    mvn -q install:install-file -DpomFile=./META-INF/maven/$1/$2/pom.xml -Dfile=$2-$VERSION.jar -DgroupId=$1 -DartifactId=$2 -Dversion=$VERSION -Dpackaging=jar;
}

installBinary_P02() {
    unzip -q $UPDATE_DIR/$2-$VERSION_P02.jar META-INF/maven/$1/$2/pom.xml;
    mvn -q install:install-file -DpomFile=./META-INF/maven/$1/$2/pom.xml -Dfile=$UPDATE_DIR/$2-$VERSION_P02.jar -DgroupId=$1 -DartifactId=$2 -Dversion=$VERSION_P02 -Dpackaging=jar;
}

installBinary_P04() {
    unzip -q $UPDATE_DIR/$2-$VERSION_P04.jar META-INF/maven/$1/$2/pom.xml;
    mvn -q install:install-file -DpomFile=./META-INF/maven/$1/$2/pom.xml -Dfile=$UPDATE_DIR/$2-$VERSION_P04.jar -DgroupId=$1 -DartifactId=$2 -Dversion=$VERSION_P04 -Dpackaging=jar;
}

echo
echo Installing the BRMS binaries into the Maven repository...
echo

unzip -q $SRC_DIR/$BRMS jboss-brms-engine.zip
unzip -q jboss-brms-engine.zip binaries/*
unzip -q $SRC_DIR/$BRMS jboss-jbpm-engine.zip
unzip -q -o -d ./binaries jboss-jbpm-engine.zip
unzip -q -d ./binaries $SRC_DIR/$UPDATE

cd binaries

echo Installing parent POMs...
echo
#installPom org.drools droolsjbpm-parent
installPom org.drools drools-container
installPom org.drools droolsjbpm-knowledge
installPom org.drools drools-multiproject
installPom org.drools droolsjbpm-tools
installPom org.drools droolsjbpm-integration
installPom org.drools guvnor
installPom org.jbpm jbpm

echo Installing P02 parent POMs...
echo
#installPom org.drools droolsjbpm-parent
installPom_P02 org.drools droolsjbpm-knowledge
installPom_P02 org.drools drools-multiproject
installPom_P02 org.drools droolsjbpm-tools
installPom_P02 org.drools droolsjbpm-integration
installPom_P02 org.drools guvnor
installPom_P02 org.jbpm jbpm

echo Installing P04 parent POMs...
echo
installPom_P04 org.drools droolsjbpm-parent
installPom_P04 org.drools droolsjbpm-knowledge
installPom_P04 org.drools drools-multiproject
installPom_P04 org.drools droolsjbpm-tools
installPom_P04 org.drools droolsjbpm-integration
installPom_P04 org.drools guvnor
installPom_P04 org.jbpm jbpm

echo Installing Drools binaries...
echo
# droolsjbpm-knowledge
installBinary_P02 org.drools knowledge-api
# drools-multiproject
installBinary_P04 org.drools drools-core
installBinary_P04 org.drools drools-compiler
installBinary_P02 org.drools drools-jsr94
installBinary_P02 org.drools drools-verifier
installBinary_P04 org.drools drools-persistence-jpa
installBinary_P02 org.drools drools-templates
installBinary_P02 org.drools drools-decisiontables
# droolsjbpm-tools
installBinary org.drools drools-ant
# droolsjbpm-integration
installBinary org.drools drools-camel
installBinary org.drools drools-spring
# guvnor
installBinary_P02 org.drools droolsjbpm-ide-common

echo Installing jBPM binaries...
echo
installBinary_P04 org.jbpm jbpm-flow
installBinary_P04 org.jbpm jbpm-flow-builder
installBinary_P02 org.jbpm jbpm-persistence-jpa
installBinary_P02 org.jbpm jbpm-bam
installBinary_P04 org.jbpm jbpm-bpmn2
installBinary_P02 org.jbpm jbpm-workitems
installBinary_P04 org.jbpm jbpm-human-task
installBinary_P04 org.jbpm jbpm-test

cd ..
rm -rf binaries
rm jboss-brms-engine.zip
rm jboss-jbpm-engine.zip

echo Installation of binaries "for" BRMS $VERSION_P04 complete.
echo


