<?xml version="1.0" encoding="utf-8"?>
<!--
    #############################################################
    # Name:         bible-conc-simplify-usx.xslt
    # Purpose:		include strip markup with attributes name and values, remove content
    # Part of:      Vimod Pub - http://projects.palaso.org/projects/vimod-pub
    # Author:       Ian McQuay <ian_mcquay@sil.org>
    # Created:      2015- -
    # Copyright:    (c) 2015 SIL International
    # Licence:      <LGPL>
    ################################################################ -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <xsl:import href='inc-copy-anything.xslt'/>
      <xsl:include href="project.xslt"/>
      <!-- inc-copy-anything.xslt - Match any node or element -->
      <xsl:strip-space elements="*"/>
      <xsl:output method="xml" version="1.0" encoding="utf-8" omit-xml-declaration="no" indent="yes"/>
      <xsl:template match="*[@style = $del-ec-attrib-value]"/>
      <xsl:template match="para">
            <xsl:apply-templates/>
            <xsl:text> </xsl:text>
      </xsl:template>
      <xsl:template match="*[local-name() = $remove-element]">
            <xsl:apply-templates/>
            <xsl:text> </xsl:text>
      </xsl:template>
      <xsl:template match="*[local-name() = $remove-element-content]"/>
</xsl:stylesheet>
