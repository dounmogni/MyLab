pipeline{
    //Directives
    agent any
    tools {
        maven 'maven'
    }

    stages {
        // Specify various stage with in stages

        // stage 1. Build
        stage ('Build'){
            steps {
                sh 'mvn clean install package'
            }
        }

        // Stage2 : Testing
        stage ('Test'){
            steps {
                echo ' testing......'

            }
        }

        /* Stage3 : Publish the source code to Sonarqube
        stage ('Sonarqube Analysis'){
            steps {
                echo ' Source code published to Sonarqube for SCA......'
                withSonarQubeEnv('sonarqube'){ // You can override the credential to be used
                     sh 'mvn sonar:sonar'
                }

            }
        } */

        // Stage3 :
        stage ('Deploy'){
            steps {
                echo ' deploying...'
            }
        } 
        //stage 4 Publis the artefacts to Nexus
        stage ("Publish to Nexus") {
            steps {
                nexusArtifactUploader artifacts: [[artifactId: 'VinayDevOpsLab', classifier: '', file: 'target/VinayDevOpsLab-0.0.3.war', type: 'war']], credentialsId: '603e6d24-412a-4e00-8e53-5b7b1b0bb029', groupId: 'com.vinaysdevopslab', nexusUrl: '172.20.10.134:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'DounmogniDevOpsLab-SNAPSHOT', version: '0.0.3'
            }
        }
        
    }

}