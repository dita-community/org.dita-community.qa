# QA Open Toolkit Plugin

## About

This DITA Open Toolkit plugin identifies errors in DITA tagging, element nesting, language standards, and common syntax errors, many of which are based on the Microsoft Manual of Style for Technical Publications. A quality assurance report is created as a single HTML file containing links to each project topic file and a stylized DITA Open Toolkit build log. Quality assurance checks are highly customizable to fit project needs.

[Ditanauts](www.ditanauts.org)


## Features

- Reports:
 - HTML report with summaries and graphs using Bootstrap and Google Charts (_mapname_-report.html)
 - DITA map containing references to all topics with errors and a list of the errors per topic (_mapname_-violations.ditamap)
 - CSV file containing all errors (_mapname_-violations.csv)
 - Data file containing all errors that you can use to create your own reports (_mapname_.dita)
- Set `@chunk=to-content` automatically on bookmap and map element when `-Dsetchunk=true` is specified on command line
- QA checks compiler transform tool to enable authoring of QA checks as DITA reference topic

## Usage

To run the standard test transform:

OT 1.x
```
ant -Dtranstype=qa -Douter.control=quiet -Dsetchunk=true -Dargs.input=samples/taskbook.ditamap [-logger=org.apache.tools.ant.XmlLogger -logfile=out/qalog.xml]
```

OT 2.x
```
dita -f qa -i samples/taskbook.ditamap -Dsetchunk=true
```

## QA Checks Compiler

To convert checks from DITA reference `tools/qacompiler/qa_checks_r.dita` to QA check:

```
ant compilechecks
```

To use the checks, in `xsl/_qa_checks.xsl` uncomment the `xsl:include` line for `_qa_checks_term.xsl` and remove the `term` template.

To convert checks written as `xsl:if` statements apply the `tools/qacompiler/qa_decompiler.xsl` transform on `xsl/_qa_checks.xsl`.

## Troubleshooting

If the data file (_mapname_.dita) is not generated, ensure you specified `-Dsetchunk=true` in the build command or set `@chunk=to-content` on the root element of the map.
