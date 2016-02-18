<?xml version="1.0" encoding="utf-8"?>
<!--
    #############################################################
    # Name:         	vimod-projecttasks2variable.xslt
    # Purpose:      	Generate a XSLT that takes the project.tasks file and make var in there into param. Also includes xvarset files and xarray files as param and adds xslt files as includes in project.xslt 
    # Part of:      	Vimod Pub - http://projects.palaso.org/projects/vimod-pub
    # Author:       	Ian McQuay <ian_mcquay.org>
    # Created:      	2014- -
    # Copyright:    	(c) 2013 SIL International
    # Licence:      	<LGPL>
    ################################################################
-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:f="myfunctions">
      <xsl:output method="xml" version="1.0" encoding="utf-8" omit-xml-declaration="no" indent="yes"/>
      <xsl:include href="inc-file2uri.xslt"/>
      <xsl:param name="projectpath"/>
      <!--<xsl:variable name="projecttaskuri" select="concat(f:file2uri($projectpath),'/setup/project.tasks')"/> -->
      <xsl:variable name="projecttask" select="f:file2lines(concat($projectpath,'/project.tasks'))"/>
      <!-- <xsl:variable name="projecttask" select="tokenize(unparsed-text($projecttaskuri),'\r?\n')"/> -->
      <xsl:variable name="cd" select="substring-before($projectpath,'')"/>
      <xsl:variable name="varparser" select="'^([^;]+);([^ ]+)[ \t]+([^ \t]+)[ \t]+(.+)'"/>
      <xsl:variable name="sq">
            <xsl:text>'</xsl:text>
      </xsl:variable>
      <xsl:template match="/">
            <xsl:element name="xsl:stylesheet">
                        <xsl:attribute name="version">
                              <xsl:text>2.0</xsl:text>
                        </xsl:attribute>
                  <xsl:element name="xsl:variable">
                        <!-- Declare projectpath -->
                        <xsl:attribute name="name">
                              <xsl:text>projectpath</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="select">
                              <xsl:text>'</xsl:text>
                              <xsl:value-of select="$projectpath"/>
                              <xsl:text>'</xsl:text>
                        </xsl:attribute>
                  </xsl:element>
                  <xsl:element name="xsl:variable">
                        <!-- Declare cd -->
                        <xsl:attribute name="name">
                              <xsl:text>cd</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="select">
                              <xsl:text>'</xsl:text>
                              <xsl:value-of select="$projectpath"/>
                              <xsl:text>'</xsl:text>
                        </xsl:attribute>
                  </xsl:element>
                  <xsl:element name="xsl:variable">
                        <!-- Declare cd -->
                        <xsl:attribute name="name">
                              <xsl:text>pubpath</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="select">
                              <xsl:text>'</xsl:text>
                              <xsl:value-of select="concat($projectpath,'\pub')"/>
                              <xsl:text>'</xsl:text>
                        </xsl:attribute>
                  </xsl:element>
                  <xsl:element name="xsl:variable">
                        <!-- Declare projectpath -->
                        <xsl:attribute name="name">
                              <xsl:text>true</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="select">
                              <xsl:text>tokenize('true yes on 1','\s+')</xsl:text>
                        </xsl:attribute>
                  </xsl:element>
                  <xsl:for-each select="$projecttask">
                        <!-- copy the root folder files pub.cmd and local_var.cmd -->
                        <xsl:call-template name="parseline">
                              <xsl:with-param name="line" select="."/>
                        </xsl:call-template>
                  </xsl:for-each>
            </xsl:element>
      </xsl:template>
      <xsl:template name="parseline">
            <xsl:param name="line"/>
            <xsl:variable name="comment" select="replace($line,$varparser,'$1')"/>
            <xsl:variable name="command" select="replace($line,$varparser,'$2')"/>
            <xsl:variable name="name" select="replace($line,$varparser,'$3')"/>
            <xsl:variable name="value" select="replace($line,$varparser,'$4')"/>
            <xsl:variable name="commandstring" select="substring-after($line,';')"/>
            <!-- 
            <xsl:variable name="comment" select="substring-before($line,';')"/>

            <xsl:variable name="postcommand" select="substring-after($commandstring,'\s+')"/>
            <xsl:variable name="param1" select="substring-before($postcommand,'\s+')"/>
            <xsl:variable name="postparam1" select="substring-after($postcommand,'\s+')"/>
            <xsl:variable name="part" select="tokenize($commandstring,'\s+')"/>
            <xsl:variable name="command" select="lower-case($part[1])"/>
            <xsl:variable name="name" select="$part[2]"/>
            <xsl:variable name="value" select="substring-after($commandstring,concat($name,'\s+'))"/>
            <xsl:variable name="value" select="normalize-space($postparam1)"/>
            <xsl:variable name="value" select="substring($commandstring,6 + string-length($part[2]))"/> -->
            <xsl:variable name="commonuri" select="f:file2uri(concat($cd,'\tasks\',$name))"/>
            <xsl:variable name="onevar">
                  <xsl:if test="matches($value,'^%[\w\d\-_]+%$') or matches($value,'^&#34;%[\w\d\-_]+%&#34;$')">
                        <xsl:text>onevar</xsl:text>
                  </xsl:if>
            </xsl:variable>
            <xsl:choose>
                  <xsl:when test="matches($line,'^#.*$')">
                        <!-- the above removes comment lines so lines that contain commented out things are not processed -->
                        <xsl:element name="xsl:variable">
                              <xsl:attribute name="name">
                                    <xsl:value-of select="concat('comment',position())"/>
                              </xsl:attribute>
                              <xsl:attribute name="select">
                                    <xsl:value-of select="concat($sq,replace($line,$sq,' '),$sq)"/>
                              </xsl:attribute>
                        </xsl:element>
                  </xsl:when>
                  <xsl:otherwise>
                        <xsl:choose>
                              <xsl:when test="matches($command,'xinclude')">
                                    <xsl:element name="xsl:variable">
                                          <xsl:attribute name="name">
                                                <xsl:value-of select="concat('comment',position())"/>
                                          </xsl:attribute>
                                          <xsl:value-of select="$line"/>
                                    </xsl:element>
                                    <xsl:element name="xsl:include">
                                          <xsl:attribute name="href">
                                                <xsl:value-of select="$name"/>
                                          </xsl:attribute>
                                    </xsl:element>
                              </xsl:when>
                              <xsl:when test="matches($command,'xarray')">
                                    <xsl:variable name="params" select="substring-after($commandstring,'\s+')"/>
                                    <xsl:variable name="xarrayfile" select="normalize-space(replace(concat('..\..\',$value),'&#34;',''))"/>
                                    <xsl:variable name="xarrayuri" select="f:file2uri($xarrayfile)"/>
                                    <xsl:variable name="xarray" select="unparsed-text($xarrayuri)"/>
                                    <xsl:element name="xsl:variable">
                                          <xsl:attribute name="name">
                                                <xsl:value-of select="concat('comment',position())"/>
                                          </xsl:attribute>
                                          <xsl:value-of select="$comment"/>
                                    </xsl:element>
                                    <xsl:call-template name="writeparam">
                                          <xsl:with-param name="name" select="$name"/>
                                          <xsl:with-param name="value" select="$xarray"/>
                                    </xsl:call-template>
                              </xsl:when>
                              <xsl:when test="matches($command,'xvarset')">
                                    <!-- this is to add variables in an existing line separated, then = separated list like vimod.variable -->
                                    <xsl:variable name="xvarsetfile" select="concat('..\..\',replace($name,'&#34;',''))"/>
                                    <xsl:variable name="xvarseturi" select="f:file2uri($xvarsetfile)"/>
                                    <xsl:variable name="xvarset" select="tokenize(unparsed-text($xvarseturi),'\r?\n')"/>
                                    <xsl:element name="xsl:variable">
                                          <xsl:attribute name="name">
                                                <xsl:value-of select="concat('comment',position())"/>
                                          </xsl:attribute>
                                          <xsl:attribute name="select">
                                                <xsl:value-of select="concat($sq,$comment,$sq)"/>
                                          </xsl:attribute>
                                    </xsl:element>
                                    <xsl:for-each select="$xvarset">
                                          <xsl:variable name="item1" select="substring-before(.,'=')"/>
                                          <xsl:variable name="item2" select="substring-after(.,'=')"/>
                                          <xsl:choose>
                                                <xsl:when test="matches(.,'^#')"/>
                                                <!-- incase there is a comment line -->
                                                <xsl:when test="string-length(.) = 0"/>
                                                <xsl:otherwise>
                                                      <!-- when there is a line to process -->
                                                      <xsl:call-template name="writeparam">
                                                            <xsl:with-param name="name" select="$item1"/>
                                                            <xsl:with-param name="value" select="$item2"/>
                                                      </xsl:call-template>
                                                </xsl:otherwise>
                                          </xsl:choose>
                                    </xsl:for-each>
                              </xsl:when>
                              <xsl:when test="matches($command,'inc|tasklist')">
                                    <xsl:element name="xsl:variable">
                                          <xsl:attribute name="name">
                                                <xsl:value-of select="concat('comment',position())"/>
                                          </xsl:attribute>
                                          <xsl:attribute name="select">
                                                <xsl:value-of select="concat($sq,$comment,$sq)"/>
                                          </xsl:attribute>
                                    </xsl:element>
                                    <xsl:choose>
                                          <xsl:when test="unparsed-text-available($commonuri)">
                                                <xsl:variable name="projecttask" select="tokenize(unparsed-text($commonuri),'\r?\n')"/>
                                                <xsl:for-each select="$projecttask">
                                                      <!-- copy the root folder files pub.cmd and local_var.cmd -->
                                                      <xsl:call-template name="parseline">
                                                            <xsl:with-param name="line" select="."/>
                                                      </xsl:call-template>
                                                </xsl:for-each>
                                          </xsl:when>
                                          <xsl:otherwise>
                                                <xsl:text disable-output-escaping="yes">&lt;!-- </xsl:text>
                                                <xsl:value-of select="$command"/>
                                                <xsl:text> </xsl:text>
                                                <xsl:value-of select="$name"/>
                                                <xsl:text disable-output-escaping="yes"> not found --&gt;</xsl:text>
                                          </xsl:otherwise>
                                    </xsl:choose>
                              </xsl:when>
                              <xsl:when test="matches($command,'projectxslt')">
                                    <xsl:element name="xsl:variable">
                                          <xsl:attribute name="name">
                                                <xsl:value-of select="concat('comment',position())"/>
                                          </xsl:attribute>
                                          <xsl:attribute name="select">
                                                <xsl:value-of select="concat($sq,$comment,$sq)"/>
                                          </xsl:attribute>
                                    </xsl:element>
                              </xsl:when>
                              <xsl:when test="matches($command,'var')">
                                    <!-- variable line -->
                                    <xsl:element name="xsl:variable">
                                          <xsl:attribute name="name">
                                                <xsl:value-of select="concat('comment',position())"/>
                                          </xsl:attribute>
                                          <xsl:value-of select="$comment"/>
                                    </xsl:element>
                                    <xsl:text>&#10;</xsl:text>
                                    <xsl:call-template name="writeparam">
                                          <xsl:with-param name="name" select="$name"/>
                                          <xsl:with-param name="value">
                                                <xsl:choose>
                                                      <!--  <xsl:when test="matches($value,'^%.*:.*=.*%')">
                                                replace string in variable
                                                <xsl:variable name="vpart" select="tokenize($value,':')"/>
                                                <xsl:variable name="fpart" select="tokenize($vpart[2],'=')"/>
                                                <xsl:variable name="varname" select="replace($vpart[1],'%','')"/>
                                                <xsl:variable name="find" select="$fpart[1]"/>
                                                <xsl:variable name="replace" select="replace($fpart[2],'%','')"/>
                                                <xsl:text>replace($</xsl:text>
                                                <xsl:value-of select="$varname"/>
                                                <xsl:text>,'</xsl:text>
                                                <xsl:value-of select="$find"/>
                                                <xsl:text>','</xsl:text>
                                                <xsl:value-of select="$replace"/>
                                                <xsl:text>')</xsl:text>
                                          </xsl:when>
                                          <xsl:when test="matches($value,'^&#34;?%[^%]+%&#34;?')">
                                                <xsl:text>$</xsl:text>
                                                <xsl:value-of select="replace($value,'%','')"/>
                                          </xsl:when> -->
                                                      <xsl:when test="matches($value,'%semicolon%')">
                                                            <xsl:text>';'</xsl:text>
                                                      </xsl:when>
                                                      <!--    <xsl:when test="matches($value,'%voltitle: =%')">
                                                <xsl:text>translate($voltitle,' ', '')</xsl:text>
                                          </xsl:when> -->
                                                      <xsl:when test="matches($value,'^&#34;?%[\w\d\-_]+:.*=.*%&#34;?$')">
                                                            <!-- Matches batch variable with a find and replace structure -->
                                                            <xsl:variable name="re" select="'^&#34;?%([\w\d\-_]+):(.*)=(.*)%&#34;?$'"/>
                                                            <xsl:text>replace(</xsl:text>
                                                            <xsl:value-of select="replace($value,$re,'\$$1')"/>
                                                            <xsl:text>,'</xsl:text>
                                                            <xsl:value-of select="replace($value,$re,'$2')"/>
                                                            <xsl:text>','</xsl:text>
                                                            <xsl:value-of select="replace($value,$re,'$3')"/>
                                                            <xsl:text>')</xsl:text>
                                                      </xsl:when>
                                                      <xsl:when test="matches($value,'%[\w\d\-_]+%')">
                                                            <!-- variable -->
                                                            <xsl:text>concat(</xsl:text>
                                                            <xsl:analyze-string select="replace($value,'&#34;','')" regex="%[\w\d\-_]+%">
                                                                  <!-- match variable string -->
                                                                  <xsl:matching-substring>
                                                                        <xsl:if test="position() gt 1">
                                                                              <xsl:text>,</xsl:text>
                                                                        </xsl:if>
                                                                        <xsl:text>$</xsl:text>
                                                                        <xsl:value-of select="replace(.,'%','')"/>
                                                                  </xsl:matching-substring>
                                                                  <xsl:non-matching-substring>
                                                                        <xsl:choose>
                                                                              <xsl:when test="position() = 1">
                                                                                    <xsl:text>'</xsl:text>
                                                                              </xsl:when>
                                                                              <xsl:otherwise>
                                                                                    <xsl:text>,'</xsl:text>
                                                                              </xsl:otherwise>
                                                                        </xsl:choose>
                                                                        <xsl:value-of select="."/>
                                                                        <xsl:text>'</xsl:text>
                                                                  </xsl:non-matching-substring>
                                                            </xsl:analyze-string>
                                                            <xsl:if test="$onevar = 'onevar'">
                                                                  <!-- This is incase there is only one variable passed to another variable, rare but possible -->
                                                                  <xsl:text>,''</xsl:text>
                                                            </xsl:if>
                                                            <xsl:text>)</xsl:text>
                                                      </xsl:when>
                                                      <xsl:otherwise>
                                                            <xsl:value-of select="replace($value,'&#34;','')"/>
                                                      </xsl:otherwise>
                                                </xsl:choose>
                                          </xsl:with-param>
                                          <xsl:with-param name="iscommand">
                                                <!-- looks for patterns that will need to be handled  as commands and not text -->
                                                <xsl:choose>
                                                      <xsl:when test="matches($value,'%[\w\d\-_]+%')">
                                                            <!-- contains batch variables -->
                                                            <xsl:text>on</xsl:text>
                                                      </xsl:when>
                                                      <xsl:when test="matches($value,'%[\w\d\-_]+:.*=.*%')">
                                                            <!-- contains batch variables that are using replace function-->
                                                            <xsl:text>on</xsl:text>
                                                      </xsl:when>
                                                      <xsl:when test="matches($value,'^&#34;\(.+\)&#34;$')">
                                                            <!-- contains string enclosed in braces -->
                                                            <xsl:text>on</xsl:text>
                                                      </xsl:when>
                                                      <xsl:otherwise/>
                                                </xsl:choose>
                                          </xsl:with-param>
                                    </xsl:call-template>
                              </xsl:when>
                              <xsl:otherwise/>
                        </xsl:choose>
                  </xsl:otherwise>
            </xsl:choose>
      </xsl:template>
      <xsl:template name="writeparam">
            <xsl:param name="name"/>
            <xsl:param name="value"/>
            <xsl:param name="iscommand"/>
            <xsl:variable name="apos">
                  <xsl:text>'</xsl:text>
            </xsl:variable>
            <xsl:element name="xsl:param">
                  <xsl:attribute name="name">
                        <xsl:value-of select="$name"/>
                  </xsl:attribute>
                  <xsl:attribute name="select">
                        <xsl:if test="string-length($iscommand) = 0">
                              <xsl:text>'</xsl:text>
                        </xsl:if>
                        <xsl:value-of select="$value"/>
                        <xsl:if test="string-length($iscommand) = 0">
                              <xsl:text>'</xsl:text>
                        </xsl:if>
                  </xsl:attribute>
            </xsl:element>
            <xsl:if test="matches($name,'_list')">
                  <!-- space (\s+) delimited list -->
                  <xsl:element name="xsl:variable">
                        <xsl:attribute name="name">
                              <xsl:value-of select="replace($name,'_list','')"/>
                        </xsl:attribute>
                        <xsl:attribute name="select">
                              <xsl:value-of select="concat('tokenize($',$name,',',$apos,'\s+',$apos,')')"/>
                        </xsl:attribute>
                  </xsl:element>
            </xsl:if>
            <xsl:if test="matches($name,'_underscore-list')">
                  <!-- unerescore delimied list -->
                  <xsl:element name="xsl:variable">
                        <xsl:attribute name="name">
                              <xsl:value-of select="replace($name,'_underscore-list','')"/>
                        </xsl:attribute>
                        <xsl:attribute name="select">
                              <xsl:value-of select="concat('tokenize($',$name,',',$apos,'_',$apos,')')"/>
                        </xsl:attribute>
                  </xsl:element>
            </xsl:if>
            <xsl:if test="matches($name,'_equal-list')">
                  <!-- equals delimited list -->
                  <xsl:element name="xsl:variable">
                        <xsl:attribute name="name">
                              <xsl:value-of select="replace($name,'_equal-list','')"/>
                        </xsl:attribute>
                        <xsl:attribute name="select">
                              <xsl:value-of select="concat('tokenize($',$name,',',$apos,'=',$apos,')')"/>
                        </xsl:attribute>
                  </xsl:element>
            </xsl:if>
      </xsl:template>
</xsl:stylesheet>
