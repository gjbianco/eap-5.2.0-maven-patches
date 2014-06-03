#!/usr/bin/env bash
SRC_DIR=./installs
BRMS=brms-p-5.3.1.GA-deployable-ee6.zip
UPDATE=BZ-1022758.zip
UPDATE_DIR=./BZ1022758
VERSION=5.3.1.BRMS
VERSION_P02=5.3.1.BRMS-P02
VERSION_P04=5.3.1.BRMS-P04
VERSION_P05=5.3.1.BRMS-P05

command -v mvn -q >/dev/null 2>&1 || { echo >&2 "Maven is required but not installed yet... aborting."; exit 1; }

installPom() {
    mvn -q install:install-file -Dfile=../$SRC_DIR/parents/$3/$2-$3.pom.xml -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -Dpackaging=pom;
}


installBinary() {
    unzip -q -f $2-$3.jar META-INF/maven/$1/$2/pom.xml;
    mvn -q install:install-file -DpomFile=./META-INF/maven/$1/$2/pom.xml -Dfile=$2-$3.jar -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -Dpackaging=jar;
}

installUpdatedBinary() {
    unzip -q -f $UPDATE_DIR/$2-$3.jar META-INF/maven/$1/$2/pom.xml;
    mvn -q install:install-file -DpomFile=./META-INF/maven/$1/$2/pom.xml -Dfile=$UPDATE_DIR/$2-$3.jar -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -Dpackaging=jar;

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
installPom org.drools drools-container $VERSION
installPom org.drools droolsjbpm-knowledge $VERSION
installPom org.drools drools-multiproject $VERSION
installPom org.drools droolsjbpm-tools $VERSION
installPom org.drools droolsjbpm-integration $VERSION
installPom org.drools guvnor $VERSION
installPom org.jbpm jbpm $VERSION

echo Installing P02 parent POMs...
echo
#installPom org.drools droolsjbpm-parent
installPom org.drools droolsjbpm-knowledge $VERSION_P02
installPom org.drools drools-multiproject $VERSION_P02
installPom org.drools droolsjbpm-tools $VERSION_P02
installPom org.drools droolsjbpm-integration $VERSION_P02
installPom org.drools guvnor $VERSION_P02
installPom org.jbpm jbpm $VERSION_P02

echo Installing P04 parent POMs...
echo
installPom org.drools droolsjbpm-knowledge $VERSION_P04
installPom org.drools drools-multiproject $VERSION_P04
installPom org.drools droolsjbpm-tools $VERSION_P04
installPom org.drools droolsjbpm-integration $VERSION_P04
installPom org.drools guvnor $VERSION_P04
installPom org.jbpm jbpm $VERSION_P04

echo Installing P05 parent POMs...
echo

installPom org.drools drools-container $VERSION_P05
installPom org.drools droolsjbpm-integration $VERSION_P05
installPom org.drools droolsjbpm-parent $VERSION_P05
installPom org.drools drools-multiproject $VERSION_P05
installPom org.drools guvnor $VERSION_P05
installPom org.jbpm jbpm $VERSION_P05


echo Installing Drools binaries...
echo
# droolsjbpm-knowledge
installUpdatedBinary org.drools knowledge-api $VERSION_P02
# drools-multiproject
installUpdatedBinary org.drools drools-core $VERSION_P05
installUpdatedBinary org.drools drools-compiler $VERSION_P05
installUpdatedBinary org.drools drools-jsr94  $VERSION_P02
installUpdatedBinary org.drools drools-verifier $VERSION_P02
installUpdatedBinary org.drools drools-persistence-jpa $VERSION_P05
installUpdatedBinary org.drools drools-templates $VERSION_P02
installUpdatedBinary org.drools drools-decisiontables $VERSION_P02
# droolsjbpm-tools
installBinary org.drools drools-ant $VERSION
# droolsjbpm-integration
installBinary org.drools drools-camel $VERSION
installUpdatedBinary org.drools drools-spring $VERSION_P05
# guvnor
installUpdatedBinary org.drools droolsjbpm-ide-common $VERSION_P05

echo Installing jBPM binaries...
echo
installUpdatedBinary org.jbpm jbpm-flow $VERSION_P05
installUpdatedBinary org.jbpm jbpm-flow-builder $VERSION_P04
installUpdatedBinary org.jbpm jbpm-persistence-jpa $VERSION_P02
installUpdatedBinary org.jbpm jbpm-bam $VERSION_P02
installUpdatedBinary org.jbpm jbpm-bpmn2 $VERSION_P05
installUpdatedBinary org.jbpm jbpm-workitems $VERSION_P02
installUpdatedBinary org.jbpm jbpm-human-task $VERSION_P05
installUpdatedBinary org.jbpm jbpm-test $VERSION_P04
installBinary org.jbpm jbpm-workitems $VERSION

cd ..
rm -rf binaries
rm jboss-brms-engine.zip
rm jboss-jbpm-engine.zip

echo Installation of binaries "for" BRMS $VERSION_P05 complete.
echo


