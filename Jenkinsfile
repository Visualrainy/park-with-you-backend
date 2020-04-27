node {
    try {
        def dockerName='parkwithyou-api'
        def dockerImage=''

        stage('checkout'){
            sh 'pwd'
            git credentialsId: '3f128292-83c1-41df-80aa-484a1865aacf', url: 'https://github.com/Visualrainy/park-with-you-backend.git'
        }
        stage('build') {
            sh 'pwd'
            sh './mvnw --version'
            sh './mvnw clean install -DskipTests'
        }

        stage('test') {
            sh './mvnw test'
        }

        stage('build image') {
            sh 'pwd'
            dockerImage = docker.build("${dockerName}:${env.BUILD_NUMBER}")
        }

        stage('deploy dev') {
            sh 'pwd'
            sh "docker rm -f ${dockerName}-dev | true"
            dockerImage.run("-it -d --name ${dockerName}-dev -p 8090:8080 -e SPRING_PROFILES_ACTIVE=dev")

            //only retain last 3 images，自动删除老的容器，只保留最近3个
            sh """docker rmi \$(docker images | grep ${dockerName} | sed -n  '4,\$p' | awk '{print \$3}') || true"""
        }

        stage('deploy to prod') {
            input "Deploy to prod?"
            sh "docker rm -f ${dockerName}-prod | true"
            dockerImage.run("-it -d --name ${dockerName}-prod -p 9080:8081 -e SPRING_PROFILES_ACTIVE=prod")
        }

        currentBuild.result="SUCCESS"
    } catch (e) {
        currentBuild.result="FAILURE"
        throw e
    } finally {
        //此处若想发布邮件，需要在系统管理-系统设置中配置邮件服务器
    }
}
