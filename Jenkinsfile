#!groovy

stage('Initial setup') {
    properties([
        parameters([
            string(
                name: 'TARGET',
                description: 'Target url'
            ),
        ])
    ])
}

stage('Scan Web Application') {
    node('zap') {
    container('zap') {
        sh 'mkdir /tmp/workdir'
            dir('/tmp/workdir') {
                def retVal = sh(returnStatus: true, script: "/zap/zap-baseline.py -r baseline.html -t $TARGET")
                    publishHTML([
                            allowMissing: false,
                            alwaysLinkToLastBuild: false,
                            keepAll: true,
                            reportDir: '/zap/wrk',
                            reportFiles: 'baseline.html',
                            reportName: 'ZAP Baseline Scan',
                            reportTitles: 'ZAP Baseline Scan'
                    ])
                    echo "Return value is: ${retVal}"
            }
    }
    }
}

/*
 * ZAP image
 *
 * Options:
 * - daemon mode
 * - baseline check
 *
 */

