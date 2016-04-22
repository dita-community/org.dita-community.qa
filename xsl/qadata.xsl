<?xml version="1.0" encoding="UTF-8"?>
<!-- This file is part of the org.dita-community.qa project hosted on Sourceforge.net.-->
<!-- (c) Copyright Ditanauts All Rights Reserved. 
xmlns:qa="****Function Processing****"
-->
<xsl:stylesheet 
version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:fo="http://www.w3.org/1999/XSL/Format"
xmlns:fn="http://www.w3.org/2005/xpath-functions"
xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
exclude-result-prefixes="xsl xs fo fn ditaarch"
>
	<xsl:param name="input"/>
	<xsl:param name="fileroot"/>
	<xsl:param name="OUTPUTDIR" />
	<xsl:param name="FILTERFILE" />
	<xsl:param name="BASEDIR" />
	<xsl:param name="tempInput"/>
	<xsl:include href="qachecks/_qa_checks.xsl"/>

	<!-- for 1.x OT versions, use doctype-system="../dtd/technicalContent/dtd/topic.dtd" -->
	<xsl:output 
		method="xml" 
		indent="yes" 
		doctype-public="-//OASIS//DTD DITA Topic//EN"
		doctype-system="../plugins/org.oasis-open.dita.v1_2/dtd/technicalContent/dtd/topic.dtd"
	/>
	
	<xsl:key name="tagErrors" match="data" use="@importance" />

	<xsl:template match="/">
	
		<!-- query all the report data into variables that will be "saved" into semantic XML names later -->
		<xsl:variable name="thisDoc">
		    <xsl:copy-of select="*"/>
		</xsl:variable>
		<xsl:variable name="hitCount">
	       <xsl:for-each select="$thisDoc//*[contains(@class,'topic/body ')]">
					   <xsl:call-template name="filtering"/>
					   <xsl:call-template name="lang"/>
					   <xsl:call-template name="tag"/>
					   <xsl:call-template name="term"/>
					   <xsl:call-template name="xrefs"/>
					   <xsl:call-template name="passiveVoice"/>
			</xsl:for-each> 
	    </xsl:variable>
	    <xsl:variable name="totalUrgent"><xsl:value-of select="count(key('tagErrors', 'urgent', $hitCount))"/></xsl:variable>
	    <xsl:variable name="totalRecommended"><xsl:value-of select="count(key('tagErrors', 'recommended', $hitCount))"/></xsl:variable>
	    <xsl:variable name="totalOptional"><xsl:value-of select="count(key('tagErrors', 'optional', $hitCount))"/></xsl:variable>
	    <xsl:variable name="totalLow"><xsl:value-of select="count(key('tagErrors', 'low', $hitCount))"/></xsl:variable>
	    <xsl:variable name="totalViolations">
	    <xsl:value-of select="sum($totalLow + $totalOptional + $totalRecommended + $totalUrgent)"/>
	    </xsl:variable>
	    <xsl:variable name="OTDIR">
			<xsl:value-of select="replace($BASEDIR, '\\', '/')" />
	    </xsl:variable>
	    <xsl:variable name="inputMap">
			<xsl:value-of select="concat('file:///' ,$input)"/>
	    </xsl:variable>
		<xsl:variable name="tempMap">
			<xsl:value-of select="concat('file:///',$tempInput)"/>
		</xsl:variable>
		
		<!-- start building the XML database module here -->
		<topic id="qadata{generate-id}">
		<title>QA report data</title>
	    <body>
	    	<section id="overall{generate-id()}" outputclass="overallData">
	    		<data type="docdata" name="docTitle">
	    			<xsl:choose>
	    				<xsl:when test='document($tempMap)//mainbooktitle'>
	    					<!-- trying to get the bookmap title, but the document function works relative to this xsl file, 
	    					not to build.xml, so the input variable doesn't point to an actual document -->
		    				<xsl:value-of select="document($tempMap)//mainbooktitle"/>
	    				</xsl:when>
	    				<xsl:otherwise>
	    					<!-- DRD: so we'll provide a fallback -->
		    				<xsl:value-of select="document($tempMap)/*/title"/>
	    				</xsl:otherwise>
	    			</xsl:choose>
	    		</data>
				<data type="docdata" name="inputMap"><xsl:value-of select="$inputMap"/></data>
				<data type="docdata" name="reportDate"><xsl:value-of select="format-date(current-date(), '[M01]/[D01]/[Y0001]') "/></data>
				<data type="docdata" name="fileRoot"><xsl:value-of select="$fileroot"/></data>
				<data type="docdata" name="languageSet"><xsl:value-of select="distinct-values(//*/@xml:lang)" separator=", " /></data>
				<data type="docdata" name="versionsDita"><xsl:value-of select="distinct-values($thisDoc//*/@ditaarch:DITAArchVersion)" separator=", " /></data>
				<data type="docdata" name="domainsUsed">
					<!-- lists each unique domain value, but it is/was a long list -->	
					<xsl:variable name="domdata2"><xsl:value-of select="distinct-values(//*/@domains)" separator=", " /></xsl:variable>
					<xsl:variable name="domdata"><xsl:value-of select="distinct-values(tokenize($domdata2, '\)+'))" /></xsl:variable>
            		<xsl:for-each select="tokenize($domdata, '\(+')">(<xsl:value-of select="normalize-space(.)"/>)
