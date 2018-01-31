#!groovy

stage('Initial setup') {
    properties([
        parameters([
            string(
                name: 'TARGET',
                description: 'Target url',
                defaultValue: 'http://juice-shop:80'
            ),
            string(
                name: 'MINUTES',
                description: 'The number of minutes to spider for',
                defaultValue: '1'
            ),
        ])
    ])
}

stage('Scan Web Application') {
    node('zap') {
    container('zap') {
        def tempDir = sh(returnStdout: true, script: "mktemp -d")
        dir(tempDir) {
            def retVal = sh(returnStatus: true, script: "/zap/zap-baseline.py -m $MINUTES -r baseline.html -t $TARGET")
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
        sh "rm -rf $tempDir"
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

