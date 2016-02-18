<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
   <xsl:variable name="projectpath"
                 select="'D:\All-SIL-Publishing\github-pre\Local-pub-Bible-conc'"/>
   <xsl:variable name="cd"
                 select="'D:\All-SIL-Publishing\github-pre\Local-pub-Bible-conc'"/>
   <xsl:variable name="pubpath"
                 select="'D:\All-SIL-Publishing\github-pre\Local-pub-Bible-conc\pub'"/>
   <xsl:variable name="true" select="tokenize('true yes on 1','\s+')"/>
   <xsl:variable name="comment1">iso code                                </xsl:variable>
   <xsl:param name="iso" select="'eng'"/>
   <xsl:variable name="comment2">language name                           </xsl:variable>
   <xsl:param name="languagename" select="'English'"/>
   <xsl:variable name="comment3">country                                 </xsl:variable>
   <xsl:param name="country" select="'Philippines'"/>
   <xsl:variable name="comment4">Rights holder                           </xsl:variable>
   <xsl:param name="rightsholder" select="'Public Domain'"/>
   <xsl:variable name="comment5">title of pub                            </xsl:variable>
   <xsl:param name="title" select="'World English Bible Concordance'"/>
   <xsl:variable name="comment6">title of pub                            </xsl:variable>
   <xsl:param name="subtitle" select="'Complete'"/>
   <xsl:variable name="comment7">usx export path                         </xsl:variable>
   <xsl:param name="usxexportpath" select="'D:\usx\*.usx'"/>
   <xsl:variable name="comment8">usx project path                        </xsl:variable>
   <xsl:param name="usxpath" select="concat($projectpath,'\usx')"/>
   <xsl:variable name="comment9">files for collection                    </xsl:variable>
   <xsl:param name="collectionfile" select="'*.usx'"/>
   <xsl:variable name="comment10">group node                              </xsl:variable>
   <xsl:param name="groupnodelist" select="'book chapter'"/>
   <xsl:variable name="comment11"> book order                             </xsl:variable>
   <xsl:param name="bookorderfile"
              select="concat($pubpath,'\resources\book-chaps.txt')"/>
   <xsl:variable name="comment12">web site for download                   </xsl:variable>
   <xsl:param name="website" select="'www.ebible.net'"/>
   <xsl:variable name="comment13">remove elements                         </xsl:variable>
   <xsl:param name="remove-element-content_list"
              select="'bookGroup note chapter figure'"/>
   <xsl:variable name="remove-element-content"
                 select="tokenize($remove-element-content_list,'\s+')"/>
   <xsl:variable name="comment14">remove elements                         </xsl:variable>
   <xsl:param name="remove-element_list" select="'char'"/>
   <xsl:variable name="remove-element" select="tokenize($remove-element_list,'\s+')"/>
   <xsl:variable name="comment15">                                        </xsl:variable>
   <xsl:param name="del-ec-attrib-name" select="'style'"/>
   <xsl:variable name="comment16">                                        </xsl:variable>
   <xsl:param name="del-ec-attrib-value_list"
              select="'s s1 s2 s3 sp ms r mt mt1 mt2 mt3 restore d periph d bk'"/>
   <xsl:variable name="del-ec-attrib-value"
                 select="tokenize($del-ec-attrib-value_list,'\s+')"/>
   <xsl:variable name="comment17">                                        </xsl:variable>
   <xsl:param name="del-e-attrib-name" select="'style'"/>
   <xsl:variable name="comment18">                                        </xsl:variable>
   <xsl:param name="conccss" select="'../css/conc1.css'"/>
   <xsl:variable name="comment19">                                        </xsl:variable>
   <xsl:param name="concfrontmattercss" select="'../css/concfront.css'"/>
   <xsl:variable name="comment20">                                        </xsl:variable>
   <xsl:param name="min-word-length" select="'3'"/>
   <xsl:variable name="comment21">                                        </xsl:variable>
   <xsl:param name="compiler" select="'Ian McQuay  '"/>
   <xsl:variable name="comment22">                                        </xsl:variable>
   <xsl:param name="publisher" select="'ebible.org'"/>
   <xsl:variable name="comment23">                                        </xsl:variable>
   <xsl:param name="publication-date" select="'2016'"/>
   <xsl:variable name="comment24">                                        </xsl:variable>
   <xsl:param name="verso-top"
              select="'This concordance omits one and two letter words.'"/>
   <xsl:variable name="comment25">                                        </xsl:variable>
   <xsl:param name="verso-bottom"
              select="'Concordance builder: Vimod-pub Bible-conc_https://github.com/silasiapub/bible-conc_Typesetting engine: PrinceXML_http://princexml.com'"/>
   <xsl:variable name="comment26">                                        </xsl:variable>
   <xsl:param name="verso-rights" select="'Public Domain'"/>
   <xsl:variable name="comment27"
                 select="'                                        ;projectxslt'"/>
</xsl:stylesheet>
