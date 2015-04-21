About
-----
This DITA Open Toolkit plugin identifies errors in DITA tagging, element nesting, language standards, and common syntax errors, 
many of which are based on the Microsoft Manual of Style for Technical Publications. A quality assurance report is created as a single HTML file 
containing links to each project topic file and a stylized DITA Open Toolkit build log. 
Quality assurance checks are highly customizable to fit project needs.

www.ditanauts.org


Release Notes
-------------

-Set 'to-content' chunk attribute automatically on bookmap and map elements
--chunk attribute is set only if -Dsetchunk=true at command line
-Updated HTML report style using Bootstrap
-Chart data modified to use Google charts
-Included transform tool to enable authoring of QA checks as DITA reference  
-General plug-in enhancements:
--Generates CSV file containing all errors
--Generates data file containing all errors
 

Usage
-----

To run the standard test transform:

ant -Dtranstype=qa -logger=org.apache.tools.ant.XmlLogger -logfile=out/qalog.xml -Douter.control=quiet -Dsetchunk=true -Dargs.input=samples/taskbook.ditamap


Additional Tools
----------------

To invoke the QA Compiler tool example (convert from DITA reference to QA check):

java -jar lib/saxon/saxon9.jar -xsl:plugins/org.dita-community.qa/tools/qacompiler/qa_compiler.xsl -o:out/_qa_checks.xsl -s:plugins/org.dita-community.qa/tools/qacompiler/qa_checks_r.dita




