pipeline {
    agent any

    environment {
        TF_DIR        = "environment/dev"
        SLACK_CHANNEL = "#all-arasan"
    }

    options {
        timestamps()
        ansiColor('xterm')
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir("${TF_DIR}") {
                    sh '''
                        terraform plan -out=tfplan
                        terraform show -no-color tfplan > plan.txt
                    '''
                    script {
                        env.PLAN_SUMMARY = sh(
                            script: "grep -E '^Plan:|^No changes' plan.txt | tail -1",
                            returnStdout: true
                        ).trim()
                    }
                }
                archiveArtifacts artifacts: "${TF_DIR}/plan.txt", fingerprint: true
            }
        }

        stage('Approval Request') {
            steps {
                script {
                    slackSend(
                        channel: "${SLACK_CHANNEL}",
                        color: "#FFFF00",
                        message: """
🚨 Terraform Approval Required

Job: ${env.JOB_NAME}
Build: #${env.BUILD_NUMBER}
Triggered By: ${currentBuild.getBuildCauses()[0].shortDescription}

${env.PLAN_SUMMARY}

Review full plan and approve here:
${env.BUILD_URL}
""".stripIndent()
                    )
                }
                input(
                    message: "Approve Terraform Apply?",
                    ok: "Apply Infrastructure"
                )
            }
        }

        stage('Terraform Apply') {
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }

    post {
        success {
            slackSend(
                channel: "${SLACK_CHANNEL}",
                color: "good",
                message: """
✅ Terraform Deployment Successful

Job: ${env.JOB_NAME}
Build: #${env.BUILD_NUMBER}

${env.BUILD_URL}
""".stripIndent()
            )
        }

        failure {
            slackSend(
                channel: "${SLACK_CHANNEL}",
                color: "danger",
                message: """
❌ Terraform Deployment Failed

Job: ${env.JOB_NAME}
Build: #${env.BUILD_NUMBER}

${env.BUILD_URL}
""".stripIndent()
            )
        }

        aborted {
            slackSend(
                channel: "${SLACK_CHANNEL}",
                color: "#808080",
                message: """
⛔ Terraform Deployment Aborted

Job: ${env.JOB_NAME}
Build: #${env.BUILD_NUMBER}

${env.BUILD_URL}
""".stripIndent()
            )
        }
    }
}