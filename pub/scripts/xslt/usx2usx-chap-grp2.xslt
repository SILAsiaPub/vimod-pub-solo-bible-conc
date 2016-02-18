<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:f="myfunctions" exclude-result-prefixes="f">
      <xsl:include href='inc-copy-anything.xslt'/>
      <xsl:include href="inc-file2uri.xslt"/>
      <xsl:include href="inc-list2xml-xattrib.xslt"/>
      <xsl:include href="project.xslt"/>
      <!-- <xsl:param name="usxpath"/> -->
      <!-- <xsl:param name="files"/> -->
      <!-- <xsl:param name="groupnodelist"/> -->
      <!-- <xsl:param name="bookorderfile"/> -->
      <xsl:variable name="bookorderuri" select="f:file2uri($bookorderfile)"/>
      <xsl:variable name="bookorderlist" select="unparsed-text($bookorderuri)"/>
      <xsl:variable name="usxpathuri" select="f:file2uri($usxpath)"/>
      <xsl:variable name="collection" select="collection(concat($usxpathuri,'?select=',$collectionfile))"/>
      <xsl:variable name="groupnodes" select="tokenize($groupnodelist,'\s+')"/>
      <xsl:variable name="usxseq">
            <xsl:call-template name="list2xmlxattrib">
                  <xsl:with-param name="text" select="$bookorderlist"/>
                  <xsl:with-param name="attribnamelist" select="'seq book chapters'"/>
            </xsl:call-template>
      </xsl:variable>
      <xsl:output method="xml" encoding="utf-8" indent="yes"/>
      <xsl:template match="/">
            <data>
                  <xsl:for-each select="$collection/usx">
                        <xsl:sort select="number(f:sequence(book/@code))"/>
                        <xsl:variable name="pos" select="position()"/>
                        <xsl:variable name="book" select="book/@code"/>
                        <xsl:copy>
                              <xsl:attribute name="book">
                                    <xsl:value-of select="$book"/>
                              </xsl:attribute>
                              <xsl:attribute name="seq">
                                    <xsl:value-of select="f:sequence($book)"/>
                              </xsl:attribute>
                              <xsl:attribute name="pos">
                                    <xsl:value-of select="$pos"/>
                              </xsl:attribute>
                              <xsl:attribute name="bookname">
                                    <xsl:value-of select="$pos"/>
                              </xsl:attribute>
                              <xsl:apply-templates select="@*"/>
                              <xsl:for-each-group select="*" group-starting-with="*[local-name() = $groupnodes]">
                                    <xsl:choose>
                                          <xsl:when test="self::*[local-name() = $groupnodes]">
                                                <xsl:element name="{local-name()}Group">
                                                      <xsl:attribute name="book">
                                                            <xsl:value-of select="$book"/>
                                                      </xsl:attribute>
                                                      <xsl:attribute name="number">
                                                            <xsl:choose>
                                                                  <xsl:when test="not(@number)">
                                                                        <xsl:text>0</xsl:text>
                                                                  </xsl:when>
                                                                  <xsl:otherwise>
                                                                        <xsl:value-of select="@number"/>
                                                                  </xsl:otherwise>
                                                            </xsl:choose>
                                                      </xsl:attribute>
                                                      <xsl:apply-templates select="current-group()"/>
                                                </xsl:element>
                                          </xsl:when>
                                          <xsl:otherwise>
                                                <xsl:apply-templates select="current-group()"/>
                                          </xsl:otherwise>
                                    </xsl:choose>
                              </xsl:for-each-group>
                        </xsl:copy >
                  </xsl:for-each>
            </data>
      </xsl:template>
      <xsl:function name="f:sequence">
            <xsl:param name="string"/>
            <xsl:choose>
                  <xsl:when test="$string = $usxseq/element/@book">
                        <xsl:variable name="seq" select="$usxseq/element[@book = $string]/@seq"/>
                        <xsl:value-of select="$seq"/>
                  </xsl:when>
                  <xsl:otherwise>
                        <xsl:text>1000</xsl:text>
                  </xsl:otherwise>
            </xsl:choose>
      </xsl:function>
</xsl:stylesheet>