</xsl:for-each>
				</data>
				<!-- total up violations by severity and type -->
				<data type="results" name="totalViolations"><xsl:value-of select="$totalViolations"/></data> 
				<data type="results" name="totalUrgent"><xsl:value-of select="$totalUrgent"/></data>
				<data type="results" name="totalRecommended"><xsl:value-of select="$totalRecommended"/></data>
				<data type="results" name="totalOptional"><xsl:value-of select="$totalOptional"/></data>
				<data type="results" name="totalLow"><xsl:value-of select="$totalLow"/></data>
				<!-- count topics of various types -->
				<data type="topicinfo" name="topicsTotal"><xsl:value-of select="count(//*[contains(@class,' topic/topic ')])"/></data>
				<data type="topicinfo" name="topicsConcept"><xsl:value-of select="count(//*[contains(@class,' topic/topic concept/concept')])"/></data>
				<data type="topicinfo" name="topicsTask"><xsl:value-of select="count(//*[contains(@class,' topic/topic task/task')])"/></data>
				<!-- counting any topic with an ol or steps -->
				<data type="topicinfo" name="topicsFakeTask"><xsl:value-of select="count(//*[(contains(@class,'topic/body') and descendant::*[contains(@class, 'topic/ol')])])"/></data>
				<data type="topicinfo" name="topicsReference"><xsl:value-of select="count(//*[contains(@class,' topic/topic reference/reference')])"/></data>
				<data type="elementcounts" name="totalWords"><xsl:value-of select="count(tokenize(lower-case(.),'(\s|[,.?!:;])+')[string(.)])"/></data>
				<data type="topicinfo" name="totalProcedures"><xsl:value-of select="count(//*[contains(@class,'topic/ol')])"/></data>
				<data type="topicinfo" name="imagesTotal"><xsl:value-of select="count(//image)"/></data>
				<data type="conditionsfound" name="filterFile">
					<!-- set up a choose , when filterfile is set, spit out the name, when it is not, say filter not applied -->
					<xsl:choose>
						<xsl:when test='$FILTERFILE != ""'>
							<xsl:value-of select="$FILTERFILE"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>Filter not applied</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</data> 
				<data type="conditionsfound" name="audienceProp"><xsl:value-of select="distinct-values(//*/@audience)" separator=", " /></data>
				<data type="conditionsfound" name="platformProp"><xsl:value-of select="distinct-values(//*/@platform)" separator=", " /></data>
				<data type="conditionsfound" name="productProp"><xsl:value-of select="distinct-values(//*/@product)" separator=", " /></data>
				<data type="conditionsfound" name="otherProps"><xsl:value-of select="distinct-values(//*/@otherprops)" separator=", "/></data>
			</section>
			<!-- nested sections not allowed here in DITA; the topic reports are sufficiently distinctive now -->
			<xsl:apply-templates select="//*[contains(@class,' topic/body ')]"/>
	    </body>
	    </topic>
	</xsl:template>
	
	<xsl:template match="*[contains(@class,' topic/body ')]">
		<xsl:for-each select="self::conbody | self::taskbody | self::refbody | self::body | self::ctxTrainingBody">
			<!-- DRD: as this section title indicates, our variables will need to be scoped by topic, making the names unique somehow -->
			<section id="report{generate-id()}" outputclass="topicReport">
				<xsl:text>Topic: </xsl:text>
				<xref>
					<xsl:attribute name="href">
						<xsl:value-of
							select="replace(replace(substring-after(@xtrf, 'C:'), '\\', '/'), ' ', '%20')"/>
<!--						<xsl:value-of select="encode-for-uri(concat('file:///', replace(@xtrf, '\\', '/')))"/>-->
					</xsl:attribute>
					<xsl:value-of select="preceding-sibling::title[contains(@class, ' topic/title ')]"/>
				</xref>
				<data type="topicreport" name="topicTitle"><xsl:value-of select="preceding-sibling::title[contains(@class, ' topic/title ')]"/></data>
				<data type="topicreport" name="filePath"><xsl:value-of select="@xtrf"/></data>
				<data type="topicreport" name="wordCount"><xsl:value-of select="count(tokenize(lower-case(ancestor::*[contains(@class, ' topic/topic ')][1]),'(\s|[,.?!:;])+')[string(.)])"/></data>
				<data type="topicreport" name="filtering"><xsl:call-template name="filtering"/></data>
				<data type="topicreport" name="term"><xsl:call-template name="term"/></data>
				<data type="topicreport" name="lang"><xsl:call-template name="lang"/></data>
				<data type="topicreport" name="tag"><xsl:call-template name="tag"/></data>
				<data type="topicreport" name="wordFrequency"><xsl:variable name="junkwords" 
				select="(
					'a lot',
					'a bit',
					'a number of ',
					'actually',
					'almost',
					'approximately',
					'basically',
					'can',
					'could',
					'eventually',
					'fairly',
					'few',
					'huge',
					'infinitely',
					'kind of',
					'largely',
					'many',
					'may',
					'maybe',
					'might',
					'mostly',
					'nearly',
					'perhaps',
					'practically',
					'probably',
					'quite',
					'really',
					'several',
					'shall',
					'should',
					'slightly',
					'some',
					'sometimes',
					'somewhat',
					'sort of',
					'tiny',
					'usually',
					'various',
					'vast',
					'very',
					'would'
					)"/>
					<xsl:for-each-group group-by="." select="for $w in tokenize(lower-case(ancestor::*[contains(@class, ' topic/topic ')][1]),'(\s|[,.?!:;])+')[string(.)=$junkwords] return $w">
						<xsl:if test="count(current-group())>0">
							<data name="word" value="{current-grouping-key()}"><xsl:value-of select="count(current-group())"/></data>
						</xsl:if>
					</xsl:for-each-group>
				 </data>	
				 <data type="topicreport" name="xrefs"><xsl:call-template name="xrefs"/></data>			 
				 <data type="topicreport" name="passiveVoice">
					<xsl:call-template name="passiveVoice"/>
				 </data>
			</section>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>