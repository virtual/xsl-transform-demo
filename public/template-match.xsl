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

	<!-- image box -->
	<xsl:template match="ouc:div//table[@class = 'ou-image-box ou-image-box-right']" mode="copy">
		<div class="image-box image-box-right">
			<xsl:apply-templates select="tbody/tr" />
		</div>
	</xsl:template>

	<xsl:template match="ouc:div//table[@class = 'ou-image-box ou-image-box-right']/tbody/tr" mode="copy">
			<xsl:apply-templates select="td[@class = '_photo']" />
			<xsl:if test="normalize-space(td[@class = '_title']) != '' and normalize-space(td[@class = '_title']) != ' ' and normalize-space(td[@class = '_title']) != '&nbsp;'">
				<p class="caption"><xsl:apply-templates select="normalize-space(td[@class = '_title'])" /></p>
			</xsl:if>
	</xsl:template>		
</xsl:stylesheet>