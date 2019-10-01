def MARKERS = "monitoring"
def STAGE

pipeline
{
    agent any
    stages
    {
        stage('SCM: code update')
        {
            steps
            {
                script
                {
                    STAGE=env.STAGE_NAME
                    currentBuild.displayName = "#${BUILD_ID} | [Node] ${env.NODE_NAME} | [Markers] ${MARKERS}"
                }
                scmVars = checkout scm
                commitHash = scmVars.GIT_COMMIT
                isTag =  scmVars.GIT_BRANCH.startsWith("refs/tags/")
                IMAGE_TAG = env.JOB_NAME + "." + env.BUILD_NUMBER
                IMAGE_TAG = IMAGE_TAG.toLowerCase()
                sh "echo 'SCM vars' ${scmVars}"
                sh "echo 'Commit hash' ${commitHash}"
                sh "echo 'Is tag -' ${isTag}"
                sh "echo 'IMAGE_TAG -' ${IMAGE_TAG}"
            }
        }
        stage('Activate tests')
        {
            steps
            {
                script
                {
                    STAGE=env.STAGE_NAME
                }
            }
        }
    }
    post
    {
        success
        {
            script 
            {
                echo "Tag parameter - ${ref}"
                def prevBuildDisplayName = currentBuild.getPreviousBuild().displayName
                if (!"${prevBuildDisplayName}".contains("SCM ERRORS"))
                {
                    echo "Current SUCCESSFULL build is - ${currentBuild.displayName}"
                }
                else
                {
                    currentBuild.displayName = "*** SCM SUCCESS ***"
                    echo "Success after failure in SCM"
                }
            }
        }
        unsuccessful
        {
            script 
            {
                if ("${STAGE}" == 'SCM: code update' && "${currentBuild.currentResult}" == 'FAILURE') 
                {
                    currentBuild.displayName = "${currentBuild.displayName} | *** SCM ERRORS ***"
                }
            }
            echo "Failed stage is ${STAGE}"
            echo "Current FAILED build is - ${currentBuild.displayName}"
        }
    }
}
