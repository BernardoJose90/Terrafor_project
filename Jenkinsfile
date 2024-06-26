pipeline {
    agent any
    tools {
        "org.jenkinsci.plugins.terraform.TerraformInstallation" "terraform"
    }
    parameters {
        string(name: 'WORKSPACE', defaultValue: 'development', description:'setting up workspace for terraform')
    }
    environment {
        TF_HOME = tool('terraform')
        TP_LOG = "WARN"
        PATH = "$TF_HOME:$PATH"
    }
    stages {
            stage('TerraformInit'){
            steps {
                dir('BernardoJose90/Terrafor_project.git'){
                    sh "terraform init -input=false"
                    sh "echo \$PWD"
                    sh "whoami"
                }
            }
        }

        stage('TerraformFormat'){
            steps {
                dir('BrnardoJose90/Terrafor_project.git'){
                    sh "terraform fmt -list=true -write=false -diff=true -check=true"
                }
            }
        }

        stage('TerraformValidate'){
            steps {
                dir('BernardoJose90/Terrafor_project.git'){
                    sh "terraform validate"
                }
    
            }
        }

        stage('TerraformPlan'){
            steps {
                dir('BernardoJose90/Terrafor_project.git'){
                    script {
                        try {
                            sh "terraform workspace new ${params.WORKSPACE}"
                        } catch (err) {
                            sh "terraform workspace select ${params.WORKSPACE}"
                        }
                        sh "terraform plan -out terraform.tfplan;echo \$? > status"
                        stash name: "terraform-plan", includes: "terraform.tfplan"
                    }
                }
            }
        }

        
        stage('TerraformApply'){
            steps {
                script{
                    def apply = false
                    try {
                        input message: 'Can you please confirm the apply', ok: 'Ready to Apply the Config'
                        apply = true
                    } catch (err) {
                        apply = false
                         currentBuild.result = 'UNSTABLE'
                    }
                    if(apply){
                        dir('BernardoJose90/Terrafor_project.git'){
                            unstash "terraform-plan"
                            sh 'terraform apply terraform.tfplan' 
                        }
                    }
                }
            }
        }
    }
}
