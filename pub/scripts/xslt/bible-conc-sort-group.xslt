<?xml version="1.0" encoding="utf-8"?>
<!--
    #############################################################
    # Name:         	bible-conc-sort-group.xslt
    # Purpose:      	sort and group bible word list
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
            <groupedWords>
                  <xsl:for-each-group select="w" group-by="lower-case(@word)">
                        <!-- group on lower case so capitalized words are in same group as nocap words -->
                        <xsl:sort select="@word" case-order="upper-first"/>
                        <xsl:variable name="group-count" select="count(current-group())"/>
                        <xsl:if test="$group-count le $max-word-occurance-count and string-length(current-group()[1]/@word) ge $min-word-length">
                              <xsl:element name="w">
                                    <xsl:attribute name="word">
                                          <xsl:choose>
                                                <xsl:when test="current-group()/@word = lower-case(current-group()[1]/@word)">
                                                      <!-- check if non capitalized word is present in current-group, if so output as lower case group -->
                                                      <xsl:value-of select="lower-case(current-group()[last()]/@word)"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                      <!-- output capitialised word -->
                                          <xsl:value-of select="current-group()[1]/@word"/>
                                                </xsl:otherwise>
                                          </xsl:choose>
                                    </xsl:attribute>
                                    <xsl:attribute name="count">
                                          <xsl:value-of select="$group-count"/>
                                    </xsl:attribute>
                                    <xsl:for-each-group select="current-group()" group-by="@bk">
                                          <xsl:element name="bk">
                                                <xsl:attribute name="book">
                                                      <xsl:value-of select="current-group()[1]/@bk"/>
                                                </xsl:attribute>
                                                <xsl:for-each-group select="current-group()" group-by="@c">
                                                      <xsl:element name="chapter">
                                                            <xsl:attribute name="number">
                                                                  <xsl:value-of select="current-group()[1]/@c"/>
                                                            </xsl:attribute>
                                                            <xsl:for-each select="current-group()">
                                                                  <xsl:element name="verse">
                                                            <xsl:attribute name="number">
                                                                  <xsl:value-of select="@v"/>
                                                            </xsl:attribute>
                                                                  </xsl:element>
                                                            </xsl:for-each>
                                                      </xsl:element>
                                                </xsl:for-each-group>
                                          </xsl:element>
                                    </xsl:for-each-group>
                              </xsl:element>
                        </xsl:if>
                  </xsl:for-each-group>
            </groupedWords>
      </xsl:template>
</xsl:stylesheet>
