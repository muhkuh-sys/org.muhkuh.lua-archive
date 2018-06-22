import groovy.json.JsonSlurperClassic

node {
    def ARTIFACTS_PATH = 'build/*/lua5.*/targets/jonchki/repository/org/lua/lua/*'
    def strBuilds = env.JENKINS_SELECT_BUILDS
    def atBuilds = new JsonSlurperClassic().parseText(strBuilds)

    atBuilds.each { atEntry ->
        stage(atEntry[0]){
            docker.image("${atEntry[2]}").inside('-u root') {
                /* Clean before the build. */
                sh 'rm -rf .[^.] .??* *'

                checkout([$class: 'GitSCM',
                    branches: [[name: '*/master']],
                    doGenerateSubmoduleConfigurations: false,
                    extensions: [
                        [$class: 'SubmoduleOption',
                            disableSubmodules: false,
                            recursiveSubmodules: true,
                            reference: '',
                            trackingSubmodules: false
                        ]
                    ],
                    submoduleCfg: [],
                    userRemoteConfigs: [[url: 'https://github.com/muhkuh-sys/org.muhkuh.lua-archive.git']]
                ])

                /* Build the project. */
                sh "bash .build ${atEntry[1]}"

                /* Archive all artifacts. */
                archiveArtifacts artifacts: "${ARTIFACTS_PATH}/*.tar.xz,${ARTIFACTS_PATH}/*.xml,${ARTIFACTS_PATH}/*.hash,${ARTIFACTS_PATH}/*.pom"

                /* Clean up after the build. */
                sh 'rm -rf .[^.] .??* *'
            }
        }
    }
}
