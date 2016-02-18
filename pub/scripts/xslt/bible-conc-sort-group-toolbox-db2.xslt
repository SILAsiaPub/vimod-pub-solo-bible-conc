<?xml version="1.0" encoding="utf-8"?>
<!--
    #############################################################
    # Name:         	bible-conc-sort-group.xslt
    # Purpose:		sort and group bible word list
    # Part of:      	Vimod Pub - http://projects.palaso.org/projects/vimod-pub
    # Author:       	Ian McQuay <ian_mcquay@sil.org>
    # Created:      	2015-09-24
    # Copyright:    	(c) 2015 SIL International
    # Licence:      	<LGPL>
    ################################################################ -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <xsl:output method="xml" version="1.0" encoding="utf-8" omit-xml-declaration="no" indent="yes"/>
      <xsl:param name="max-word-occurance-count" select="1600"/>
      <xsl:param name="min-word-length" select="3"/>
      <xsl:template match="/*">
            <database toolboxdatabasetype="Concordance" wrap="400" toolboxversion="1.6.2 Jul 2015" toolboxwrite="save">
                  <xsl:for-each-group select="w" group-by="@word">
                        <xsl:sort select="@word" case-order="upper-first"/>
                        <xsl:variable name="group-count" select="count(current-group())"/>
                        <xsl:if test="$group-count le $max-word-occurance-count and string-length(current-group()[1]/@word) ge $min-word-length">
                              <xsl:element name="wGroup">
                                    <w>
                                          <xsl:value-of select="current-group()[1]/@word"/>
                                    </w>
                                    
                                          <xsl:element name="rGroup">
                                                <xsl:for-each select="current-group()">
                                                      <xsl:element name="r">
                                                            <xsl:value-of select="concat(@bk,'_',@c,' ',@v)"/>
                                                      </xsl:element>
                                                </xsl:for-each>
                                          </xsl:element>
                                    
                              </xsl:element>
                        </xsl:if>
                  </xsl:for-each-group>
            </database>
      </xsl:template>
</xsl:stylesheet>
