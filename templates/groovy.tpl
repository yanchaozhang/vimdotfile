#!/usr/bin/env groovy

/* 
 *  Script: <+filename+>
 *
 * Purpose: <+purpose+>
 *
 *   Usage: groovy <+filename+> <+usage+> 
 *
 *  Author: <+author+>
 */

// Parse command line arguments
def cli = new CliBuilder(usage: 'groovy <+filename+> [-h|--help] [ -t "times" ] [[ -f "file1" ]..]',
                         parser: new org.apache.commons.cli.GnuParser ())

cli.h(longOpt:'help', 'show usage information and quit')
cli.t(argName:'times', args:1, required:false, 'Number of X to create')
cli.f(argName:'file', args:1, required:false, 'File name(s) of e-mail templates to use for Incidents')

// To actually parse the command line options, use the following command.
def opt = cli.parse(args)

// cli.parse will have already printed the usage if a required param is missing.
// All we have to do is exit if !opt
if (!opt) return
if (opt.h) {
    cli.usage() 
    return 0
}

// Default to 1 optTimes
def optTimes = (opt.t) ? opt.t : 1
// Default to a list
def optFiles = opt.f ? opt.fs : [ 'defaultFileName' ]

optFiles.each {
    println it
}
