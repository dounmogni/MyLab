pipeline{
    //Directives
    agent any
    tools {
        maven 'maven'
    }
      environment{
       ArtifactId = readMavenPom().getArtifactId()
       Version = readMavenPom().getVersion()
       Name = readMavenPom().getName()
       GroupId = readMavenPom().getGroupId()
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
        
        // Stage 3 : Print some information
        stage ('Print Environment variables'){
                    steps {
                        echo "Artifact ID is '${ArtifactId}'"
                        echo "Version is '${Version}'"
                        echo "GroupID is '${GroupId}'"
                        echo "Name is '${Name}'"
                    }
        } 

        // Stage4 Deploying the build artifact to Tomcat:
        stage ('Deploy to tomcat'){
            steps {
                echo ' deploying...'
                sshPublisher(publishers: 
                [sshPublisherDesc(
                    configName: 'Ansible_Controler', 
                    transfers: [
                        sshTransfer(
                          cleanRemote: false, 
                           excludes: '', 
                           execCommand: 'ansible-playbook  -i /opt/playbooks/hosts /opt/playbooks/dowloadanddeploy_as_tomcat_user.yml', 
                           execTimeout: 120000, 
                           flatten: false, 
                           makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', 
                           remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: ''
                        )
                    ], 
                    usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)
                ]
                )
            }
        } 
        // Stage5 Deploying the build artifact to Docker:
        stage ('Deploy to Docker'){
            steps {
                echo ' deploying...'
                sshPublisher(publishers: 
                [sshPublisherDesc(
                    configName: 'Ansible_Controler', 
                    transfers: [
                        sshTransfer(
                          cleanRemote: false, 
                           excludes: '', 
                           execCommand: 'ansible-playbook  -i /opt/playbooks/hosts /opt/playbooks/dowloadanddeploy_docker.yml', 
                           execTimeout: 120000, 
                           flatten: false, 
                           makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', 
                           remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: ''
                        )
                    ], 
                    usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)
                ]
                )
            }
        } 

        // Stage6 : Publish the source code to Sonarqube
        stage ('Sonarqube Analysis'){
            steps {
                echo ' Source code published to Sonarqube for SCA......'
                withSonarQubeEnv('sonarqube'){ // You can override the credential to be used
                     sh 'mvn sonar:sonar'
                }

            }
        }
        

        //stage 7 Publis the artefacts to Nexus
        stage ("Publish to Nexus") {
            steps {
             script {
                    // condition /initialisation to publish weither in snapshot or in relaease
                def NexusRepo = Version.endsWith("SNAPSHOT") ? "DounmogniDevOpsLab-SNAPSHOT" : "DounmogniDevOpsLab-RELEASE"

                nexusArtifactUploader artifacts: 
                [[artifactId: "${ArtifactId}", 
                classifier: '', 
                file: "target/${ArtifactId}-${Version}.war", 
                type: 'war']], 
                credentialsId: 'b17ad352-dd6d-4afd-882f-57757f3adfe1', 
                groupId: "${GroupId}", 
                nexusUrl: '172.20.10.134:8081', 
                nexusVersion: 'nexus3', 
                protocol: 'http', 
                repository: "${NexusRepo}", 
                version: "${Version}"
             }
            }
        }
        
         
    
    }

}