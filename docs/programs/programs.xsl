<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY nbsp   "&#160;">
<!ENTITY lsaquo   "&#8249;">
<!ENTITY rsaquo   "&#8250;">
<!ENTITY laquo  "&#171;">
<!ENTITY raquo  "&#187;">
<!ENTITY copy   "&#169;">
]>
<xsl:stylesheet version="3.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:xs="http://www.w3.org/2001/XMLSchema"
				xmlns:ou="http://omniupdate.com/XSL/Variables"
				xmlns:fn="http://omniupdate.com/XSL/Functions"
				xmlns:ouc="http://omniupdate.com/XSL/Variables"
				exclude-result-prefixes="xs ou fn ouc">

	<!--	xsl:strip-space ensures that the content coming from the XML is clean. It will remove unnecessary whitespace between elements. -->	
	<xsl:strip-space elements="*" />

	<!--	The xsl:output tells the XSL what kind of document the XML is being transformed into. 
  There are four commonly used methods: html, xhtml, xml, and text. For most HTML implementations (especially with HTML 5 being commonly used), the best practice is to use the "html" output method.
  Version determines the version of HTML to use. The XSL will automatically put the DOCTYPE for the HTML version 5.0.
  Indent helps make the output look pretty.
  Disabling the include-content-type filter will remove an encoding meta tag placed in the head of the HTML by XSL. The best practice is to define that meta node manually. -->
	<xsl:output method="html" version="5.0" indent="yes" encoding="UTF-8" include-content-type="no" /> 
	
  <xsl:template match="/document">
		<xsl:apply-templates select="bodycode/node()" />
	</xsl:template>

	<xsl:function name="ou:get-profile">
		<xsl:param name="document" />
		<!-- creates profile node with href to program page link -->
		<profile href="{concat($dirname, replace($ou:filename, '.xml', '.aspx'))}">
			<xsl:for-each select="$document/profile/ouc:div">
				<xsl:element name="{translate(./@label, ' ', '_')}"><xsl:apply-templates select="node()[not(self::ouc:multiedit)]" /></xsl:element>
			</xsl:for-each>
		</profile>
	</xsl:function>

	<!-- gets all profile option XML files in selected folder -->
	<xsl:function name="ou:get-profiles">
		<xsl:param name="dir" />
		<xsl:param name="skip" /><!-- skips creating xml file of index that called it-->

		<!--<xsl:variable name="files">
			<xsl:for-each select="collection(concat($ou:root, $ou:site, if ($ou:dirname = '/') then '' else $ou:dirname, '?select=*.pcf;recurse=yes;on-error=warning'))">
				<xsl:value-of select="./doc/@href" />
			</xsl:for-each>
		</xsl:variable>-->

		<xsl:variable name="profiles">
			<xsl:for-each select="doc(concat($ou:root, $ou:site, if ($ou:dirname = '/') then '' else $ou:dirname))/list/file[contains(., '.pcf')]">
				<xsl:variable name="file-path" select="concat($domain, $dirname, replace(., '.pcf', '.xml'))" />
				<xsl:if test="not(contains($file-path, $skip)) and doc-available($file-path)">
					<xsl:copy-of select="doc($file-path)/profile" />
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>

		<!-- outputs master list XML -->
		<profiles>
			<xsl:for-each select="$profiles/profile">
				<xsl:sort select="./program-option/text()" /><!-- sort first by program option name -->
				<xsl:copy-of select="." />
			</xsl:for-each>
		</profiles>
	</xsl:function>


  <xsl:template match="profile" mode="single">
		<div>
			<xsl:if test="not(fields-indust='')">
				<p>Field &amp; Industry: <xsl:value-of select="fields-indust"/></p>
			</xsl:if>
			<xsl:if test="not(program-type='')">
				<p>Program Type: <xsl:value-of select="program-type"/></p>
			</xsl:if>
			<xsl:if test="not(online='')">
				<p>Online: <xsl:value-of select="online"/></p>
			</xsl:if>
			<xsl:if test="not(dept='')">
					<p>Department Name: <xsl:value-of select="dept" /></p>
				</xsl:if>
				<xsl:if test="not(program-option='')">
					<p>Program Option Name: <xsl:value-of select="program-option"/></p>
				</xsl:if>
			<!--<h2>
				<xsl:if test="not(./image/img/@src='')">
					<img src="{./image/img/@src}" alt="{./image/img/@alt}" align="left" border="1" height="229" hspace="20" vspace="0" width="179" />
				</xsl:if>
				<xsl:if test="not(firstname='')">
					<xsl:value-of select="firstname" />&nbsp;
				</xsl:if>
				<xsl:if test="not(lastname='')">
					<xsl:value-of select="lastname"/>
				</xsl:if>
			</h2>
			<p><strong>
				<xsl:if test="not(title='')">
					<xsl:value-of select="title"/>, 
				</xsl:if>
				<xsl:if test="not(department='')">
					<xsl:value-of select="department"/>
				</xsl:if>
			</strong></p>
			<xsl:if test="not(location='')">
				<p>Location: <xsl:value-of select="location"/></p>
			</xsl:if>
			<xsl:if test="not(phone='')">
				<p>Phone: <a href="tel:{phone/text()}"><xsl:value-of select="phone"/></a></p>
			</xsl:if>
			<xsl:if test="not(fax='')">
				<p>Fax: <xsl:value-of select="fax"/></p>
			</xsl:if>
			<xsl:if test="not(email='')">
				<p>E-mail: <a href="mailto:{email/text()}"><xsl:value-of select="email"/></a></p>
			</xsl:if>
			<xsl:if test="not(office-hours='')">
				<h3><strong>Office Hours</strong>:</h3>
				<p><xsl:value-of select="office-hours" /></p>	
			</xsl:if>-->
		</div>
	</xsl:template>
	<!-- ************ END Output for the individual profile page *************** -->

	<!-- ************ Output for the aggregrate listing page *************** -->
	<xsl:template match="profile" mode="listing">
		<tr>
			<!--<td><a href="{@href}"><xsl:value-of select="lastname"/>,&nbsp;<xsl:value-of select="firstname"/></a></td>
			<td><xsl:value-of select="department"/></td>
			<td><xsl:value-of select="building"/></td>
			<td><xsl:value-of select="room"/></td>
			<td><a href="tel:{phone/text()}"><xsl:value-of select="phone"/></a></td>
			<td><xsl:value-of select="location"/></td>-->
			<td><xsl:value-of select="fields-indust"/></td>
			<td><xsl:value-of select="program-type"/></td>
			<td><xsl:value-of select="online"/></td>
			<td><xsl:value-of select="dept"/></td>
			<td><a href="{@href}"><xsl:value-of select="program-option"/></a></td>
		</tr>
	</xsl:template>	
	<!-- ************ END Output for the aggregrate listing page *************** -->
 
 <xsl:template match="/document">
		<xsl:choose>
			<xsl:when test="profile">  <!-- Check to see if Profile Page (profile node exists) -->
				<xsl:call-template name="profile" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="listing" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="profile">
		<xsl:copy-of select="ou:get-profile(.)" />
	</xsl:template>
	
	<xsl:template name="listing">
		<!-- grabs all profiles in dirname only -->
	
		<!--<xsl:for-each select="collection(concat($ou:root, $ou:site, if ($dirname = '/') then '' else $dirname), '?select=*.xml;recurse=yes'))">-->
        <!--process nodes-->
			<xsl:copy-of select="ou:get-profiles($dirname, $ou:filename)" />
    	<!--</xsl:for-each>-->		
				
	</xsl:template>
	
	<!-- The following template matches all items except processing instructions, copies them, then processes any children. -->
	<xsl:template match="attribute()|text()|comment()">
		<xsl:copy />
	</xsl:template>
	
	<xsl:template match="element()">
		<xsl:element name="{name()}">
			<xsl:apply-templates select="attribute()|node()" mode="#current" />
		</xsl:element>
	</xsl:template>	
  
</xsl:stylesheet>