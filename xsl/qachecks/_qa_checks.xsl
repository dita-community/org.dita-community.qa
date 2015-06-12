<?xml version="1.0" encoding="UTF-8"?>
<!-- This file is part of the org.dita-community.qa project hosted on 
     Sourceforge.net.-->
<!-- (c) Copyright Ditanauts All Rights Reserved. -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" exclude-result-prefixes="xsl fo xs fn">

	<!-- Uncomment to include checks compiled from tools/qacompiler/qa_checks_r.dita -->
	<!-- Also remove the xsl:template/@name="term" below -->
	<!--<xsl:import href="_qa_checks_term.xsl" />-->
	
<!-- =========== This stylesheet includes all QA checks. 
								The idea is to run all checks against all document types, 
								then filter the results within the report logic ============  -->
								

<!-- when checking for a string that contains more than one word, we need to use normalize-space to account for breaks across lines in the file -->

<xsl:template name="term">
<!--specify elements to exclude from terminology checks-->
<xsl:variable name="excludes" select="not (codeblock or filepath or shortdesc or uicontrol or varname or draft-comment or b or alt)"/>
<xsl:variable name="apostrophe">'</xsl:variable>

<!-- ===================================== -->
<!-- Microsoft Manual of Style for Technical Publications --> <!-- term mmstp -->
<!-- ===================================== -->
<xsl:if test=".//*[$excludes]/text()[contains(.,'and/or')]"><data type="msg" outputclass="term mmstp" importance="urgent">Found "and/or". Expand sentence to be more specific.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Aa]nti-[Vv]irus')]"><data type="msg" outputclass="term mmstp" importance="urgent">Found "anti-virus". Do not hyphenate.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'\s[Bb]oot')]
													  [not(contains(.,' boot file'))]
													  [not(matches(.,'\s[Bb]oot[Ff]ile'))]
													  [not(contains(.,' Boot List'))]
													  [not(contains(.,' Boot Options'))]
													  [not(contains(.,' Boot Server Host'))]
													  [not(matches(.,'\s[Bb]ootstrap'))]
													  [not(contains(.,' bootable ISO'))]
													  [not(contains(.,' boot sector'))]
													  [not(contains(.,' boot service'))]
													  [not(contains(.,'Boot Device Manager'))]
													  [not(contains(.,' boot configuration settings'))]
													  [not(contains(.,'PXE boot'))]
													  [not(contains(.,'(PXE) boot'))]
													  "><data type="msg" outputclass="term mmstp" importance="recommended">Found "boot". Use "turn on" (for physical machines) or "start" (for virtual machines).</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Cc]lick on')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "click on". Use "click".</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Cc]ontext [Mm]enu')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "context menu". Use "shortcut menu".</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Cc]rash')][not(contains(., 'crash dump'))]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "crash". Use "fail", "stop responding", or another appropriate term.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(., 'dialog')][not(contains(., 'dialog box'))]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "dialog". Use "dialog box".</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Dd]rag and drop')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "drag and drop." Use "drag (to)".</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(.,'either/or')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "either/or". Expand sentence to be more specific.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Ee]ngineer') and not(matches(., '[Ee]ngineered')) and not(matches(., '[Ee]ngineering'))]"><data type="msg" outputclass="term mmstp" importance="optional">Found "engineer". Check for need to rephrase as second person.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(.,' foo ')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "foo". Choose another placeholder.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(.,' foobar')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "foobar". Choose another placeholder.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Ff]or more information on')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "for more information on". Use "for more information about"</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(.,'gig ')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "gig". Use the standard abbreviation for the unit (e.g., "GB").</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(.,'gigs')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "gigs". Use the standard abbreviation for the unit (e.g., "GB").</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(.,' hang')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "hang". Use "fail" or "stop responding".</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(.,' hit ')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "hit". Use "press".</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(.,'hkey_local_machine')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "hkey_local_machine". Use "HKLM".</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(.,'hkey_current_user')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "hkey_current_user". Use "HKCU".</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Ii]nsecure')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "insecure". Use "not secure".</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Ii]nstantiate')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "instantiate". Use "create an instance of".</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(.,'kbps')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "kbps". Use "KB per second" (for bytes) or "Kb per second" (for bits).</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Ll]everage')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "leverage". Use "use", "take advantage of", "capitalize on", or another more appropriate word or phrase.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(.,' login ')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "login". Use "log on" (verb) or "logon" (noun or adjective).</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(.,' log in ')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "log in". Use "log on" (verb) or "logon" (noun or adjective).</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Ll]ogged in ')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "logged in". Use "logged on" (verb).</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Ll]ogoff of ')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "logoff of". Use "log off from" (verb).</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Ll]og off of ')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "log off of". Use "log off from" (verb).</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Ll]og onto')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "log onto". Use "log on to" (verb).</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Ll]og out')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "log out". Use "log off" (verb) or "logoff" (noun or adjective).</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Ll]ogout')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "logout". Use "log off" (verb) or "logoff" (noun or adjective).</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(.,'mouse over')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "mouse over". Use a phrase such as "move the pointer over the button" or "hover".</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Mm]ulti-')]"><data type="msg" outputclass="term mmstp" importance="optional">Found "multi-". Remove hyphen or reword phrase.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Nn]avigate to')]"><data type="msg" outputclass="term mmstp" importance="urgent">Found "navigate to". Use "browse to" or "go to".</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Oo]bfuscate')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "obfuscate". Use "conceal", "obscure", or some other less clumsy word.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Pp]atch')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "patch". Use "update".</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Pp]op-up')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "pop-up". Use "dialog box".</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Pp]ower on')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "power on". Use "turn on" (for physical machines) or "start" (for virtual machines).</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Pp]ower up')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "power up". Use "turn on" (for physical machines) or "start" (for virtual machines).</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Pp]ower off')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "power off". Use "turn off" (for physical machines) or "shut down" (for virtual machines).</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Pp]ower down')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "power down". Use "turn off" (for physical machines) or "shut down" (for virtual machines).</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Pp]urge')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "purge". Use "delete", "clear", or "remove".</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(.,'radio button')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "radio button". Use "option" or the label name in the interface.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'reboot')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "reboot". Use "restart".</data></xsl:if> <!-- not checking for Reboot-->
