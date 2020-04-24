import java.text.SimpleDateFormat
node {
    try {
        //名字这么写是为了可以发布到腾讯docker仓库，可随意更改
        def dockerId='tengxun'
        def dockerUrl='ccr.ccs.tencentyun.com'
        def dockerNamespace='esms'
        def dockerName='parkWithYou-api'
        def env='test'

        def dateFormat = new SimpleDateFormat("yyyyMMddHHmm")
        def dockerTag = dateFormat.format(new Date())

        stage('git pull'){
            sh 'pwd'
            git credentialsId: '3f128292-83c1-41df-80aa-484a1865aacf', url: 'https://github.com/Visualrainy/park-with-you-backend.git'
        }
        stage('mvn install') {
            sh 'pwd'
            docker.image('maven:3.6.0-jdk-8-alpine').inside('-v /Users/pchen/docker/.m2:/root/.m2') {
                sh 'mvn --version'
                sh 'mvn clean install'
            }
        }
        stage('docker run') {
            dir("esms-main") {
                sh 'pwd'
                def imageUrl = "${dockerUrl}/${dockerNamespace}/${dockerName}:${dockerTag}"
                def customImage = docker.build("parkWithYou")
                sh "docker rm -f ${dockerName} | true"
                //--network esms-net配置网络信息，需要先docker network create esms-net，用于多个服务交互，可选
//                 customImage.run("-it -d --name ${dockerName} -p 8090:8090 --network esms-net -e SPRING_PROFILES_ACTIVE=${env}")
                customImage.run("-it -d --name ${dockerName} -p 8090:8090 -e SPRING_PROFILES_ACTIVE=${env}")
                //only retain last 3 images，自动删除老的容器，只保留最近3个
                sh """docker rmi \$(docker images | grep ${dockerName} | sed -n  '4,\$p' | awk '{print \$3}') || true"""
            }
        }
        currentBuild.result="SUCCESS"
    } catch (e) {
        currentBuild.result="FAILURE"
        throw e
    } finally {
        //此处若想发布邮件，需要在系统管理-系统设置中配置邮件服务器
//         mail to: 'xxxx@qq.com',subject: "Jenkins: ${currentBuild.fullDisplayName}，${currentBuild.result}",body:"${currentBuild.result}"
    }
}
