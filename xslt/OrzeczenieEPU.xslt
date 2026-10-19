<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:curr="http://www.currenda.pl/epu" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:link="http://www.xbrl.org/2003/linkbase" xmlns:xbrldi="http://xbrl.org/2006/xbrldi" xmlns:xbrli="http://www.xbrl.org/2003/instance" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:altova="http://www.altova.com" version="1.0" exclude-result-prefixes="curr fn link xbrldi xbrli xdt xlink xs xsd xsi">
  <xsl:output version="4.0" method="html" indent="no" encoding="UTF-8" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd" />
  <xsl:param name="SV_OutputFormat" select="'HTML'" />
  <xsl:variable name="XML" select="/" />
  <xsl:template match="/">
    <html>
      <head>
        <title />
      </head>
      <body style="margin-left=0.6in; margin-right=0.6in; margin-top=0.79in; margin-bottom=0.79in">
        <style type="text/css">
          span.spanStyle1{ font-family:"3 of 9 Barcode"; font-size:large;  }
        </style>
        <div style="margin:auto; width:640px;">
          <xsl:for-each select="$XML">
            <div>
              <table width="100%">
                <tr>
                  <td valign="top">
                    <div align="left">
                      <span style="font-weight:bold; width:640px;">
                        <xsl:text>Sygnatura akt </xsl:text>
                      </span>
                      <span style="width:640px;">
                        <xsl:text />
                      </span>
                      <xsl:for-each select="curr:OrzeczenieEPU">
                        <xsl:for-each select="curr:Sygnatura">
                          <span style="font-weight:bold;">
                            <xsl:apply-templates />
                          </span>
                        </xsl:for-each>
                      </xsl:for-each>
                    </div>
                  </td>
                  <td>
                    <xsl:if test="string-length( curr:OrzeczenieEPU/@KOD )&gt;0">
                      <div align="right">
                        <span class="spanStyle1">
                          <xsl:value-of select="concat( '*',curr:OrzeczenieEPU/@KOD,'*')" />
                        </span>
                      </div>
                    </xsl:if>
                    <xsl:if test="string-length( curr:OrzeczenieEPU/@KOD )&gt;0 and 1 = 0">
                      <div style="display:none;" align="right">
                        <xsl:for-each select="curr:OrzeczenieEPU">
                          <xsl:for-each select="@KOD">
                            <span style="width:640px;">
                              <xsl:text>KOD  </xsl:text>
                            </span>
                            <span>
                              <xsl:value-of select="string(.)" />
                            </span>
                          </xsl:for-each>
                        </xsl:for-each>
                      </div>
                    </xsl:if>
                  </td>
                </tr>
              </table>
            </div>
            <br />
            <div align="center">
              <p />
              <xsl:for-each select="curr:OrzeczenieEPU">
                <h3 align="center">
                  <xsl:for-each select="@nazwaOrzeczenia">
                    <span>
                      <xsl:value-of select="string(.)" />
                    </span>
                  </xsl:for-each>
                </h3>
              </xsl:for-each>
            </div>
            <div align="right">
              <xsl:for-each select="curr:OrzeczenieEPU">
                <xsl:for-each select="@dataOrzeczenia">
                  <span style="width:640px;">
                    <xsl:text>Data wydania </xsl:text>
                  </span>
                  <span>
                    <xsl:value-of select="string(.)" />
                  </span>
                </xsl:for-each>
              </xsl:for-each>
            </div>
            <div align="justify">
              <xsl:for-each select="curr:OrzeczenieEPU">
                <xsl:for-each select="curr:SadEPU">
                  <xsl:for-each select="curr:Nazwa">
                    <xsl:apply-templates />
                  </xsl:for-each>
                  <xsl:text> </xsl:text>
                  <xsl:for-each select="curr:Wydzial">
                    <xsl:apply-templates />
                  </xsl:for-each>
                </xsl:for-each>
              </xsl:for-each>
            </div>
            <div>
              <xsl:for-each select="curr:OrzeczenieEPU">
                <xsl:for-each select="curr:WSkladzie">
                  <xsl:apply-templates />
                </xsl:for-each>
                <xsl:for-each select="curr:WSkladzie">
                  <xsl:if test="string-length(.) &gt; 1">
                    <br />
                  </xsl:if>
                </xsl:for-each>
                <xsl:for-each select="curr:Sedzia">
                  <xsl:apply-templates />
                </xsl:for-each>
                <br />
                <br />
                <xsl:for-each select="curr:NaPosiedzeniu">
                  <xsl:apply-templates />
                </xsl:for-each>
                <br />
                <xsl:for-each select="curr:Przez">
                  <xsl:apply-templates />
                </xsl:for-each>
              </xsl:for-each>
            </div>
            <xsl:for-each select="curr:OrzeczenieEPU">
              <xsl:for-each select="curr:ListaPowodow">
                <xsl:for-each select="curr:Powod">
                  <xsl:for-each select="curr:Nazwa">
                    <span style="font-weight:bold;">
                      <xsl:apply-templates />
                      <br />
                    </span>
                  </xsl:for-each>
                </xsl:for-each>
              </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="curr:OrzeczenieEPU">
              <xsl:for-each select="curr:NakazujeAby">
                <xsl:apply-templates />
                <br />
              </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="curr:OrzeczenieEPU">
              <xsl:for-each select="curr:ListaPozwanych">
                <xsl:for-each select="curr:Pozwany">
                  <xsl:for-each select="curr:Nazwa">
                    <span style="font-weight:bold;">
                      <xsl:apply-templates />
                      <br />
                    </span>
                  </xsl:for-each>
                </xsl:for-each>
              </xsl:for-each>
            </xsl:for-each>
            <xsl:if test="curr:OrzeczenieEPU/@kodDecyzji=17">
              <div>
                <span>
                  <xsl:text>w przedmiocie nadania klauzuli wykonalności</xsl:text>
                </span>
              </div>
            </xsl:if>
            <xsl:for-each select="curr:OrzeczenieEPU">
              <xsl:for-each select="curr:NaSkutek">
                <xsl:apply-templates />
              </xsl:for-each>
            </xsl:for-each>
            <div align="center">
              <xsl:for-each select="curr:OrzeczenieEPU">
                <xsl:for-each select="curr:Postanawia">
                  <xsl:apply-templates />
                </xsl:for-each>
              </xsl:for-each>
            </div>
            <div>
              <xsl:for-each select="curr:OrzeczenieEPU">
                <xsl:for-each select="curr:Tresc">
                  <xsl:apply-templates />
                </xsl:for-each>
              </xsl:for-each>
              <xsl:text> </xsl:text>
              <xsl:if test="string-length( curr:OrzeczenieEPU/curr:CelEgzekucji )&gt;0">
                <xsl:for-each select="curr:OrzeczenieEPU">
                  <xsl:for-each select="curr:CelEgzekucji">
                    <span>
                      <xsl:text />
                    </span>
                    <xsl:apply-templates />
                  </xsl:for-each>
                </xsl:for-each>
                <xsl:text>, oznaczając ten tytuł liczbą porządkową </xsl:text>
                <xsl:for-each select="curr:OrzeczenieEPU">
                  <xsl:for-each select="curr:NrTytuluWykon">
                    <span>
                      <xsl:text />
                    </span>
                    <xsl:apply-templates />
                  </xsl:for-each>
                </xsl:for-each>
              </xsl:if>
              <xsl:if test="curr:OrzeczenieEPU/curr:TempPrzekazanieTresc">
                <xsl:if test="curr:OrzeczenieEPU/curr:TempPrzekazanieID">
                  <xsl:for-each select="curr:OrzeczenieEPU/curr:TempPrzekazanieTresc">
                    <xsl:text />
                    <xsl:value-of select="string(.)" />
                  </xsl:for-each>
                </xsl:if>
              </xsl:if>
            </div>
            <xsl:if test="string-length( curr:OrzeczenieEPU/curr:Uzasadnienie )&gt;5">
              <div align="center">
                <span style="font-weight:bold; width:640px;">
                  <xsl:text>U Z A S A D N I E N I E</xsl:text>
                </span>
              </div>
            </xsl:if>
            <div style="width:inherit;" align="justify">
              <xsl:for-each select="curr:OrzeczenieEPU">
                <xsl:for-each select="curr:Uzasadnienie">
                  <span style="width:640px;">
                    <xsl:text />
                  </span>
                  <xsl:apply-templates />
                </xsl:for-each>
              </xsl:for-each>
            </div>
          </xsl:for-each>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>