<xsl:if test=".//*[$excludes]/text()[contains(.,'(s)')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "(s)". Use the plural or "one or more".</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Ss]lave')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "slave". Use "subordinate", "client", "worker", or another appropriate term.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Ss]ystem prompt')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "system prompt". Use "command prompt".</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Tt]oggle')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "toggle". Use "switch", "click", or "turn on and turn off".</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Uu]tilize')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "utilize". Use "use".</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Ww]indows start button')]"><data type="msg" outputclass="term mmstp" importance="recommended">Found "Windows start button". Use "Start button".</data></xsl:if>


<!-- ===================================== -->
<!--  UI Writing Style Guide Examples --> <!-- term ctxui -->
<!-- ===================================== -->
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Aa]bort')]"><data type="msg" outputclass="term ctxui" importance="recommended">Instead of "abort" use "cancel" or "stop."</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Aa]s long as')]"><data type="msg" outputclass="term ctxui" importance="recommended">Instead of "as long as" use "provided that" or "if."</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Dd]omestic')]"><data type="msg" outputclass="term ctxui" importance="recommended">Avoid using "domestic" to refer to the United States. Use a more specific reference, like "in the US."</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(.,'e.g.')]"><data type="msg" outputclass="term ctxui" importance="recommended">Instead of "e.g." use "for example."</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(.,'etc.')]"><data type="msg" outputclass="term ctxui" importance="recommended">Instead of "etc." use "and so on" or "and so forth."</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Ee]xecute')]"><data type="msg" outputclass="term ctxui" importance="recommended">Avoid "execute" when referring to commands. Use "start" or "run" instead.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Tt]erminal error')]"><data type="msg" outputclass="term ctxui" importance="recommended">Avoid "terminal error." Use "unrecoverable error" instead.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Ff]oreign')]"><data type="msg" outputclass="term ctxui" importance="recommended">Avoid "foreign" when referring to a location outside the United States. Use a more specific reference, like "outside the US."</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(.,'gray ')]"><data type="msg" outputclass="term ctxui" importance="recommended">Avoid "gray" when referring to unavailable menu items. Use "not available" or "unavailable" instead.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Gg]rayed out')]"><data type="msg" outputclass="term ctxui" importance="recommended">Avoid "grayed out" when referring to unavailable menu items. Use "not available" or "unavailable" instead.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'/s[Hh]ang')]"><data type="msg" outputclass="term ctxui" importance="recommended">Avoid "hang" when referring to programs that have stopped responding. Use "stop" or "stopped" instead.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Hh]ung')]"><data type="msg" outputclass="term ctxui" importance="recommended">Avoid "hung" when referring to programs that have stopped responding. Use "stop" or "stopped" instead.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(.,'i.e.')]"><data type="msg" outputclass="term ctxui" importance="recommended">Avoid "i.e." Use "that is" instead.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(.,'in spite of')]"><data type="msg" outputclass="term ctxui" importance="recommended">Avoid "in spite of." Use "regardless" or "despite" instead.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'/s[Kk]ill')]"><data type="msg" outputclass="term ctxui" importance="recommended">Avoid "kill." Use "end" or "stop" instead.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Nn]ot many')]"><data type="msg" outputclass="term ctxui" importance="recommended">Avoid using "not many." Use "few" instead.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Oo]n the other hand')]"><data type="msg" outputclass="term ctxui" importance="recommended">Avoid "on the other hand" Use "however" or "alternatively" instead.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Pp]unch')]"><data type="msg" outputclass="term ctxui" importance="recommended">Avoid punch." Use "enter," "press," or "type" instead.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(.,'via')]"><data type="msg" outputclass="term ctxui" importance="recommended">Avoid "via." Use "across," "along," "by," "from," "on," "through," or "using" instead.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Ww]ish')]"><data type="msg" outputclass="term ctxui" importance="recommended">Avoid "wish." Use "want" instead.</data></xsl:if>



