node {
    try {
        def dockerName='parkWithYou-api'
        def envTest='test'

        stage('checkout'){
            sh 'pwd'
            git credentialsId: '3f128292-83c1-41df-80aa-484a1865aacf', url: 'https://github.com/Visualrainy/park-with-you-backend.git'
        }
        stage('build') {
            sh 'pwd'
            docker.image('maven:3.6.0-jdk-8-alpine').inside('-v /Users/pchen/docker/.m2:/root/.m2') {
                sh 'mvn --version'
                sh 'mvn clean install -DskipTests'
                stage('test') {
                    sh 'mvn test'
                }
            }
        }

        stage('docker run') {
            sh 'pwd'
            def customImage = docker.build("${dockerName}:${env.BUILD_NUMBER}")
            sh "docker rm -f ${dockerName} | true"
            customImage.run("-it -d --name ${dockerName} -p 8090:8080 -e SPRING_PROFILES_ACTIVE=${envTest}")
            //only retain last 3 images，自动删除老的容器，只保留最近3个
            sh """docker rmi \$(docker images | grep ${dockerName} | sed -n  '4,\$p' | awk '{print \$3}') || true"""
        }
        currentBuild.result="SUCCESS"
    } catch (e) {
        currentBuild.result="FAILURE"
        throw e
    } finally {
        //此处若想发布邮件，需要在系统管理-系统设置中配置邮件服务器
    }
}
