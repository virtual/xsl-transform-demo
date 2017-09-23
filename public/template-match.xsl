<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY nbsp   "&#160;">
<!ENTITY lsaquo   "&#8249;">
<!ENTITY rsaquo   "&#8250;">
<!ENTITY laquo  "&#171;">
<!ENTITY raquo  "&#187;">
<!ENTITY copy   "&#169;">
]>

<!-- 
Implementations Skeletor v3 - 5/10/2014

IDENTITY TEMPLATE MATCH
This template ensures that all content is copied, or applied to any existing template matches. Edit sparingly.

-->
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

	<!-- image box -->
	<xsl:template match="table">
		<div class="image-box image-box-right">  
			<!-- <xsl:apply-templates select="td[@class = '_photo']" /> -->
			<!-- <xsl:apply-templates select="td" /> -->
      <xsl:apply-templates select="tbody/tr" />
			<!-- <xsl:if test="normalize-space(td[@class = '_title']) != '' and normalize-space(td[@class = '_title']) != ' ' and normalize-space(td[@class = '_title']) != '&nbsp;'">
				<p class="caption"><xsl:apply-templates select="normalize-space(td[@class = '_title'])"><xsl:copy-of select="*"/></xsl:apply-templates></p>
			</xsl:if> -->
		</div>
	</xsl:template>

 <xsl:template match="td">
    <xsl:text>TD!!</xsl:text>
		<xsl:copy-of select="*"/>
	</xsl:template>  

  	<xsl:template match="tbody/tr">
    <xsl:text>===tr===</xsl:text>
			<xsl:apply-templates select="td" />
			<!-- <xsl:if test="normalize-space(td[@class = '_title']) != '' and normalize-space(td[@class = '_title']) != ' ' and normalize-space(td[@class = '_title']) != '&nbsp;'">
				<p class="caption"><xsl:apply-templates select="normalize-space(td[@class = '_title'])" /></p>
			</xsl:if> -->
	</xsl:template>	

</xsl:stylesheet>