<!-- ===================================== -->
<!-- General phrasing/terminology examples --> <!-- term general-->
<!-- ===================================== -->
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Dd]ata [Cc]enter')]"><data type="msg" outputclass="term edu" importance="recommended">Found "data center". Use "datacenter".</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'/s[Cc]lient [Dd]evice')]"><data type="msg" outputclass="term edu" importance="recommended">Found "client device". Use "user device".</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Ee]ndpoint [Dd]evice')]"><data type="msg" outputclass="term edu" importance="recommended">Found "endpoint device". Use "user device".</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(.,'end-user ')]
						[not(contains(.,'end-user access'))]
						[not(contains(.,'end-user acceptance'))]
						[not(contains(.,'end-user account'))]
						[not(contains(.,'end-user adoption'))]
						[not(contains(.,'end-user application'))]
						[not(contains(.,'end-user authentication'))]
						[not(contains(.,'end-user community'))]
						[not(contains(.,'end-user connection'))]
						[not(contains(.,'end-user credential'))]
						[not(contains(.,'end-user customization'))]
						[not(contains(.,'end-user data'))]
						[not(contains(.,'end-user device'))]
						[not(contains(.,'end-user environment'))]
						[not(contains(.,'end-user experience'))]
						[not(contains(.,'end-user frustration'))]
						[not(contains(.,'end-user group'))]
						[not(contains(.,'end-user issue'))]
						[not(contains(.,'end-user location'))]
						[not(contains(.,'end-user logon'))]
						[not(contains(.,'end-user name'))]
						[not(contains(.,'end-user need'))]
						[not(contains(.,'end-user password'))]
						[not(contains(.,'end-user personalization'))]
						[not(contains(.,'end-user profile'))]
						[not(contains(.,'end-user requirement'))]
						[not(contains(.,'end-user satisfaction'))]
						[not(contains(.,'end-user segmentation'))]
						[not(contains(.,'end-user session'))]
						[not(contains(.,'end-user setting'))]
						[not(contains(.,'end-user training'))]
						"><data type="msg" outputclass="term edu" importance="urgent">Found "end-user" that is likely being used as a noun. Do not hyphenate the noun form.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(.,concat('end-user', $apostrophe, 's'))]"><data type="msg" outputclass="term edu" importance="urgent">Found "end-user's". Use "end user's" for the noun form.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(.,concat('end-users', $apostrophe))]"><data type="msg" outputclass="term edu" importance="urgent">Found " end-users' ". Use " end users' " for the noun form.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Pp]rint [Dd]river')]"><data type="msg" outputclass="term edu" importance="recommended">Found "print driver". Use"printer driver".</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[matches(.,'[Ss]erver [Ff]arm')]"><data type="msg" outputclass="term edu" importance="recommended">Found "server farm". Use "farm".</data></xsl:if>


