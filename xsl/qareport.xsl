<?xml version="1.0" encoding="UTF-8"?>
<!-- This file is part of the org.dita-community.qa project hosted on 
     Sourceforge.net.-->
<!-- (c) Copyright Ditanauts All Rights Reserved. -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:dita="***Function Processing***" xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/">
	<xsl:output method="html"/>
	<xsl:template match="/">
		<!-- Read in the rest of the document as a global variable from which we will query data into its respective containers. -->
		<xsl:variable name="thisDoc">
			<xsl:copy-of select="*"/>
		</xsl:variable>
		<!-- Collect document-level data  -->
		<xsl:variable name="docTitle">
			<xsl:value-of select="$thisDoc//data[@name = 'docTitle']"/>
		</xsl:variable>
		<xsl:variable name="inputMap">
			<xsl:value-of select="$thisDoc//data[@name = 'inputMap']"/>
		</xsl:variable>
		<xsl:variable name="reportDate">
			<xsl:value-of select="$thisDoc//data[@name = 'reportDate']"/>
		</xsl:variable>
		<xsl:variable name="fileRoot">
			<xsl:value-of select="$thisDoc//data[@name = 'fileRoot']"/>
		</xsl:variable>
		<xsl:variable name="languageSet">
			<xsl:value-of select="$thisDoc//data[@name = 'languageSet']"/>
		</xsl:variable>
		<xsl:variable name="versionsDita">
			<xsl:value-of select="$thisDoc//data[@name = 'versionsDita']"/>
		</xsl:variable>
		<xsl:variable name="domainsUsed">
			<xsl:value-of select="$thisDoc//data[@name = 'domainsUsed']"/>
		</xsl:variable>
		<xsl:variable name="length">
			<xsl:value-of select="$thisDoc//data[@name = 'length']"/>
		</xsl:variable>
		<!-- violation info-->
		<xsl:variable name="totalUrgent">
			<xsl:value-of select="$thisDoc//data[@name = 'totalUrgent']"/>
		</xsl:variable>
		<xsl:variable name="totalOptional">
			<xsl:value-of select="$thisDoc//data[@name = 'totalOptional']"/>
		</xsl:variable>
		<xsl:variable name="totalRecommended">
			<xsl:value-of select="$thisDoc//data[@name = 'totalRecommended']"/>
		</xsl:variable>
		<xsl:variable name="totalLow">
			<xsl:value-of select="$thisDoc//data[@name = 'totalLow']"/>
		</xsl:variable>
		<xsl:variable name="totalViolations"> <!-- not counting low -->
			<xsl:value-of select="sum($totalUrgent + $totalOptional + $totalRecommended)"/>
		</xsl:variable>
		<xsl:variable name="passiveVoice">
			<xsl:value-of select="count(//data[contains(@importance, 'recommended')][contains(@outputclass, 'lang passive')])"/>		
		</xsl:variable>
		
		<!-- Collect topic-level info -->
		<xsl:variable name="topicsTotal">
			<xsl:value-of select="$thisDoc//data[@name = 'topicsTotal']"/>
		</xsl:variable>
		<xsl:variable name="topicsConcept">
			<xsl:value-of select="$thisDoc//data[@name = 'topicsConcept']"/>
		</xsl:variable>
		<xsl:variable name="topicsTask">
			<xsl:value-of select="$thisDoc//data[@name = 'topicsTask']"/>
		</xsl:variable>
		<xsl:variable name="topicsReference">
			<xsl:value-of select="$thisDoc//data[@name = 'topicsReference']"/>
		</xsl:variable>
		<xsl:variable name="imagesTotal">
			<xsl:value-of select="$thisDoc//data[@name = 'imagesTotal']"/>
		</xsl:variable>
		<xsl:variable name="linkTotal">
			<xsl:value-of select="count($thisDoc//data[contains(@outputclass, 'link')])"/>
		</xsl:variable>
		<xsl:variable name="totalComplexity">
			<xsl:value-of select="sum(//data[contains(@outputclass, 'step-count')])"/>
		</xsl:variable>
		<xsl:variable name="readingTime">
			<xsl:value-of select="$thisDoc//data[@name = 'totalWords'] div 150 div 60"/>
		</xsl:variable>
		<!-- conditionsfound -->
		<xsl:variable name="filterFile">
			<xsl:value-of select="$thisDoc//data[@name = 'filterFile']"/>
		</xsl:variable>
		<xsl:variable name="audienceProp">
			<xsl:value-of select="$thisDoc//data[@name = 'audienceProp']"/>
		</xsl:variable>
		<xsl:variable name="platformProp">
			<xsl:value-of select="$thisDoc//data[@name = 'platformProp']"/>
		</xsl:variable>
		<xsl:variable name="productProp">
			<xsl:value-of select="$thisDoc//data[@name = 'productProp']"/>
		</xsl:variable>
		<xsl:variable name="otherProps">
			<xsl:value-of select="$thisDoc//data[@name = 'otherProps']"/>
		</xsl:variable>
		<!-- elementcounts -->
		<xsl:variable name="distinctElements">
			<xsl:value-of select="$thisDoc//data[@name = 'distinctElements']"/>
		</xsl:variable>
		<xsl:variable name="totalElements">
			<xsl:value-of select="$thisDoc//data[@name = 'totalElements']"/>
		</xsl:variable>
		<xsl:variable name="totalWords">
			<xsl:value-of select="$thisDoc//data[@name = 'totalWords']"/>
		</xsl:variable>
		<!-- violation ratios-->
		<xsl:variable name="violationRatioW"> 
			<xsl:value-of select="round($totalWords div $totalViolations)"/>
		</xsl:variable>
		<xsl:variable name="violationRatioP"> 
			<xsl:value-of select="format-number(round($totalWords div 250) div $totalViolations, '0.00')"/>
		</xsl:variable>

		
		<!-- create .js files for each chart -->
		<!-- violations chart -->
		<xsl:result-document href="js/violations.js" method="text">
			google.load("visualization", "1", {packages:["corechart"]});
			  google.setOnLoadCallback(drawChart);
			  function drawChart() {
				var data = google.visualization.arrayToDataTable([
					  ['Importance', 'Number of Flags'],
					  ['Urgent' , <xsl:value-of select="$totalUrgent"/>],
					  ['Recommended', <xsl:value-of select="$totalRecommended"/>],
					  ['Optional', <xsl:value-of select="$totalOptional"/>]
					]);

      var options = {
        legend: {position:'right', textStyle: {fontSize: 18}},
        pieSliceText: 'value',
        pieSliceTextStyle:{fontSize: 18},
        colors:['BD0019','FFB803','73D653'],
        height:400, width:550,
        chartArea:{left:5,top:0,width:"90%",height:"90%"}
      };

        var chart = new google.visualization.PieChart(document.getElementById('violationPie'));
        chart.draw(data, options);
      }
		</xsl:result-document>
		<!-- urgent violations by type chart -->
		<xsl:result-document href="js/urgent.js" method="text">
			google.load("visualization", "1", {packages:["corechart"]});
			  google.setOnLoadCallback(drawChart);
			  function drawChart() {
				var data = google.visualization.arrayToDataTable([
					  ['Type', 'Number of Flags'],
					  ['XD7 Terms' , <xsl:value-of select="count(//data[contains(@importance, 'urgent')][contains(@outputclass, 'term xd7')])"/>],
			['MMSTP', <xsl:value-of select="count(//data[contains(@importance, 'urgent')][contains(@outputclass, 'term mmstp')])"/>],
			['Tagging', <xsl:value-of select="count(//data[contains(@importance, 'urgent')][contains(@outputclass, 'tag')])"/>],
			['Edu Terms', <xsl:value-of select="count(//data[contains(@importance, 'urgent')][contains(@outputclass, 'term edu')])"/>],
			['Language', <xsl:value-of select="count(//data[contains(@importance, 'urgent')][contains(@outputclass, 'lang general')])"/>]
					]);

      var options = {
        legend: {position:'right', textStyle: {fontSize: 18}},
        pieSliceText: 'value',
        pieSliceTextStyle:{fontSize: 18},
        colors:['844cb0','0079bd','70963e','669999','999966','ab9c33'],
        height:400, width:550,
        chartArea:{left:5,top:0,width:"90%",height:"90%"}
      };

        var chart = new google.visualization.PieChart(document.getElementById('urgentPie'));
        chart.draw(data, options);
      }
		</xsl:result-document>
		<!-- recommended violations by type chart -->
		<xsl:result-document href="js/recommended.js" method="text">
			google.load("visualization", "1", {packages:["corechart"]});
			  google.setOnLoadCallback(drawChart);
			  function drawChart() {
				var data = google.visualization.arrayToDataTable([
					  ['Type', 'Number of Flags'],
					  ['MMSTP', <xsl:value-of select="count(//data[contains(@importance, 'recommended')][contains(@outputclass, 'term mmstp')])"/>],
			['Tagging', <xsl:value-of select="count(//data[contains(@importance, 'recommended')][contains(@outputclass, 'tag')])"/>],
			['Edu Terms', <xsl:value-of select="count(//data[contains(@importance, 'recommended')][contains(@outputclass, 'term edu')])"/>],
			['Language', <xsl:value-of select="count(//data[contains(@importance, 'recommended')][contains(@outputclass, 'lang general')])"/>],
					  ['Passive Voice', <xsl:value-of select="$passiveVoice"/>]
					]);

      var options = {
        legend: {position:'right', textStyle: {fontSize: 18}},
        pieSliceText: 'value',
        pieSliceTextStyle:{fontSize: 18},
        colors:['844cb0','0079bd','70963e','669999','999966','ab9c33','e99402'],
        height:400, width:550,
        chartArea:{left:5,top:0,width:"90%",height:"90%"}
      };

        var chart = new google.visualization.PieChart(document.getElementById('recommendedPie'));
        chart.draw(data, options);
      }
		</xsl:result-document>
		<!-- optional violations by type chart -->
		<xsl:result-document href="js/optional.js" method="text">
			google.load("visualization", "1", {packages:["corechart"]});
			  google.setOnLoadCallback(drawChart);
			  function drawChart() {
				var data = google.visualization.arrayToDataTable([
					  ['Type', 'Number of Flags'],
					  ['MMSTP', <xsl:value-of select="count(//data[contains(@importance, 'optional')][contains(@outputclass, 'term mmstp')])"/>],
			['Tagging', <xsl:value-of select="count(//data[contains(@importance, 'optional')][contains(@outputclass, 'tag')])"/>],
			['Language', <xsl:value-of select="count(//data[contains(@importance, 'optional')][contains(@outputclass, 'lang')])"/>]			  
					]);

      var options = {
       legend: {position:'right', textStyle: {fontSize: 18}},
        pieSliceText: 'value',
        pieSliceTextStyle:{fontSize: 18},
        colors:['844cb0','0079bd','70963e','999966'],
        height:400, width:550,
        chartArea:{left:5,top:0,width:"90%",height:"90%"}
      };

        var chart = new google.visualization.PieChart(document.getElementById('optionalPie'));
        chart.draw(data, options);
      }
		</xsl:result-document>
		<!-- word count chart -->
		<xsl:result-document href="js/wordcount.js" method="text">
					google.load("visualization", "1", {packages:["corechart"]});
					google.setOnLoadCallback(drawChart);
				  function drawChart() {
					var data = google.visualization.arrayToDataTable([
				  ['Topic #', 'Words'],
<xsl:for-each select="/topic/body/section[contains(@outputclass, 'topicReport')]">['<xsl:value-of select="position()"/>', <xsl:value-of select="data[contains(@name, 'wordCount')]"/>]<xsl:if test="position() &lt; last()">,</xsl:if>
			</xsl:for-each>
        ]);

      var options = {
        legend: 'none',
        pieSliceText: 'label',
        pieStartAngle: 0,
        height:400,
		width:500,
        chartArea:{left:5,top:0,width:"90%",height:"90%"}
      };

        var chart = new google.visualization.LineChart(document.getElementById('wordsLine'));
        chart.draw(data, options);
      }
					</xsl:result-document>
		<!-- frequency chart -->
		<xsl:result-document href="js/wordfrequency.js" method="text">
	google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Junk Word', 'Frequency'],<xsl:for-each-group group-by="@value" select="//data[@name='word']">
				<xsl:sort select="sum(current-group())" order="descending"/>
				<xsl:if test="position() &lt; 11">["<xsl:value-of select="current-grouping-key()"/>",<xsl:value-of select="sum(current-group())"/>],</xsl:if>
			</xsl:for-each-group>
        ]);

      var options = {
        legend: 'none',
        height:400,
		width:500,
        chartArea:{left:5,top:0,width:"90%",height:"90%"}
      };

        var chart = new google.visualization.BarChart(document.getElementById('freqLine'));
        chart.draw(data, options);
      }
	</xsl:result-document>
	
		
		<!-- passive voice -->
		<xsl:result-document href="js/passivevoice.js" method="text">
		google.load('visualization', '1', {packages:['gauge']});
      google.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Label', 'Value'],
          ['%', <xsl:value-of select="format-number(count(//data[contains(@name, 'hasPassive')][contains(.,'true')]) div $topicsTotal * 100, '###')"/>]
        ]);

        var options = {
          redFrom: 75, redTo: 100,
          yellowFrom:30, yellowTo: 75,
          greenFrom:0, greenTo: 30,
          minorTicks: 5,
          height:300,
		  width:500,
          chartArea:{left:5,top:0,width:"90%",height:"90%"}
        };

        var chart = new google.visualization.Gauge(document.getElementById('passivometer'));
        chart.draw(data, options);
      }
		</xsl:result-document>

		<!-- start HTML markup -->
		<html>
			<head>
				<meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>
				<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
				<title>Quality Report</title>
				<link href="css/qa_report.css" rel="stylesheet" type="text/css"> </link>
				<link href="css/bootstrap.min.css" rel="stylesheet"> </link>
				<link href="css/bootstrap-theme.min.css" rel="stylesheet"> </link>
				<script type="text/javascript" src="https://www.google.com/jsapi"> </script>
				<script type="text/javascript" src="js/violations.js"/>
				<script type="text/javascript" src="js/urgent.js"/>
				<script type="text/javascript" src="js/recommended.js"/>
				<script type="text/javascript" src="js/optional.js"/>
				<script type="text/javascript" src="js/wordcount.js"/>
				<script type="text/javascript" src="js/wordfrequency.js"/>
				<script type="text/javascript" src="js/passivevoice.js"/>
				<script src="js/jquery.js"/>
				<!-- Include all compiled plugins (below), or include individual files as needed -->
				<script src="js/bootstrap.min.js"/>
			</head>
			<body>
				<div class="container">
					<div class="jumbotron">
						<h1>Content Quality Report</h1>
						<p>Generated by <a href="http://ditanauts.org">Ditanauts</a>&#xA0;<a href="https://github.com/dita-community/org.dita-community.qa">QA Plugin</a></p>
					</div>
					<h1>
						<xsl:value-of select="$docTitle"/>
					</h1>
					<!--<p><span class="metric">Length: <xsl:value-of select="$length"/> | Modality:<xsl:value-of select="$modality"/></span></p>-->
					<p>Hover over charts to see a brief descripition, or jump down to the <a href="#explanations">explanations</a>. The report also includes <a href="#build">build information</a>.</p>
					<h2 id="dashboard">Quality Overview</h2>
					<div class="row">
						<div class="col-md-6">
							<h4>Violations by Severity</h4>
							<div id="violationPie" title="Displays violations by severity. Does not include low-severity issues."/>
								<br/>
								<a class="violation_link" title="Contains all violations. Open in Excel and sort data into columns.">
									<xsl:attribute name="href"><xsl:value-of select="concat($fileRoot, '-violations.csv')"/></xsl:attribute>Download Violations Spreadsheet (.csv)</a>
						</div>
						<div class="col-md-6">
								<div>
								<span class="metric">QA detected </span>
								<span class="value">
									<xsl:value-of select="$totalViolations"/>
								</span>
								<span class="metric"> violations.</span>
								<br/>
								<span class="metric">A violation appears about every </span>
									<span class="value" title="Based on 250 words per page.">
									<xsl:value-of select="$violationRatioP"/>
									</span>
									<span class="metric"> pages. </span><br/>	
								<span class="metric">Passive voice represents </span>
								<span class="value">
									<xsl:value-of select="format-number($passiveVoice div $totalViolations * 100, '00')"/>
								</span>
								<span class="metric"> percent of the total violations.</span>
								</div>
						</div>
					</div>
					<hr/>
					<h2 id="violations">Violations by Type</h2>
					<div class="row">
						<div class="col-md-6">
						<h4>Urgent Violations by Type</h4>
						<div id="urgentPie" title="Displays issues marked urgent. These issues must be resolved."/>
						</div>
						<div class="col-md-6">
						<h4>Recommended Violations by Type</h4>
						<div id="recommendedPie" title="Displays issues marked recommended. As many of these issues as possible should be resolved."/>
						</div>
						<div class="col-md-6">
						<h4>Optional Violations by Type</h4>
						<div id="optionalPie" title="Displays issues marked optional. Try to resolve these issues."/>
						</div>
					</div>
					<hr/>
				<h2 id="lang">Language and Asset Counts</h2>
				<div class="row">
					<div class="col-md-6">
						<h4>% Passive Topics</h4>
						<div id="passivometer" title="Displays the percent of total topics that contain one or more instances of passive voice."/>
					</div>
					<div class="col-md-6">
						<h4>Junk Word Frequency</h4>
						<div id="freqLine"/>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<span class="value">
							<xsl:value-of select="$totalWords"/>
						</span>
						<span class="metric"> Total Words</span>
						<br/>
						<span class="value">
								<xsl:value-of select="$imagesTotal"/>
							</span>
							<span class="metric"> Images</span>
							<br/>
							<span class="value">
								<xsl:value-of select="$linkTotal"/>
							</span>
							<span class="metric"> Links</span>
							<br/>
					</div>
					<div class="col-md-6">
						<h4>Word Count per Topic</h4>
						<div id="wordsLine"/>
					</div>
				</div>
				<hr/>
				<h2 id="links">External References</h2>
				<div class="row">
					<div class="col-md-5">
						<img src="css/popup_icon.jpg"/>
					</div>
					<div class="col-md-5 info">
						<div class="infocontent">
							<ul>
								<xsl:for-each select="distinct-values(descendant-or-self::*[contains(@outputclass, 'link')])">
									<li>
										<a target="_blank">
											<xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
											<xsl:value-of select="."/>
										</a>
									</li>
								</xsl:for-each>
							</ul>
						</div>
					</div>
				</div>
				<hr/>
				<h2 id="explanations">Explanation of Metrics</h2>
				<h3>Language Violations</h3>
				<p>The language quality section includes a breakdown of QA issues by severity and type. All violations labled Required must be addressed. Violations labled Normal should be evaluated. Violations labled Low include link data, filtering data, and violations that have a high rate of false-positives.</p>
				<p>The "violations per page" metric is based on the assumption that there are about 250 words per page. </p>
				<p>Download the Violations Report to see a full list of each error. To vew the report:</p>
				<ol>
					<li>Open the <xsl:value-of select="$fileRoot"/>.csv file in Excel.</li>
					<li>Format the data as a table.</li>
				</ol>
				<p>You can then filter by Flag, Type, or Severity; sort by topic; or search for specific issues. Columns have also been provided for "Assigned To" and "Action Taken."</p>
				<h3>Reading Time</h3>
				<p>Reading time is calculated by dividing the total number of words by 150. This is based on an average adult reading speed of 100-200 words per minute for technical material.</p>
				<h3>% Passive Topics</h3>
				<p>This metric indicates the percent of total topics that include at least one statement in passive voice.</p>
				<h3>Word Counts</h3>
				<p>The purpose of the chart is to highlight topics that have significantly higher or lower word counts relative to other topics in the course. While some variation is expected, topics that cause drastic changes in count should be evaluated.</p>
				<h3>Junk Word Frequency</h3>
				<p>The purpose of the chart is to highlight frequency of "junk" words, or words that offer little value to the reader because they are vague or meaningless.</p>
				<hr/>
				<h2 id="build">Build Information</h2>
				<table border="1">
					<tbody>
						<tr>
							<td>Report run on</td>
							<td>
								<xsl:value-of select="$reportDate"/>
							</td>
						</tr>
						<tr>
							<td>Build Info</td>
							<td>
								<a href="qalog.xml" target="_blank">View Build Log</a>
								<br/>
								<a target="_blank">
									<xsl:attribute name="href"><xsl:value-of select="concat($fileRoot, '.data')"/></xsl:attribute>View Data File</a>
							</td>
						</tr>
						<tr>
							<td>Map</td>
							<td>
								<xsl:value-of select="$inputMap"/>
							</td>
						</tr>
						<tr>
							<td>Filter file</td>
							<td>
								<xsl:value-of select="$filterFile"/>
							</td>
						</tr>
						<tr>
							<td>Language values</td>
							<td>
								<xsl:value-of select="$languageSet"/>
							</td>
						</tr>
						<tr>
							<td>DITA versions</td>
							<td>
								<xsl:value-of select="$versionsDita"/>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
