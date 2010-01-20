#!/usr/bin/env groovy
def ts = new XmlParser().parse(new File('target/test-reports/TESTS-TestSuites.xml'))
ts.testsuite.testcase.failure.each {
    def testName = it.parent().attribute('classname')
    def splitted = testName.toString().split("\\.")
    if (splitted.size()) {
        testName = splitted[-1]
    }
    // sometimes message is blank.  if so, use 'type' attribute.
    def msg = it.attribute('message') ?: it.attribute('type')
    msg = msg.replaceAll(":", ";")  
    def error = it.text().split("\n")[1]
    def m = error =~ /\((.*)\)/
    def fileName = m[0][1]


    // Find this file in the dir. structure so we can get abs. path
    new File("test").eachFileRecurse { f ->
        if (f.name == testName + '.groovy') {
            fileName = f.parent + '/' + fileName
            return
        }
    }
    println "${msg}:${fileName}"
}
