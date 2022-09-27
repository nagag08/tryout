pipeline {
    agent any
    stages {
        stage ('Clone') {
            steps {
                git branch: 'master', url: "https://github.com/jfrog/project-examples.git"
            }
        }

        stage ('Artifactory configuration') {
            steps {
                rtServer (
                    id: "pstest",
                    url: "https://nagag-pstest.dev.gcp.devopsacc.team/artifactory/",
                    credentialsId: "29739489-568e-4dcd-994d-5027346c2249"
                )

                rtMavenDeployer (
                    id: "MAVEN_DEPLOYER",
                    serverId: "pstest",
                    releaseRepo: "mvn-virt",
                    snapshotRepo: "mvn-snap-virt"
                )

                rtMavenResolver (
                    id: "MAVEN_RESOLVER",
                    serverId: "pstest",
                    releaseRepo: "mvn-virt",
                    snapshotRepo: "mvn-snap-virt"
                )
            }
        }

        stage ('Exec Maven') {
            steps {
                rtMavenRun (
                    tool: "MAVEN_TOOL", // Tool name from Jenkins configuration
                    pom: 'maven-examples/maven-example/pom.xml',
                    goals: 'clean install',
                    deployerId: "MAVEN_DEPLOYER",
                    resolverId: "MAVEN_RESOLVER"
                )
            }
        }

        stage ('Publish build info') {
            steps {
                rtPublishBuildInfo (
                    serverId: "pstest"
                )
            }
        }
    }
}
