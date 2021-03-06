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

	<!-- image box -->
	<xsl:template match="table">
		<div class="image-box image-box-right">  
			<xsl:apply-templates select="tbody/tr" />
		</div>
	</xsl:template>

	<xsl:template match="tbody/tr"> 
		<div class="ui middle aligned stackable grid container">
			<div class="row">
				<div class="eight wide column">
					<h3 class="ui dividing header"><xsl:apply-templates select="td[@class = '_title']" /></h3>
					<p><xsl:apply-templates select="td[@class = '_desc']" /></p> 
				</div>
				<div class="six wide right floated column">
					<div class="ui left floated tiny image">
						<a class="ui left yellow corner label" title="Save to Favorites">
							<i class="star icon"></i>
						</a> 
					</div>
					<xsl:apply-templates select="td[@class = '_photo']" />
				</div>
			</div> 
			<div class="row">
				<div class="center aligned column">
					<a class="ui red button">Learn more</a>
				</div>
			</div>
		</div>  
	</xsl:template>	

	<xsl:template match="td[@class = '_photo']">
		<xsl:copy-of select="*"/>
	</xsl:template>   
</xsl:stylesheet>