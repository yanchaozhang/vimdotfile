#!/usr/bin/env groovy

/* 
 *  Script: <+filename+>
 *   Usage: <+filename+>
 * Purpose:
 *  Author: nathan.neff@gmail.com
 * History: 
 */

// Parse command line arguments
def cli = new CliBuilder(usage: 'groovy <+filename+> [-h|--help] [ -t "times" ] [[ -f "file1" ]..]',
                         parser: new org.apache.commons.cli.GnuParser ())

cli.h(argName:'help', longOpt:'help', 'show usage information and quit')
cli.t(argName:'times', args:1, required:false, 'Number of X to create')
cli.f(argName:'file', longOpt:'file', args:1, required:false, 'File name(s)')

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
// Forces list when the "s" is used here:
// -------------------------v
def optFiles = opt.f ? opt.fs : [ 'defaultFileName' ]

// Get a list of all args that don't have a switch
def leftOver = opt.arguments()
println "Remaining args are ${leftOver}"