<!--create list of words used in personifications and contractions-->
<xsl:variable name="apos">'</xsl:variable>
<xsl:variable name="company"><xsl:value-of select="concat('company', $apos, 's')"/></xsl:variable>
<xsl:variable name="server"><xsl:value-of select="concat('server', $apos, 's')"/></xsl:variable>
<xsl:variable name="farm"><xsl:value-of select="concat('farm', $apos, 's')"/></xsl:variable>
<xsl:variable name="cant"><xsl:value-of select="concat('can', $apos, 't')"/></xsl:variable>
<xsl:variable name="dont"><xsl:value-of select="concat('don', $apos, 't')"/></xsl:variable>
<xsl:variable name="wont"><xsl:value-of select="concat('won', $apos, 't')"/></xsl:variable>

<!-- insert your company name here -->
<xsl:variable name="compName"><xsl:value-of select="concat('[Company Name]', $apos, 's')"/></xsl:variable>

<!--checking for personification and contractions; -->
<!-- ?? can these be combined ?? -->
<xsl:if test=".//*[$excludes]/text()[contains(., $company)]"><data type="msg" outputclass="term edu" importance="urgent">Found: "<xsl:value-of select="$company"/>". Avoid personifying inanimate objects; for example by indicating an object has possession.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(., $server)]"><data type="msg" outputclass="term edu" importance="urgent">Found: "<xsl:value-of select="$server"/>". Avoid personifying inanimate objects; for example by indicating an object has possession.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(., $farm)]"><data type="msg" outputclass="term edu" importance="urgent">Found: "<xsl:value-of select="$farm"/>". Avoid personifying inanimate objects; for example by indicating an object has possession.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(., $compName)]"><data type="msg" outputclass="term edu" importance="urgent">Found: "<xsl:value-of select="$compName"/>". Avoid personifying inanimate objects; for example by indicating an object has possession.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(., $cant)]"><data type="msg" outputclass="term edu" importance="urgent">Found: "<xsl:value-of select="$cant"/>". Avoid contractions.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(., $dont)]"><data type="msg" outputclass="term edu" importance="urgent">Found: "<xsl:value-of select="$dont"/>". Avoid contractions.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(., $wont)]"><data type="msg" outputclass="term edu" importance="urgent">Found: "<xsl:value-of select="$wont"/>". Avoid contractions.</data></xsl:if>

</xsl:template>

<xsl:template name="lang">
<!--specify elements to exclude from language checks-->
<xsl:variable name="excludes" select="not (codeblock or filepath or shortdesc or uicontrol or varname or draft-comment or alt)"/>

<!-- ===================================== -->
<!-- Language and Punctuation Standards --> <!-- lang -->
<!-- ===================================== -->

<!-- punctuation and capitalization -->
<xsl:if test=".//xref[not(starts-with(@href, 'http'))]"><data type="msg" outputclass="lang general" importance="recommended">Found web link that is missing "http://"; Please add. Does not apply to course resources or mailto links.</data></xsl:if>
<xsl:if test=".//*[$excludes]/text()[contains(., '...')][not(contains(., '... button'))]"><data type="msg" outputclass="lang general" importance="urgent">Found an ellipses (...). Avoid ellipses in our content, even if they appear in a user interface element.</data></xsl:if>
<xsl:if test=".//li/text()[matches(., '^[a-z].*')]"><data type="msg" outputclass="lang general" importance="urgent">Found a list item that begins with a lowercase letter. Start list items with a capital letter instead.</data></xsl:if>
<!-- need to tokenize by sentence first to check for sentences that start with a coordinating conjunction
<xsl:if test=".//*[$excludes]/text()"
-->


