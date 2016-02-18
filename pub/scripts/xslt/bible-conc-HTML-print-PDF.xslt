<?xml version="1.0" encoding="utf-8"?>
<!--
    #############################################################
    # Name:         bible-conc-HTML-print-PDF.xslt
    # Purpose:		Make HTML for Print of Concorded words
    # Part of:      Vimod Pub - http://projects.palaso.org/projects/vimod-pub
    # Author:       Ian McQuay <ian_mcquay@sil.org>
    # Created:      2015- -
    # Copyright:    (c) 2015 SIL International
    # Licence:      <LGPL>
    ################################################################ -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <xsl:output method="html" version="5.0" encoding="utf-8" omit-xml-declaration="no" indent="yes"/>
      <xsl:include href="project.xslt"/>
      <xsl:template match="/*">
            <html lang='eng'>
                  <head>
                        <title>
                              <xsl:value-of select="$title"/>
                        </title>
                        <meta charset='utf-8'/>
                        <meta name='description' content=''/>
                        <meta name='keywords' content='concordance; Ayangan Ifugao; Bible; find words'/>
                        <meta name='builder' content='Vimod-Pub USX Concordance Builder'/>
                        <link rel="stylesheet" href="{$conccss}" type="text/css"/>
                        <style type="text/css"></style>
                  </head>
                  <body>
                        <div class="content">
                              <xsl:apply-templates/>
                        </div>
                  </body>
            </html>
      </xsl:template>
      <xsl:template match="w">
            <xsl:element name="p">
                  <span class="word">
                        <xsl:value-of select="@word"/>
                  </span>
                  <xsl:text>&#x2002;</xsl:text>
                  <xsl:apply-templates select="bk"/>
            </xsl:element>
      </xsl:template>
      <xsl:template match="bk">
            <span class="book">
                  <xsl:choose>
                        <xsl:when test="matches(@book,'^\d')">
                              <xsl:value-of select="substring(@book,1,2)"/>
                              <xsl:value-of select="lower-case(substring(@book,3,1))"/>
                        </xsl:when>
                        <xsl:otherwise>
                              <xsl:value-of select="substring(@book,1,1)"/>
                              <xsl:value-of select="lower-case(substring(@book,2,2))"/>
                        </xsl:otherwise>
                  </xsl:choose>
            </span>
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="chapter"/>
            <xsl:text> </xsl:text>
      </xsl:template>
      <xsl:template match="chapter">
            <span class="chap">
                  <xsl:value-of select="@number"/>
            </span>
            <xsl:text>:</xsl:text>
            <xsl:apply-templates select="verse"/>
            <xsl:if test="position() ne last()">
                  <xsl:text>; </xsl:text>
            </xsl:if>
      </xsl:template>
      <xsl:template match="verse">
            <xsl:choose>
                  <xsl:when test="preceding-sibling::verse[1]/@number = @number"/>
                  <xsl:otherwise>
                        <xsl:if test="position() ne 1">
                              <xsl:text>, </xsl:text>
                        </xsl:if>
                        <xsl:value-of select="@number"/>
                  </xsl:otherwise>
            </xsl:choose>
      </xsl:template>
</xsl:stylesheet>
