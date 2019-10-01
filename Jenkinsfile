node()
{
    try
    {
        stage('Checkout')
        {
            cleanWs()
            scmVars = checkout scm
            commitHash = scmVars.GIT_COMMIT
            isTag =  scmVars.GIT_BRANCH.startsWith("refs/tags/")
            IMAGE_TAG = env.JOB_NAME + "." + env.BUILD_NUMBER
            IMAGE_TAG = IMAGE_TAG.toLowerCase()
            sh """
               echo 'SCM vars' ${scmVars}
               echo 'Commit hash' ${commitHash}
               echo 'Is tag' ${isTag}
               echo 'IMAGE_TAG' ${IMAGE_TAG}
               """
        }
    } catch (e) {
         currentBuild.result = "FAILED"
         throw e
    } finally {
         sh "echo 'Success'"
    }
}