<!-- Check for weak objective verbs. -->
<xsl:if test=".//li[contains(.,'Understand')]"><data type="msg" outputclass="lang general" importance="optional">Found a bullet that begins with "Understand." If this is an objective, replace "Understand" with a stronger verb from <a href="http://www.nwlink.com/~donclark/hrd/bloom.html">Bloom's Taxonomy</a>.</data></xsl:if>


<!-- find paragraphs that may have complex sentences in them-->
<xsl:for-each select="./note/p">
<xsl:if test=".[count(tokenize(., ',')) &gt; 3]"><data type="msg" outputclass="lang general" importance="recommended">Found a sentence with more than 2 commas, which may indicate a long sentence. Keep in mind that long sentences are harder to understand, translate, and record than short ones.</data></xsl:if>
</xsl:for-each>

</xsl:template>

<xsl:template name="tag">
<!-- ===================================== -->
<!-- Output Requirements --> 
<!-- ===================================== -->

<!-- general -->
<xsl:if test="string-length(ancestor::*[1]/@xtrf) > 225"><data type="msg" outputclass="tag general" importance="urgent">File path exceeds character limit. Shorten the file and folder names.</data></xsl:if>
<xsl:if test="//topic[not(@id)]"><data type="msg" outputclass="tag general" importance="low">topic element is missing ID</data></xsl:if>
<xsl:if test="//concept[not(@id)]"><data type="msg" outputclass="tag general" importance="low">concept element is missing ID</data></xsl:if>
<xsl:if test="//task[not(@id)]"><data type="msg" outputclass="tag general" importance="low">task element is missing ID</data></xsl:if>
<xsl:if test="//reference[not(@id)]"><data type="msg" outputclass="tag general" importance="low">reference element is missing ID</data></xsl:if>
<xsl:if test=".//shortdesc[not(@otherprops='DraftStatusOn')]"><data type="msg" outputclass="tag general" importance="urgent">ShortDesc does not have DraftStatusOn</data></xsl:if>
<xsl:if test=".//draft-comment[not(@otherprops='DraftStatusOn')]"><data type="msg" outputclass="tag general" importance="urgent">Draft-Comment does not have DraftStatusOn</data></xsl:if>
<xsl:if test=".//bookmap[not(@linking='none')]"><data type="msg" outputclass="tag general" importance="urgent">BOOKMAP does not have attribute linking as none</data></xsl:if>
<xsl:if test="ancestor::*[contains(@class, '- topic/topic')][1][not(@xml:lang)]"><data type="msg" outputclass="tag general" importance="low">Verify topic has xml:lang attribute set on root element.</data></xsl:if>
<xsl:if test=".//strow[not(node())]"><data type="msg" outputclass="tag general" importance="recommended">Delete empty simple table rows</data></xsl:if>
<xsl:if test=".//row[not(node())]"><data type="msg" outputclass="tag general" importance="recommended">Delete empty table rows</data></xsl:if>
<xsl:if test=".//dl/dlentry[not(dd)]"><data type="msg" outputclass="tag general" importance="recommended">Definition list entry (DLENTRY) is missing definition (DD)</data></xsl:if>
<xsl:if test=".//p[(not(text()) and not(node()))]"><data type="msg" outputclass="tag general" importance="recommended">P element is empty</data></xsl:if>
<xsl:if test=".//xref[not(@scope='external')]"><data type="msg" outputclass="tag general" importance="urgent">XREF does not have attribute scope as external</data></xsl:if>


<!-- other attribute checks -->
<xsl:if test=".//@href[contains(., ' ')]"><data type="msg" outputclass="tag attr" importance="urgent">HREF target contains a space</data></xsl:if>

</xsl:template>



<xsl:template name="filtering">
<!-- ===================================== -->
<!-- Filtering --> <!-- filtering -->
<!-- ===================================== -->

<!-- List conditions found in the topic -->
<xsl:if test=".//*[exists(@otherprops)]"><data type="msg" outputclass="filtering" importance="low">@otherprops values: <xsl:value-of select="distinct-values(.//*/@otherprops)" separator=", "/></data></xsl:if>
<xsl:if test=".//*[exists(@audience)]"><data type="msg" outputclass="filtering" importance="low">@audience values: <xsl:value-of select="distinct-values(.//*/@audience)" separator=", "/></data></xsl:if>
<xsl:if test=".//*[exists(@platform)]"><data type="msg" outputclass="filtering" importance="low">@platform values: <xsl:value-of select="distinct-values(.//*/@platform)" separator=", "/></data></xsl:if>
<xsl:if test=".//*[exists(@product)]"><data type="msg" outputclass="filtering" importance="low">@product values: <xsl:value-of select="distinct-values(.//*/@product)" separator=", "/></data></xsl:if>

</xsl:template>


<!-- check for occurences of passive voice in topics-->
<xsl:template name="passiveVoice">
<xsl:variable name="tokenString" select="tokenize(lower-case(ancestor::*[contains(@class, ' topic/topic ')][1]),'(\s|[,.?!:;])+')"/>
				 <xsl:variable name="passiveIndicators" select="(
				 'added', 
				 'become',
				 'begun',
				 'broken',
				 'brought',
				 'built',
				 'configured',
				 'chosen',
				 'cut',
				 'discovered',
				 'done',
				 'downloaded',
				 'drawn',
				 'found',
				 'fit',
				 'forbidden',
				 'forgotten',
				 'frozen',
				 'gotten',
				 'given',
				 'hung',
				 'installed',
				 'kept',
				 'known',
				 'led',
				 'left',
				 'let',
				 'lost',
				 'made',
				 'managed',
				 'meant',
				 'met',
				 'mistaken',
				 'put',
				 'quit',
				 'read',
				 'redirected',
				 'set',
				 'shut',
				 'split',
				 'spread',
				 'stolen',
				 'stuck',
				 'taken',
				 'taught',
				 'told',
				 'understood',
				 'uninstalled',
				 'woken',
				 'withheld')"/>
				 <xsl:variable name="beVerbs" select="(
				 'am',
				 'are',
				 'were',
				 'being',
				 'is',
				 'been',
				 'was',
				 'be')"/>
				 <xsl:variable name="hasBeVerb">
					 <xsl:choose>
							<xsl:when test="$tokenString = $beVerbs">true</xsl:when>
							<xsl:otherwise>false</xsl:otherwise>
						</xsl:choose>
				 </xsl:variable>
				 <xsl:variable name="hasIndicator">
					 <xsl:choose>
							<xsl:when test="$tokenString = $passiveIndicators">true</xsl:when>
							<xsl:otherwise>false</xsl:otherwise>
						</xsl:choose>
				 </xsl:variable>
				 <xsl:variable name="hasPassive">
					 <xsl:choose>
							<xsl:when test="$hasBeVerb = $hasIndicator"><xsl:value-of select="$hasBeVerb"/></xsl:when>
							<xsl:otherwise>false</xsl:otherwise>
						</xsl:choose>
				 </xsl:variable>
				 <data name="hasPassive"><xsl:value-of select="$hasPassive"/></data>
				 <xsl:if test="$hasPassive[contains(.,'true')]"><data type="msg" outputclass="lang passive" importance="recommended">This topic contains at least one instance of passive voice.</data></xsl:if>
</xsl:template>

<!-- External Links -->
<xsl:template name="xrefs">
	<xsl:for-each select="descendant-or-self::*[contains(@href, 'http://')]">
		<data type="msg" importance="low">
		<xsl:attribute name="outputclass">link</xsl:attribute>
		<xsl:value-of select="@href"/></data>
	</xsl:for-each>
</xsl:template>


</xsl:stylesheet>