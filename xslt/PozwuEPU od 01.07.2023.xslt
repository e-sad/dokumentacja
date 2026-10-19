<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:curr="http://www.currenda.pl/epu" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:link="http://www.xbrl.org/2003/linkbase" xmlns:xbrldi="http://xbrl.org/2006/xbrldi" xmlns:xbrli="http://www.xbrl.org/2003/instance" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:altova="http://www.altova.com" version="1.0" exclude-result-prefixes="curr fn link xbrldi xbrli xdt xlink xs xsd xsi">
  <xsl:output version="5.0" method="html" indent="no" encoding="UTF-8" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd" />
  <xsl:param name="SV_OutputFormat" select="'HTML'" />
  <xsl:param name="ukryjDatWymagalnosci" />
  <xsl:param name="peselePelnomocReprezent" />
  <xsl:variable name="XML" select="/" />
  <xsl:variable name="DataZmiany" select="'2011-01-01'" />
  <xsl:decimal-format name="european" decimal-separator="," grouping-separator=" " />
  <xsl:template match="@okres" name="okresTemplate">
    <xsl:if test="@okres=0">
      <xsl:for-each select="@okres">
        <span>
          <xsl:text> rocznie </xsl:text>
        </span>
      </xsl:for-each>
    </xsl:if>
    <xsl:if test="@okres=1">
      <xsl:for-each select="@okres">
        <span>
          <xsl:text> kwartalnie </xsl:text>
        </span>
      </xsl:for-each>
    </xsl:if>
    <xsl:if test="@okres=2">
      <xsl:for-each select="@okres">
        <span>
          <xsl:text> miesięcznie</xsl:text>
        </span>
      </xsl:for-each>
    </xsl:if>
    <xsl:if test="@okres=3">
      <xsl:for-each select="@okres">
        <span>
          <xsl:text> tygodniowo</xsl:text>
        </span>
      </xsl:for-each>
    </xsl:if>
    <xsl:if test="@okres=4">
      <xsl:for-each select="@okres">
        <span>
          <xsl:text> dziennie</xsl:text>
        </span>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>
  <xsl:template match="/">
    <xsl:for-each select="$XML">
      <br />
      <div align="left">
        <xsl:for-each select="curr:PozewEPU">
          <xsl:for-each select="@dataZlozenia">
            <span>
              <xsl:text>Data ostatniej modyfikacji </xsl:text>
            </span>
            <span>
              <xsl:value-of select="string(.)" />
            </span>
          </xsl:for-each>
        </xsl:for-each>
      </div>
      <div>
        <xsl:for-each select="curr:PozewEPU">
          <xsl:for-each select="curr:SprawaWgPowoda">
            <span>
              <xsl:text>Oznaczenie sprawy wg składającego/powoda </xsl:text>
            </span>
            <xsl:apply-templates />
          </xsl:for-each>
        </xsl:for-each>
      </div>
      <div align="right">
        <span>
          <xsl:text> </xsl:text>
        </span>
        <xsl:for-each select="curr:PozewEPU">
          <xsl:for-each select="curr:Adresat">
            <xsl:for-each select="curr:Nazwa">
              <xsl:apply-templates />
            </xsl:for-each>
          </xsl:for-each>
        </xsl:for-each>
      </div>
      <div align="right">
        <xsl:for-each select="curr:PozewEPU">
          <xsl:for-each select="curr:Adresat">
            <xsl:choose>
              <xsl:when test="number(number(translate(substring(../@dataZlozenia,1,10),'-','')) &gt; translate(substring($DataZmiany,1,10),'-',''))">
                <xsl:text>VI Wydział Cywilny</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:for-each select="curr:Wydzial">
                  <xsl:apply-templates />
                </xsl:for-each>
              </xsl:otherwise>
            </xsl:choose>
            <br />
            <xsl:for-each select="curr:Adres">
              <xsl:for-each select="@ulica">
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
              </xsl:for-each>
              <xsl:for-each select="@nr_domu">
                <span>
                  <xsl:text> </xsl:text>
                </span>
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
              </xsl:for-each>
              <xsl:if test="name(@nr_mieszkania) and  name(@nr_mieszkania)!='' and string-length( normalize-space( @nr_mieszkania)) &gt;0">
                <xsl:for-each select="@nr_mieszkania">
                  <span>
                    <xsl:text>/</xsl:text>
                  </span>
                  <span>
                    <xsl:value-of select="string(.)" />
                  </span>
                </xsl:for-each>
              </xsl:if>
              <br />
              <xsl:if test="string-length( @kod )!=5">
                <xsl:for-each select="@kod">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <span>
                    <xsl:value-of select="string(.)" />
                  </span>
                </xsl:for-each>
              </xsl:if>
              <xsl:if test="string-length( @kod )=5">
                <xsl:for-each select="@kod">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <span>
                    <xsl:value-of select="concat(substring( . , 1,2 ),'-',substring( . , 3,3 ))" />
                  </span>
                </xsl:for-each>
              </xsl:if>
              <xsl:for-each select="@miejscowosc">
                <span>
                  <xsl:text> </xsl:text>
                </span>
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
              </xsl:for-each>
            </xsl:for-each>
          </xsl:for-each>
        </xsl:for-each>
      </div>
      <div>
        <span style="text-decoration:underline; ">
          <xsl:text>Osoba składająca</xsl:text>
        </span>
      </div>
      <div>
        <xsl:for-each select="curr:PozewEPU">
          <xsl:for-each select="curr:OsobaSkladajaca">
            <xsl:for-each select="curr:Osoba">
              <xsl:for-each select="curr:Imie">
                <xsl:apply-templates />
                <span>
                  <xsl:text> </xsl:text>
                </span>
              </xsl:for-each>
              <xsl:for-each select="curr:Imie2">
                <xsl:apply-templates />
                <span>
                  <xsl:text> </xsl:text>
                </span>
              </xsl:for-each>
              <xsl:for-each select="curr:Nazwisko">
                <xsl:apply-templates />
              </xsl:for-each>
              <span>
                <xsl:text> </xsl:text>
              </span>
              <xsl:if test="contains($peselePelnomocReprezent, curr:PESEL)=false">
                <xsl:for-each select="curr:PESEL">
                  <span>
                    <xsl:text>   PESEL </xsl:text>
                  </span>
                  <xsl:apply-templates />
                </xsl:for-each>
              </xsl:if>
              <br />
              <xsl:for-each select="curr:stanowisko">
                <xsl:apply-templates />
              </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="curr:Nazwa">
              <xsl:apply-templates />
            </xsl:for-each>
          </xsl:for-each>
        </xsl:for-each>
      </div>
      <div>
        <xsl:for-each select="curr:PozewEPU">
          <xsl:for-each select="curr:OsobaSkladajaca">
            <xsl:for-each select="curr:Adres">
              <xsl:for-each select="@ulica">
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
                <span>
                  <xsl:text> </xsl:text>
                </span>
              </xsl:for-each>
              <xsl:if test="string-length(@ulica) &lt; 3">
                <xsl:for-each select="@miejscowosc">
                  <span>
                    <xsl:value-of select="string(.)" />
                  </span>
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                </xsl:for-each>
              </xsl:if>
              <xsl:for-each select="@nr_domu">
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
                <span>
                  <xsl:text> </xsl:text>
                </span>
              </xsl:for-each>
              <span>
                <xsl:text> </xsl:text>
              </span>
              <xsl:if test="string-length( @nr_mieszkania )&gt;0">
                <xsl:if test="name(@nr_mieszkania) and  name(@nr_mieszkania)!='' and string-length( normalize-space( @nr_mieszkania)) &gt;0">
                  <xsl:for-each select="@nr_mieszkania">
                    <span>
                      <xsl:text>/</xsl:text>
                    </span>
                    <span>
                      <xsl:value-of select="string(.)" />
                    </span>
                    <span>
                      <xsl:text> </xsl:text>
                    </span>
                  </xsl:for-each>
                </xsl:if>
              </xsl:if>
              <xsl:if test="string-length( @kod )!=5">
                <xsl:for-each select="@kod">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <span>
                    <xsl:value-of select="string(.)" />
                  </span>
                </xsl:for-each>
              </xsl:if>
              <span>
                <xsl:text> </xsl:text>
              </span>
              <xsl:if test="string-length( @kod )=5">
                <xsl:for-each select="@kod">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <span>
                    <xsl:value-of select="concat( substring( . ,1, 2 ),'-' ,substring( . , 3 ,3 ) )" />
                  </span>
                </xsl:for-each>
              </xsl:if>
              <xsl:if test="string-length(@ulica)&gt;2">
                <xsl:for-each select="@miejscowosc">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <span>
                    <xsl:value-of select="string(.)" />
                  </span>
                </xsl:for-each>
              </xsl:if>
              <span>
                <xsl:text> </xsl:text>
              </span>
              <xsl:if test="@poczta!=@miejscowosc or string-length( @ulica )&lt;3">
                <xsl:for-each select="@poczta">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <span>
                    <xsl:value-of select="string(.)" />
                  </span>
                </xsl:for-each>
              </xsl:if>
              <br />
            </xsl:for-each>
            <xsl:for-each select="@podstawa">
              <br />
              <span>
                <xsl:value-of select="string(.)" />
              </span>
              <br />
            </xsl:for-each>
            <xsl:for-each select="$XML">
              <xsl:for-each select="curr:PozewEPU">
                <xsl:for-each select="curr:ListaPowodow">
                  <xsl:if test="( curr:Powod/curr:reprezentacja=1 ) or ( curr:Powod/curr:reprezentacja=3 ) or ( curr:Powod/curr:reprezentacja=4 )">
                    <span style="text-decoration:underline; ">
                      <xsl:text>W imieniu: </xsl:text>
                    </span>
                  </xsl:if>
                  <xsl:for-each select="curr:Powod[curr:reprezentacja!=0 and curr:reprezentacja!=2]">
                    <xsl:for-each select="curr:OsobaFizyczna">
                      <xsl:for-each select="curr:Imie">
                        <br />
                        <xsl:apply-templates />
                      </xsl:for-each>
                      <xsl:for-each select="curr:Imie2">
                        <span>
                          <xsl:text> </xsl:text>
                        </span>
                        <xsl:apply-templates />
                      </xsl:for-each>
                      <xsl:for-each select="curr:Nazwisko">
                        <span>
                          <xsl:text> </xsl:text>
                        </span>
                        <xsl:apply-templates />
                      </xsl:for-each>
                    </xsl:for-each>
                    <xsl:for-each select="curr:Instytucja">
                      <xsl:for-each select="curr:Nazwa">
                        <xsl:apply-templates />
                      </xsl:for-each>
                      <xsl:if test="contains( curr:Siedziba , 'z siedzibą' )=false">
                        <xsl:for-each select="curr:Siedziba">
                          <span>
                            <xsl:if test="((starts-with((.), 'W') or starts-with((.), 'F'))and (not(contains('AĄEĘIOÓUY',substring((.),2,1)) or contains('aąeęioóuy', substring((.),2,1)))))">
                              <xsl:text> z siedzibą we</xsl:text>
                            </xsl:if>
                            <xsl:if test="not(((starts-with((.), 'W') or starts-with((.), 'F')) and (not(contains('AĄEĘIOÓUY',substring((.),2,1)) or contains('aąeęioóuy', substring((.),2,1)) ) ) ))">
                              <xsl:text> z siedzibą w</xsl:text>
                            </xsl:if>
                          </span>
                        </xsl:for-each>
                      </xsl:if>
                      <xsl:for-each select="curr:Siedziba">
                        <span>
                          <xsl:text> </xsl:text>
                        </span>
                        <xsl:apply-templates />
                      </xsl:for-each>
                    </xsl:for-each>
                    <xsl:if test="curr:reprezentacja=1">
                      <xsl:for-each select="curr:reprezentacja">
                        <span>
                          <xsl:text> (pełnomocnik)</xsl:text>
                        </span>
                      </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="curr:reprezentacja=3">
                      <xsl:for-each select="curr:reprezentacja">
                        <span>
                          <xsl:text> (przedstawiciel ustawowy)</xsl:text>
                        </span>
                      </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="curr:reprezentacja=4">
                      <xsl:for-each select="curr:reprezentacja">
                        <span>
                          <xsl:text> (osoba reprezentująca) </xsl:text>
                        </span>
                      </xsl:for-each>
                    </xsl:if>
                  </xsl:for-each>
                </xsl:for-each>
              </xsl:for-each>
            </xsl:for-each>
          </xsl:for-each>
        </xsl:for-each>
      </div>
      <br />
      <xsl:if test="count( curr:PozewEPU/curr:ListaPowodow/curr:Powod )&gt;1">
        <div>
          <span style="text-decoration:underline; ">
            <xsl:text>Powodowie</xsl:text>
          </span>
        </div>
      </xsl:if>
      <xsl:if test="count( curr:PozewEPU/curr:ListaPowodow/curr:Powod )&lt;=1">
        <div>
          <span style="text-decoration:underline; ">
            <xsl:text>Powód</xsl:text>
          </span>
        </div>
      </xsl:if>
      <div>
        <xsl:for-each select="curr:PozewEPU">
          <xsl:for-each select="curr:ListaPowodow">
            <xsl:for-each select="curr:Powod">
              <xsl:for-each select="curr:OsobaFizyczna">
                <xsl:for-each select="curr:Imie">
                  <span style="font-weight:bold; ">
                    <xsl:apply-templates />
                  </span>
                </xsl:for-each>
                <xsl:for-each select="curr:Imie2">
                  <span style="font-weight:bold; ">
                    <xsl:text> </xsl:text>
                  </span>
                  <span style="font-weight:bold; ">
                    <xsl:apply-templates />
                  </span>
                </xsl:for-each>
                <xsl:for-each select="curr:Nazwisko">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <span style="font-weight:bold; ">
                    <xsl:apply-templates />
                  </span>
                </xsl:for-each>
                <xsl:for-each select="curr:Nazwa">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <xsl:apply-templates />
                </xsl:for-each>
                <xsl:if test="curr:PESEL != ''">
                  <xsl:for-each select="curr:PESEL">
                    <span>
                      <xsl:text> PESEL </xsl:text>
                    </span>
                    <xsl:apply-templates />
                  </xsl:for-each>
                </xsl:if>
              </xsl:for-each>
              <xsl:for-each select="curr:Instytucja">
                <xsl:for-each select="curr:Nazwa">
                  <span style="font-weight:bold; ">
                    <xsl:apply-templates />
                  </span>
                </xsl:for-each>
                <xsl:if test="contains( curr:Siedziba , 'z siedzibą' )=false">
                  <xsl:for-each select="curr:Siedziba">
                    <span>
                      <xsl:text> </xsl:text>
                    </span>
                    <span style="font-weight:bold; ">
                      <xsl:if test="((starts-with((.), 'W') or starts-with((.), 'F'))and (not(contains('AĄEĘIOÓUY',substring((.),2,1)) or contains('aąeęioóuy', substring((.),2,1)))))">
                        <xsl:text>z siedzibą we</xsl:text>
                      </xsl:if>
                      <xsl:if test="not(((starts-with((.), 'W') or starts-with((.), 'F')) and (not(contains('AĄEĘIOÓUY',substring((.),2,1)) or contains('aąeęioóuy', substring((.),2,1)) ) ) ))">
                        <xsl:text>z siedzibą w</xsl:text>
                      </xsl:if>
                    </span>
                  </xsl:for-each>
                </xsl:if>
                <xsl:for-each select="curr:Siedziba">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <span style="font-weight:bold; ">
                    <xsl:apply-templates />
                  </span>
                </xsl:for-each>
                <xsl:if test="curr:KRS != '' and curr:czyRejestr = 1">
                  <xsl:for-each select="curr:KRS">
                    <span>
                      <xsl:text> KRS </xsl:text>
                    </span>
                    <xsl:apply-templates />
                  </xsl:for-each>
                </xsl:if>
                <xsl:if test="curr:czyRejestr = 2">
                  <xsl:for-each select="curr:InnyRejestr">
                    <xsl:for-each select="@typ">
                      <span>
                        <xsl:text> </xsl:text>
                      </span>
                      <span>
                        <xsl:value-of select="string(.)" />
                      </span>
                    </xsl:for-each>
                    <xsl:for-each select="@organ">
                      <span>
                        <xsl:text> </xsl:text>
                      </span>
                      <span>
                        <xsl:value-of select="string(.)" />
                      </span>
                    </xsl:for-each>
                    <xsl:for-each select="@numer">
                      <span>
                        <xsl:text> </xsl:text>
                      </span>
                      <span>
                        <xsl:value-of select="string(.)" />
                      </span>
                    </xsl:for-each>
                  </xsl:for-each>
                </xsl:if>
                <xsl:if test="curr:REGON != ''">
                  <xsl:for-each select="curr:REGON">
                    <span>
                      <xsl:text> REGON </xsl:text>
                    </span>
                    <xsl:apply-templates />
                  </xsl:for-each>
                </xsl:if>
              </xsl:for-each>
              <xsl:if test="curr:NIP != ''">
                <xsl:for-each select="curr:NIP">
                  <span>
                    <xsl:text> NIP </xsl:text>
                  </span>
                  <xsl:apply-templates />
                </xsl:for-each>
              </xsl:if>
              <xsl:for-each select="curr:Adres">
                <xsl:for-each select="@ulica">
                  <br />
                  <span>
                    <xsl:value-of select="string(.)" />
                  </span>
                </xsl:for-each>
                <xsl:if test="string-length(@ulica) &lt; 3">
                  <xsl:for-each select="@miejscowosc">
                    <span>
                      <xsl:value-of select="string(.)" />
                    </span>
                  </xsl:for-each>
                </xsl:if>
                <xsl:for-each select="@nr_domu">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <span>
                    <xsl:value-of select="string(.)" />
                  </span>
                </xsl:for-each>
                <xsl:if test="name(@nr_mieszkania) and  name(@nr_mieszkania)!='' and string-length( normalize-space( @nr_mieszkania)) &gt;0">
                  <xsl:for-each select="@nr_mieszkania">
                    <span>
                      <xsl:text>/</xsl:text>
                    </span>
                    <span>
                      <xsl:value-of select="string(.)" />
                    </span>
                    <span>
                      <xsl:text> </xsl:text>
                    </span>
                  </xsl:for-each>
                </xsl:if>
                <xsl:if test="string-length( @kod )!=5">
                  <xsl:for-each select="@kod">
                    <span>
                      <xsl:text> </xsl:text>
                    </span>
                    <span>
                      <xsl:value-of select="string(.)" />
                    </span>
                  </xsl:for-each>
                </xsl:if>
                <xsl:if test="string-length( @kod )=5">
                  <xsl:for-each select="@kod">
                    <span>
                      <xsl:text> </xsl:text>
                    </span>
                    <span>
                      <xsl:value-of select="concat(substring( . ,1, 2 ) ,'-', substring( . , 3 , 3 ) )" />
                    </span>
                  </xsl:for-each>
                </xsl:if>
                <xsl:if test="string-length(@ulica)&gt;2">
                  <xsl:for-each select="@miejscowosc">
                    <span>
                      <xsl:text> </xsl:text>
                    </span>
                    <span>
                      <xsl:value-of select="string(.)" />
                    </span>
                  </xsl:for-each>
                </xsl:if>
                <xsl:if test="@poczta!=@miejscowosc or string-length( @ulica )&lt;3">
                  <xsl:for-each select="@poczta">
                    <span>
                      <xsl:text> </xsl:text>
                    </span>
                    <span>
                      <xsl:value-of select="string(.)" />
                    </span>
                  </xsl:for-each>
                </xsl:if>
                <br />
                <xsl:if test="string-length( @wojewodztwo )&gt;0">
                  <xsl:if test="name(@wojewodztwo) and  name(@wojewodztwo)!='' and string-length( normalize-space( @wojewodztwo)) &gt;0">
                    <xsl:for-each select="@wojewodztwo">
                      <span>
                        <xsl:text>Województwo: </xsl:text>
                      </span>
                      <span>
                        <xsl:value-of select="string(.)" />
                      </span>
                      <span>
                        <xsl:text> </xsl:text>
                      </span>
                    </xsl:for-each>
                  </xsl:if>
                </xsl:if>
              </xsl:for-each>
              <br />
              <xsl:value-of select="curr:ObcokrajowiecString" />
              <br />
              <br />
            </xsl:for-each>
          </xsl:for-each>
        </xsl:for-each>
      </div>
      <xsl:if test="count( curr:PozewEPU/curr:ListaPozwanych/curr:Pozwany )&gt;1">
        <div>
          <span style="text-decoration:underline; ">
            <xsl:text>Pozwani</xsl:text>
          </span>
        </div>
      </xsl:if>
      <xsl:if test="count( curr:PozewEPU/curr:ListaPozwanych/curr:Pozwany )&lt;=1">
        <div>
          <span style="text-decoration:underline; ">
            <xsl:text>Pozwany</xsl:text>
          </span>
        </div>
      </xsl:if>
      <div>
        <xsl:for-each select="curr:PozewEPU">
          <xsl:for-each select="curr:ListaPozwanych">
            <xsl:for-each select="curr:Pozwany">
              <xsl:for-each select="curr:OsobaFizyczna">
                <xsl:for-each select="curr:Imie">
                  <span style="font-weight:bold; ">
                    <xsl:apply-templates />
                  </span>
                </xsl:for-each>
                <xsl:for-each select="curr:Imie2">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <span style="font-weight:bold; ">
                    <xsl:apply-templates />
                  </span>
                </xsl:for-each>
                <xsl:for-each select="curr:Nazwisko">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <span style="font-weight:bold; ">
                    <xsl:apply-templates />
                  </span>
                </xsl:for-each>
                <xsl:for-each select="curr:Nazwa">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <xsl:apply-templates />
                </xsl:for-each>
                <xsl:if test="curr:PESEL != ''">
                  <xsl:for-each select="curr:PESEL">
                    <span>
                      <xsl:text> PESEL </xsl:text>
                    </span>
                    <xsl:apply-templates />
                  </xsl:for-each>
                </xsl:if>
              </xsl:for-each>
              <xsl:for-each select="curr:Instytucja">
                <xsl:for-each select="curr:Nazwa">
                  <span style="font-weight:bold; ">
                    <xsl:apply-templates />
                  </span>
                </xsl:for-each>
                <xsl:if test="contains( curr:Siedziba , 'z siedzibą' )=false">
                  <xsl:for-each select="curr:Siedziba">
                    <span>
                      <xsl:text> </xsl:text>
                    </span>
                    <span style="font-weight:bold; ">
                      <xsl:if test="((starts-with((.), 'W') or starts-with((.), 'F'))and (not(contains('AĄEĘIOÓUY',substring((.),2,1)) or contains('aąeęioóuy', substring((.),2,1)))))">
                        <xsl:text>z siedzibą we</xsl:text>
                      </xsl:if>
                      <xsl:if test="not(((starts-with((.), 'W') or starts-with((.), 'F')) and (not(contains('AĄEĘIOÓUY',substring((.),2,1)) or contains('aąeęioóuy', substring((.),2,1)) ) ) ))">
                        <xsl:text>z siedzibą w</xsl:text>
                      </xsl:if>
                    </span>
                  </xsl:for-each>
                </xsl:if>
                <xsl:for-each select="curr:Siedziba">
                  <span style="font-weight:bold; ">
                    <xsl:text> </xsl:text>
                  </span>
                  <span style="font-weight:bold; ">
                    <xsl:apply-templates />
                  </span>
                </xsl:for-each>
                <xsl:if test="curr:KRS != '' and curr:czyRejestr = 1">
                  <xsl:for-each select="curr:KRS">
                    <span>
                      <xsl:text> KRS </xsl:text>
                    </span>
                    <xsl:apply-templates />
                  </xsl:for-each>
                </xsl:if>
                <xsl:if test="curr:czyRejestr = 2">
                  <xsl:for-each select="curr:InnyRejestr">
                    <xsl:for-each select="@typ">
                      <span>
                        <xsl:text> </xsl:text>
                      </span>
                      <span>
                        <xsl:value-of select="string(.)" />
                      </span>
                    </xsl:for-each>
                    <xsl:for-each select="@organ">
                      <span>
                        <xsl:text> </xsl:text>
                      </span>
                      <span>
                        <xsl:value-of select="string(.)" />
                      </span>
                    </xsl:for-each>
                    <xsl:for-each select="@numer">
                      <span>
                        <xsl:text> </xsl:text>
                      </span>
                      <span>
                        <xsl:value-of select="string(.)" />
                      </span>
                    </xsl:for-each>
                  </xsl:for-each>
                </xsl:if>
                <xsl:if test="curr:REGON != ''">
                  <xsl:for-each select="curr:REGON">
                    <span>
                      <xsl:text> REGON </xsl:text>
                    </span>
                    <xsl:apply-templates />
                  </xsl:for-each>
                </xsl:if>
              </xsl:for-each>
              <xsl:if test="curr:NIP != ''">
                <xsl:for-each select="curr:NIP">
                  <span>
                    <xsl:text> NIP </xsl:text>
                  </span>
                  <xsl:apply-templates />
                </xsl:for-each>
              </xsl:if>
              <xsl:for-each select="curr:Adres">
                <xsl:for-each select="@ulica">
                  <br />
                  <span>
                    <xsl:value-of select="string(.)" />
                  </span>
                </xsl:for-each>
                <xsl:if test="string-length(@ulica) &lt; 3">
                  <xsl:for-each select="@miejscowosc">
                    <span>
                      <xsl:value-of select="string(.)" />
                    </span>
                  </xsl:for-each>
                </xsl:if>
                <xsl:for-each select="@nr_domu">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <span>
                    <xsl:value-of select="string(.)" />
                  </span>
                </xsl:for-each>
                <xsl:if test="name(@nr_mieszkania) and  name(@nr_mieszkania)!='' and string-length( normalize-space( @nr_mieszkania)) &gt;0">
                  <xsl:for-each select="@nr_mieszkania">
                    <span>
                      <xsl:text>/</xsl:text>
                    </span>
                    <span>
                      <xsl:value-of select="string(.)" />
                    </span>
                    <span>
                      <xsl:text> </xsl:text>
                    </span>
                  </xsl:for-each>
                </xsl:if>
                <xsl:if test="string-length( @kod )!=5">
                  <xsl:for-each select="@kod">
                    <span>
                      <xsl:text> </xsl:text>
                    </span>
                    <span>
                      <xsl:value-of select="string(.)" />
                    </span>
                  </xsl:for-each>
                </xsl:if>
                <xsl:if test="string-length( @kod )=5">
                  <xsl:for-each select="@kod">
                    <span>
                      <xsl:text> </xsl:text>
                    </span>
                    <span>
                      <xsl:value-of select="concat( substring( . ,1, 2 ) ,'-', substring( . , 3 , 3 ) )" />
                    </span>
                  </xsl:for-each>
                </xsl:if>
                <xsl:if test="string-length(@ulica)&gt;2">
                  <xsl:for-each select="@miejscowosc">
                    <span>
                      <xsl:text> </xsl:text>
                    </span>
                    <span>
                      <xsl:value-of select="string(.)" />
                    </span>
                  </xsl:for-each>
                </xsl:if>
                <xsl:if test="@poczta!=@miejscowosc or string-length( @ulica )&lt;3">
                  <xsl:for-each select="@poczta">
                    <span>
                      <xsl:text> </xsl:text>
                    </span>
                    <span>
                      <xsl:value-of select="string(.)" />
                    </span>
                  </xsl:for-each>
                </xsl:if>
                <br />
                <xsl:if test="string-length( @wojewodztwo )&gt;0">
                  <xsl:if test="name(@wojewodztwo) and  name(@wojewodztwo)!='' and string-length( normalize-space( @wojewodztwo)) &gt;0">
                    <xsl:for-each select="@wojewodztwo">
                      <span>
                        <xsl:text>Województwo: </xsl:text>
                      </span>
                      <span>
                        <xsl:value-of select="string(.)" />
                      </span>
                      <span>
                        <xsl:text> </xsl:text>
                      </span>
                    </xsl:for-each>
                  </xsl:if>
                </xsl:if>
              </xsl:for-each>
              <br />
              <xsl:value-of select="curr:ObcokrajowiecString" />
              <br />
              <br />
            </xsl:for-each>
          </xsl:for-each>
        </xsl:for-each>
      </div>
      <div>
        <xsl:for-each select="curr:PozewEPU">
          <xsl:for-each select="curr:WartoscSporu">
            <span>
              <xsl:text>Wartość przedmiotu sporu   </xsl:text>
            </span>
            <span style="font-weight:bold; ">
              <xsl:value-of select="format-number(number(translate(translate(string(.), ' ',''),',','.')), '### ##0,00', 'european')" />
            </span>
            <span style="font-weight:bold; ">
              <xsl:text> PLN</xsl:text>
            </span>
          </xsl:for-each>
        </xsl:for-each>
      </div>
      <br />
      <div>
        <h2 style="text-align:center; ">
          <span>
            <xsl:text>P O Z E W</xsl:text>
          </span>
        </h2>
      </div>
      <div align="center">
        <h3 style="text-align:center; " align="center">
          <span style="font-weight:bold; ">
            <xsl:text>o zapłatę</xsl:text>
          </span>
        </h3>
      </div>
      <br />
      <div>
        <span>
          <xsl:text>Wnoszę o zasądzenie na rzecz </xsl:text>
        </span>
        <xsl:if test="count( curr:PozewEPU/curr:ListaPowodow/curr:Powod )&lt;=1">
          <span>
            <xsl:value-of select="'Powoda'" />
          </span>
        </xsl:if>
        <xsl:if test="count( curr:PozewEPU/curr:ListaPowodow/curr:Powod )&gt;1">
          <span>
            <xsl:value-of select="'Powodów'" />
          </span>
        </xsl:if>
        <span>
          <xsl:text> od </xsl:text>
        </span>
        <xsl:if test="count( curr:PozewEPU/curr:ListaPozwanych/curr:Pozwany )&lt;=1">
          <span>
            <xsl:value-of select="'Pozwanego'" />
          </span>
        </xsl:if>
        <span>
          <xsl:text> </xsl:text>
        </span>
        <xsl:if test="count( curr:PozewEPU/curr:ListaPozwanych/curr:Pozwany )&gt;1">
          <span>
            <xsl:value-of select="'Pozwanych'" />
          </span>
        </xsl:if>
        <span>
          <xsl:text> następujących kwot:</xsl:text>
        </span>
      </div>
      <div>
        <table border="1">
          <xsl:variable name="altova:CurrContextGrid_0754B2F0" select="." />
          <thead>
            <tr>
              <th>
                <span>
                  <xsl:text>numer</xsl:text>
                </span>
              </th>
              <th>
                <span>
                  <xsl:text>wartość</xsl:text>
                </span>
              </th>
              <th style="width:58px; ">
                <span>
                  <xsl:text>waluta</xsl:text>
                </span>
              </th>
              <th style="width:1px; ">
                <span>
                  <xsl:text>opis</xsl:text>
                </span>
              </th>
              <th style="width:364px; ">
                <span>
                  <xsl:text> odsetki</xsl:text>
                </span>
              </th>
              <th>
                <span>
                  <xsl:text> dowody</xsl:text>
                </span>
              </th>
              <xsl:if test="count( curr:PozewEPU/curr:ListaRoszczen/curr:Roszczenie[@dataWymagalnosci] )&gt;0 and $ukryjDatWymagalnosci != 'true'">
                <th>
                  <span>
                    <xsl:text>data wymagalności</xsl:text>
                  </span>
                </th>
              </xsl:if>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="curr:PozewEPU">
              <xsl:choose>
                <xsl:when test="@version='2'">
                  <xsl:for-each select="curr:ListaRoszczen">
                    <xsl:for-each select="curr:Roszczenie">
                      <tr>
                        <td align="center">
                          <xsl:for-each select="@numer">
                            <span>
                              <xsl:value-of select="string(.)" />
                            </span>
                          </xsl:for-each>
                        </td>
                        <td align="right">
                          <xsl:for-each select="@wartosc">
                            <span>
                              <xsl:value-of select="format-number(number(translate(translate(string(.), ' ',''),',','.')), '### ##0,00', 'european')" />
                            </span>
                          </xsl:for-each>
                        </td>
                        <td style="width:58px; " align="right">
                          <xsl:for-each select="@waluta">
                            <span>
                              <xsl:value-of select="string(.)" />
                            </span>
                          </xsl:for-each>
                        </td>
                        <td style="width:1px; ">
                          <xsl:if test="(@solidarnie=0 or (@solidarnie=1 and (string-length( @opis )=0 or name(@opis)=''))) and (count( ../../curr:ListaPowodow/curr:Powod )+count(../../curr:ListaPozwanych/curr:Pozwany)&gt;2)">
                            <span>
                              <xsl:text>solidarnie</xsl:text>
                            </span>
                          </xsl:if>
                          <xsl:if test="@solidarnie=4">
                            <span>
                              <xsl:text>in solidum</xsl:text>
                            </span>
                          </xsl:if>
                          <xsl:if test="@solidarnie=2">
                            <span>
                              <xsl:text>solidarność bierna</xsl:text>
                            </span>
                          </xsl:if>
                          <xsl:if test="@solidarnie=3">
                            <span>
                              <xsl:text>solidarność czynna</xsl:text>
                            </span>
                          </xsl:if>
                          <br />
                          <xsl:for-each select="@opis">
                            <span>
                              <xsl:value-of select="string(.)" />
                            </span>
                          </xsl:for-each>
                        </td>
                        <td style="width:364px; " align="center">
                          <xsl:if test="@odsetki=0">
                            <xsl:for-each select="@odsetki">
                              <span>
                                <xsl:text>bez odsetek</xsl:text>
                              </span>
                            </xsl:for-each>
                          </xsl:if>
                          <xsl:if test="@odsetki=1">
                            <xsl:for-each select="@odsetki">
                              <span>
                                <xsl:text>z odsetkami </xsl:text>
                                <br />
                              </span>
                            </xsl:for-each>
                          </xsl:if>
                          <xsl:for-each select="curr:Odsetki">
                            <xsl:for-each select="curr:OkresOdsetkowy[(@czyUstawowe&gt;3) ]">
                              <xsl:choose>
                                <xsl:when test="@czyUstawowe=4">
                                  <span>
                                    <xsl:text>umownymi </xsl:text>
                                    <xsl:value-of select="@stopa" />
                                    <xsl:text> % </xsl:text>
                                    <xsl:call-template name="okresTemplate" />
                                    <xsl:text> ale nie więcej niż w wysokości odsetek maksymalnych </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=5">
                                  <span>
                                    <xsl:text>umownymi w wysokości czterokrotności stopy lombardowej NBP rocznie ale nie więcej niż w wysokości odsetek maksymalnych</xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                  <span>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=6">
                                  <span>
                                    <xsl:text>umownymi w wysokości czterokrotności stopy lombardowej NBP rocznie </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:text> do dnia 31 grudnia 2015 roku i odsetkami umownymi w wysokości czterokrotności stopy lombardowej NBP rocznie ale nie więcej niż w wysokości odsetek maksymalnych od dnia 1 stycznia 2016 roku </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=7">
                                  <span>
                                    <xsl:text>umownymi w wysokości odsetek maksymalnych </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=8">
                                  <span>
                                    <xsl:text>ustawowymi za opóźnienie </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=9">
                                  <span>
                                    <xsl:text>ustawowymi </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:text> do dnia 31 grudnia 2015 roku i odsetkami ustawowymi za opóźnienie od dnia 1 stycznia 2016 roku</xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=10">
                                  <span>
                                    <xsl:text>umownymi </xsl:text>
                                    <xsl:value-of select="@stopa" />
                                    <xsl:text> % </xsl:text>
                                    <xsl:call-template name="okresTemplate" />
                                    <xsl:text>  ale nie więcej niż w wysokości odsetek maksymalnych za opóźnienie </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=11">
                                  <span>
                                    <xsl:text>umownymi w wysokości odsetek maksymalnych za opóźnienie </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=12">
                                  <span>
                                    <xsl:text>umownymi w wysokości czterokrotności stopy lombardowej NBP rocznie </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:text> do dnia 31 grudnia 2015 roku i odsetkami umownymi w wysokości czterokrotności stopy lombardowej NBP rocznie ale nie więcej niż w wysokości odsetek maksymalnych za opóźnienie od dnia 1 stycznia 2016 roku</xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=13">
                                  <span>
                                    <xsl:text>umownymi w wysokości czterokrotności stopy lombardowej NBP rocznie ale nie więcej niż w wysokości odsetek maksymalnych za opóźnienie </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=14">
                                  <span>
                                    <xsl:text>umownymi  </xsl:text>
                                    <xsl:value-of select="@stopa" />
                                    <xsl:text> % </xsl:text>
                                    <xsl:call-template name="okresTemplate" />
                                    <xsl:text> ale nie więcej niż w wysokości czterokrotności stopy lombardowej NBP rocznie </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:text> do dnia 31 grudnia 2015 roku i odsetkami umownymi   </xsl:text>
                                    <xsl:value-of select="@stopa" />
                                    <xsl:text> % </xsl:text>
                                    <xsl:call-template name="okresTemplate" />
                                    <xsl:text> ale nie więcej niż w wysokości odsetek maksymalnych za opóźnienie od dnia 1 stycznia 2016 roku</xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=15">
                                  <span>
                                    <xsl:text>ustawowymi za opóźnienie w transakcjach handlowych </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=16">
                                  <span>
                                    <xsl:text>ustawowymi </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:text> do dnia 31 grudnia 2015 roku i odsetkami ustawowymi za opóźnienie w transakcjach handlowych od dnia 1 stycznia 2016 roku</xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=17">
                                  <span>
                                    <xsl:text>w wysokości odsetek za zwłokę określanej na podstawie art. 56 § 1 ustawy z dnia 29 sierpnia 1997 r. - Ordynacja podatkowa </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:text> do dnia 31 grudnia 2015 roku i odsetkami ustawowymi za opóźnienie w transakcjach handlowych od dnia 1 stycznia 2016 roku</xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=18">
                                  <span>
                                    <xsl:value-of select="curr:Opis" />
                                  </span>
                                </xsl:when>
                              </xsl:choose>
                              <span>
                                <xsl:text> </xsl:text>
                              </span>
                              <xsl:if test="number(translate(translate(string(@kwota),',','.'),' ',''))!=0 and number(translate(translate(string(@kwota),',','.'),' ',''))!=../../@wartosc">
                                <xsl:for-each select="@kwota">
                                  <span>
                                    <xsl:text> od kwoty </xsl:text>
                                  </span>
                                  <span>
                                    <xsl:value-of select="format-number(number(translate(translate(string(.), ' ',''),',','.')), '### ##0,00', 'european')" />
                                  </span>
                                </xsl:for-each>
                                <span>
                                  <xsl:text> </xsl:text>
                                </span>
                                <span>
                                  <xsl:value-of select="../../@waluta" />
                                </span>
                              </xsl:if>
                              <span>
                                <xsl:text> </xsl:text>
                              </span>
                            </xsl:for-each>
                            <xsl:for-each select="curr:OkresOdsetkowy[(@czyUstawowe=0 or @czyUstawowe=3) ]">
                              <xsl:choose>
                                <xsl:when test="@czyUstawowe=0">
                                  <span>
                                    <xsl:text>ustawowymi</xsl:text>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=3">
                                  <span>
                                    <xsl:text>umownymi w wysokości czterokrotności stopy lombardowej NBP</xsl:text>
                                  </span>
                                </xsl:when>
                              </xsl:choose>
                              <span>
                                <xsl:text> </xsl:text>
                              </span>
                              <xsl:choose>
                                <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                  <span>
                                    <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                  </span>
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:for-each select="@dataOd">
                                    <span>
                                      <xsl:text> od </xsl:text>
                                    </span>
                                    <span>
                                      <xsl:value-of select="string(.)" />
                                    </span>
                                  </xsl:for-each>
                                </xsl:otherwise>
                              </xsl:choose>
                              <xsl:choose>
                                <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                  <span>
                                    <xsl:text> do dnia zapłaty</xsl:text>
                                  </span>
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:for-each select="@dataDo">
                                    <span>
                                      <xsl:text> do </xsl:text>
                                    </span>
                                    <span>
                                      <xsl:value-of select="string(.)" />
                                    </span>
                                  </xsl:for-each>
                                </xsl:otherwise>
                              </xsl:choose>
                              <xsl:if test="number(translate(translate(string(@kwota),',','.'),' ',''))!=0 and number(translate(translate(string(@kwota),',','.'),' ',''))!=../../@wartosc">
                                <xsl:for-each select="@kwota">
                                  <span>
                                    <xsl:text> od kwoty </xsl:text>
                                  </span>
                                  <span>
                                    <xsl:value-of select="format-number(number(translate(translate(string(.), ' ',''),',','.')), '### ##0,00', 'european')" />
                                  </span>
                                </xsl:for-each>
                                <span>
                                  <xsl:text> </xsl:text>
                                </span>
                                <span>
                                  <xsl:value-of select="../../@waluta" />
                                </span>
                                <span>
                                  <xsl:text> </xsl:text>
                                </span>
                              </xsl:if>
                            </xsl:for-each>
                            <xsl:for-each select="curr:OkresOdsetkowy[(@czyUstawowe=1 or @czyUstawowe=2) and name(@dataDo)]">
                              <span>
                                <xsl:text>umownymi </xsl:text>
                              </span>
                              <xsl:if test="number(translate(translate(string(@kwota),',','.'),' ',''))!=0 and number(translate(translate(string(@kwota),',','.'),' ',''))!=../../@wartosc">
                                <xsl:for-each select="@kwota">
                                  <span>
                                    <xsl:text> od kwoty </xsl:text>
                                  </span>
                                  <span>
                                    <xsl:value-of select="format-number(number(translate(translate(string(.), ' ',''),',','.')), '### ##0,00', 'european')" />
                                  </span>
                                </xsl:for-each>
                                <span>
                                  <xsl:text> </xsl:text>
                                </span>
                                <span>
                                  <xsl:value-of select="../../@waluta" />
                                </span>
                                <span>
                                  <xsl:text> </xsl:text>
                                </span>
                              </xsl:if>
                              <xsl:for-each select="@stopa">
                                <span>
                                  <xsl:text> </xsl:text>
                                </span>
                                <span>
                                  <xsl:value-of select="string(.)" />
                                </span>
                                <span>
                                  <xsl:text> %</xsl:text>
                                </span>
                              </xsl:for-each>
                              <span>
                                <xsl:text> </xsl:text>
                              </span>
                              <xsl:if test="@okres=0">
                                <xsl:for-each select="@okres">
                                  <span>
                                    <xsl:text> rocznie </xsl:text>
                                  </span>
                                </xsl:for-each>
                              </xsl:if>
                              <xsl:if test="@okres=1">
                                <xsl:for-each select="@okres">
                                  <span>
                                    <xsl:text> kwartalnie </xsl:text>
                                  </span>
                                </xsl:for-each>
                              </xsl:if>
                              <xsl:if test="@okres=2">
                                <xsl:for-each select="@okres">
                                  <span>
                                    <xsl:text> miesięcznie</xsl:text>
                                  </span>
                                </xsl:for-each>
                              </xsl:if>
                              <xsl:if test="@okres=3">
                                <xsl:for-each select="@okres">
                                  <span>
                                    <xsl:text> tygodniowo</xsl:text>
                                  </span>
                                </xsl:for-each>
                              </xsl:if>
                              <xsl:if test="@okres=4">
                                <xsl:for-each select="@okres">
                                  <span>
                                    <xsl:text> dziennie</xsl:text>
                                  </span>
                                </xsl:for-each>
                              </xsl:if>
                              <xsl:choose>
                                <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                  <span>
                                    <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                  </span>
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:for-each select="@dataOd">
                                    <span>
                                      <xsl:text> od </xsl:text>
                                    </span>
                                    <span>
                                      <xsl:value-of select="string(.)" />
                                    </span>
                                  </xsl:for-each>
                                </xsl:otherwise>
                              </xsl:choose>
                              <xsl:for-each select="@dataDo">
                                <br />
                                <span>
                                  <xsl:text> do </xsl:text>
                                </span>
                                <span>
                                  <xsl:value-of select="string(.)" />
                                </span>
                              </xsl:for-each>
                              <xsl:if test="@czyUstawowe=2">
                                <span>
                                  <xsl:text> ale nie więcej niż czterokrotność stopy lombardowej NBP</xsl:text>
                                </span>
                              </xsl:if>
                            </xsl:for-each>
                            <xsl:for-each select="curr:OkresOdsetkowy[(@czyUstawowe=1 or @czyUstawowe=2) and (not(name(@dataDo)) or name(@dataDo)='')]">
                              <span>
                                <xsl:text>umownymi </xsl:text>
                              </span>
                              <xsl:if test="number(translate(translate(string(@kwota),',','.'),' ',''))!=0 and number(translate(translate(string(@kwota),',','.'),' ',''))!=../../@wartosc">
                                <xsl:for-each select="@kwota">
                                  <span>
                                    <xsl:text> od kwoty </xsl:text>
                                  </span>
                                  <span>
                                    <xsl:value-of select="format-number(number(translate(translate(string(.), ' ',''),',','.')), '### ##0,00', 'european')" />
                                  </span>
                                </xsl:for-each>
                                <span>
                                  <xsl:text> </xsl:text>
                                </span>
                                <span>
                                  <xsl:value-of select="../../@waluta" />
                                </span>
                              </xsl:if>
                              <span>
                                <xsl:text>  </xsl:text>
                              </span>
                              <xsl:for-each select="@stopa">
                                <span>
                                  <xsl:value-of select="string(.)" />
                                </span>
                                <span>
                                  <xsl:text> %</xsl:text>
                                </span>
                              </xsl:for-each>
                              <xsl:if test="@okres=0">
                                <xsl:for-each select="@okres">
                                  <span>
                                    <xsl:text> rocznie </xsl:text>
                                  </span>
                                </xsl:for-each>
                              </xsl:if>
                              <xsl:if test="@okres=1">
                                <xsl:for-each select="@okres">
                                  <span>
                                    <xsl:text> kwartalnie </xsl:text>
                                  </span>
                                </xsl:for-each>
                              </xsl:if>
                              <xsl:if test="@okres=2">
                                <xsl:for-each select="@okres">
                                  <span>
                                    <xsl:text> miesięcznie</xsl:text>
                                  </span>
                                </xsl:for-each>
                              </xsl:if>
                              <xsl:if test="@okres=3">
                                <xsl:for-each select="@okres">
                                  <span>
                                    <xsl:text> tygodniowo</xsl:text>
                                  </span>
                                </xsl:for-each>
                              </xsl:if>
                              <xsl:if test="@okres=4">
                                <xsl:for-each select="@okres">
                                  <span>
                                    <xsl:text> dziennie</xsl:text>
                                  </span>
                                </xsl:for-each>
                              </xsl:if>
                              <span>
                                <xsl:text> </xsl:text>
                              </span>
                              <xsl:choose>
                                <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                  <span>
                                    <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                  </span>
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:for-each select="@dataOd">
                                    <span>
                                      <xsl:text> od </xsl:text>
                                    </span>
                                    <span>
                                      <xsl:value-of select="string(.)" />
                                    </span>
                                  </xsl:for-each>
                                </xsl:otherwise>
                              </xsl:choose>
                              <span>
                                <xsl:text> do dnia zapłaty </xsl:text>
                              </span>
                              <xsl:if test="@czyUstawowe=2">
                                <span>
                                  <xsl:text> ale nie więcej niż czterokrotność stopy lombardowej NBP </xsl:text>
                                </span>
                              </xsl:if>
                            </xsl:for-each>
                          </xsl:for-each>
                        </td>
                        <td>
                          <xsl:for-each select="curr:Dowody">
                            <xsl:for-each select="curr:Dowod">
                              <p>
                                <span>
                                  <xsl:text> dowód nr </xsl:text>
                                </span>
                                <xsl:apply-templates />
                              </p>
                            </xsl:for-each>
                          </xsl:for-each>
                        </td>
                        <xsl:choose>
                          <xsl:when test="@dataWymagalnosci and $ukryjDatWymagalnosci != 'true'">
                            <td>
                              <xsl:for-each select="@dataWymagalnosci">
                                <span>
                                  <xsl:value-of select="string(.)" />
                                </span>
                              </xsl:for-each>
                            </td>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:if test="count( ../curr:Roszczenie[@dataWymagalnosci] )&gt;0  and $ukryjDatWymagalnosci != 'true'">
                              <td>
                                <span />
                              </td>
                            </xsl:if>
                          </xsl:otherwise>
                        </xsl:choose>
                      </tr>
                    </xsl:for-each>
                  </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:for-each select="curr:ListaRoszczen">
                    <xsl:for-each select="curr:Roszczenie">
                      <tr>
                        <td align="center">
                          <xsl:for-each select="@numer">
                            <span>
                              <xsl:value-of select="string(.)" />
                            </span>
                          </xsl:for-each>
                        </td>
                        <td align="right">
                          <xsl:for-each select="@wartosc">
                            <span>
                              <xsl:value-of select="format-number(number(translate(translate(string(.), ' ',''),',','.')), '### ##0,00', 'european')" />
                            </span>
                          </xsl:for-each>
                        </td>
                        <td style="width:58px; " align="right">
                          <xsl:for-each select="@waluta">
                            <span>
                              <xsl:value-of select="string(.)" />
                            </span>
                          </xsl:for-each>
                        </td>
                        <td style="width:1px; ">
                          <xsl:if test="(@solidarnie=0 or (@solidarnie=1 and (string-length( @opis )=0 or name(@opis)=''))) and (count( ../../curr:ListaPowodow/curr:Powod )+count(../../curr:ListaPozwanych/curr:Pozwany)&gt;2)">
                            <span>
                              <xsl:text>solidarnie</xsl:text>
                            </span>
                          </xsl:if>
                          <xsl:if test="@solidarnie=4">
                            <span>
                              <xsl:text>in solidum</xsl:text>
                            </span>
                          </xsl:if>
                          <xsl:if test="@solidarnie=2">
                            <span>
                              <xsl:text>solidarność bierna</xsl:text>
                            </span>
                          </xsl:if>
                          <xsl:if test="@solidarnie=3">
                            <span>
                              <xsl:text>solidarność czynna</xsl:text>
                            </span>
                          </xsl:if>
                          <br />
                          <xsl:for-each select="@opis">
                            <span>
                              <xsl:value-of select="string(.)" />
                            </span>
                          </xsl:for-each>
                        </td>
                        <td style="width:364px; " align="center">
                          <xsl:if test="@odsetki=0">
                            <xsl:for-each select="@odsetki">
                              <span>
                                <xsl:text>bez odsetek</xsl:text>
                              </span>
                            </xsl:for-each>
                          </xsl:if>
                          <xsl:if test="@odsetki=1">
                            <xsl:for-each select="@odsetki">
                              <span>
                                <xsl:text>z odsetkami </xsl:text>
                              </span>
                            </xsl:for-each>
                          </xsl:if>
                          <xsl:for-each select="curr:Odsetki">
                            <xsl:for-each select="curr:OkresOdsetkowy[(@czyUstawowe&gt;3) ]">
                              <xsl:choose>
                                <xsl:when test="@czyUstawowe=4">
                                  <span>
                                    <xsl:text>umownymi </xsl:text>
                                    <xsl:value-of select="@stopa" />
                                    <xsl:text> % </xsl:text>
                                    <xsl:call-template name="okresTemplate" />
                                    <xsl:text> ale nie więcej niż w wysokości odsetek maksymalnych </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=5">
                                  <span>
                                    <xsl:text>umownymi w wysokości czterokrotności stopy lombardowej NBP rocznie ale nie więcej niż w wysokości odsetek maksymalnych</xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                  <span>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=6">
                                  <span>
                                    <xsl:text>umownymi w wysokości czterokrotności stopy lombardowej NBP rocznie </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:text> do dnia 31 grudnia 2015 roku i odsetkami umownymi w wysokości czterokrotności stopy lombardowej NBP rocznie ale nie więcej niż w wysokości odsetek maksymalnych od dnia 1 stycznia 2016 roku </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=7">
                                  <span>
                                    <xsl:text>umownymi w wysokości odsetek maksymalnych </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=8">
                                  <span>
                                    <xsl:text>ustawowymi za opóźnienie </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=9">
                                  <span>
                                    <xsl:text>ustawowymi </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:text> od dnia 31 grudnia 2015 roku i odsetkami ustawowymi za opóźnienie od dnia 1 stycznia 2016 roku</xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=10">
                                  <span>
                                    <xsl:text>umownymi </xsl:text>
                                    <xsl:value-of select="@stopa" />
                                    <xsl:text> % </xsl:text>
                                    <xsl:call-template name="okresTemplate" />
                                    <xsl:text>  ale nie więcej niż w wysokości odsetek maksymalnych za opóźnienie </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=11">
                                  <span>
                                    <xsl:text>umownymi w wysokości odsetek maksymalnych za opóźnienie </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=12">
                                  <span>
                                    <xsl:text>umownymi w wysokości czterokrotności stopy lombardowej NBP rocznie </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:text> do dnia 31 grudnia 2015 roku i odsetkami umownymi w wysokości czterokrotności stopy lombardowej NBP rocznie ale nie więcej niż w wysokości odsetek maksymalnych za opóźnienie od dnia 1 stycznia 2016 roku</xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=13">
                                  <span>
                                    <xsl:text>umownymi w wysokości czterokrotności stopy lombardowej NBP rocznie ale nie więcej niż w wysokości odsetek maksymalnych za opóźnienie </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=14">
                                  <span>
                                    <xsl:text>umownymi  </xsl:text>
                                    <xsl:value-of select="@stopa" />
                                    <xsl:text> % </xsl:text>
                                    <xsl:call-template name="okresTemplate" />
                                    <xsl:text> ale nie więcej niż w wysokości czterokrotności stopy lombardowej NBP rocznie </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:text> do dnia 31 grudnia 2015 roku i odsetkami umownymi   </xsl:text>
                                    <xsl:value-of select="@stopa" />
                                    <xsl:text> % </xsl:text>
                                    <xsl:call-template name="okresTemplate" />
                                    <xsl:text> ale nie więcej niż w wysokości odsetek maksymalnych za opóźnienie od dnia 1 stycznia 2016 roku</xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=15">
                                  <span>
                                    <xsl:text>ustawowymi za opóźnienie w transakcjach handlowych </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=16">
                                  <span>
                                    <xsl:text>ustawowymi </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:text> do dnia 31 grudnia 2015 roku i odsetkami ustawowymi za opóźnienie w transakcjach handlowych od dnia 1 stycznia 2016 roku</xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=17">
                                  <span>
                                    <xsl:text>w wysokości odsetek za zwłokę określanej na podstawie art. 56 § 1 ustawy z dnia 29 sierpnia 1997 r. - Ordynacja podatkowa </xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                        <span>
                                          <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataOd">
                                          <span>
                                            <xsl:text> od </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:text> do dnia 31 grudnia 2015 roku i odsetkami ustawowymi za opóźnienie w transakcjach handlowych od dnia 1 stycznia 2016 roku</xsl:text>
                                    <xsl:choose>
                                      <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                        <span>
                                          <xsl:text> do dnia zapłaty</xsl:text>
                                        </span>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:for-each select="@dataDo">
                                          <span>
                                            <xsl:text> do </xsl:text>
                                          </span>
                                          <span>
                                            <xsl:value-of select="string(.)" />
                                          </span>
                                        </xsl:for-each>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=18">
                                  <span>
                                    <xsl:value-of select="curr:Opis" />
                                  </span>
                                </xsl:when>
                              </xsl:choose>
                              <span>
                                <xsl:text> </xsl:text>
                              </span>
                              <xsl:if test="number(translate(translate(string(@kwota),',','.'),' ',''))!=0 and number(translate(translate(string(@kwota),',','.'),' ',''))!=../../@wartosc">
                                <xsl:for-each select="@kwota">
                                  <span>
                                    <xsl:text> od kwoty </xsl:text>
                                  </span>
                                  <span>
                                    <xsl:value-of select="format-number(number(translate(translate(string(.), ' ',''),',','.')), '### ###,00', 'european')" />
                                  </span>
                                </xsl:for-each>
                                <span>
                                  <xsl:text> </xsl:text>
                                </span>
                                <span>
                                  <xsl:value-of select="../../@waluta" />
                                </span>
                              </xsl:if>
                              <span>
                                <xsl:text> </xsl:text>
                              </span>
                            </xsl:for-each>
                            <xsl:for-each select="curr:OkresOdsetkowy[(@czyUstawowe=0 or @czyUstawowe=3) and name(@dataDo)]">
                              <br />
                              <xsl:choose>
                                <xsl:when test="@czyUstawowe=0">
                                  <span>
                                    <xsl:text>ustawowymi</xsl:text>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=3">
                                  <span>
                                    <xsl:text>umownymi w wysokości czterokrotności stopy lombardowej NBP</xsl:text>
                                  </span>
                                </xsl:when>
                              </xsl:choose>
                              <span>
                                <xsl:text> </xsl:text>
                              </span>
                              <xsl:choose>
                                <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                  <span>
                                    <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                  </span>
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:for-each select="@dataOd">
                                    <span>
                                      <xsl:text> od </xsl:text>
                                    </span>
                                    <span>
                                      <xsl:value-of select="string(.)" />
                                    </span>
                                  </xsl:for-each>
                                </xsl:otherwise>
                              </xsl:choose>
                              <span>
                                <xsl:text> </xsl:text>
                              </span>
                              <xsl:for-each select="@dataDo">
                                <span>
                                  <xsl:text> do </xsl:text>
                                </span>
                                <span>
                                  <xsl:value-of select="string(.)" />
                                </span>
                              </xsl:for-each>
                              <xsl:if test="number(translate(translate(string(@kwota),',','.'),' ',''))!=0 and number(translate(translate(string(@kwota),',','.'),' ',''))!=../../@wartosc">
                                <xsl:for-each select="@kwota">
                                  <span>
                                    <xsl:text> od kwoty </xsl:text>
                                  </span>
                                  <span>
                                    <xsl:value-of select="format-number(number(translate(translate(string(.), ' ',''),',','.')), '### ##0,00', 'european')" />
                                  </span>
                                </xsl:for-each>
                                <span>
                                  <xsl:text> </xsl:text>
                                </span>
                                <span>
                                  <xsl:value-of select="../../@waluta" />
                                </span>
                              </xsl:if>
                              <span>
                                <xsl:text> </xsl:text>
                              </span>
                            </xsl:for-each>
                            <xsl:for-each select="curr:OkresOdsetkowy[(@czyUstawowe=0 or @czyUstawowe=3) and (not(name(@dataDo)) or name(@dataDo)='')]">
                              <br />
                              <xsl:choose>
                                <xsl:when test="@czyUstawowe=0">
                                  <span>
                                    <xsl:text>ustawowymi</xsl:text>
                                  </span>
                                </xsl:when>
                                <xsl:when test="@czyUstawowe=3">
                                  <span>
                                    <xsl:text>umownymi w wysokości czterokrotności stopy lombardowej NBP</xsl:text>
                                  </span>
                                </xsl:when>
                              </xsl:choose>
                              <span>
                                <xsl:text> </xsl:text>
                              </span>
                              <xsl:choose>
                                <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                  <span>
                                    <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                  </span>
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:for-each select="@dataOd">
                                    <span>
                                      <xsl:text> od </xsl:text>
                                    </span>
                                    <span>
                                      <xsl:value-of select="string(.)" />
                                    </span>
                                  </xsl:for-each>
                                </xsl:otherwise>
                              </xsl:choose>
                              <span>
                                <xsl:text> do dnia zapłaty</xsl:text>
                              </span>
                              <xsl:if test="number(translate(translate(string(@kwota),',','.'),' ',''))!=0 and number(translate(translate(string(@kwota),',','.'),' ',''))!=../../@wartosc">
                                <xsl:for-each select="@kwota">
                                  <span>
                                    <xsl:text> od kwoty </xsl:text>
                                  </span>
                                  <span>
                                    <xsl:value-of select="format-number(number(translate(translate(string(.), ' ',''),',','.')), '### ##0,00', 'european')" />
                                  </span>
                                </xsl:for-each>
                                <span>
                                  <xsl:text> </xsl:text>
                                </span>
                                <span>
                                  <xsl:value-of select="../../@waluta" />
                                </span>
                                <span>
                                  <xsl:text> </xsl:text>
                                </span>
                              </xsl:if>
                            </xsl:for-each>
                            <xsl:for-each select="curr:OkresOdsetkowy[(@czyUstawowe=1 or @czyUstawowe=2) and name(@dataDo)]">
                              <br />
                              <span>
                                <xsl:text>umownymi </xsl:text>
                              </span>
                              <xsl:if test="number(translate(translate(string(@kwota),',','.'),' ',''))!=0 and number(translate(translate(string(@kwota),',','.'),' ',''))!=../../@wartosc">
                                <xsl:for-each select="@kwota">
                                  <span>
                                    <xsl:text> od kwoty </xsl:text>
                                  </span>
                                  <span>
                                    <xsl:value-of select="format-number(number(translate(translate(string(.), ' ',''),',','.')), '### ##0,00', 'european')" />
                                  </span>
                                </xsl:for-each>
                                <span>
                                  <xsl:text> </xsl:text>
                                </span>
                                <span>
                                  <xsl:value-of select="../../@waluta" />
                                </span>
                                <span>
                                  <xsl:text> </xsl:text>
                                </span>
                              </xsl:if>
                              <xsl:for-each select="@stopa">
                                <span>
                                  <xsl:text> </xsl:text>
                                </span>
                                <span>
                                  <xsl:value-of select="string(.)" />
                                </span>
                                <span>
                                  <xsl:text> %</xsl:text>
                                </span>
                              </xsl:for-each>
                              <span>
                                <xsl:text> </xsl:text>
                              </span>
                              <xsl:if test="@okres=0">
                                <xsl:for-each select="@okres">
                                  <span>
                                    <xsl:text> rocznie </xsl:text>
                                  </span>
                                </xsl:for-each>
                              </xsl:if>
                              <xsl:if test="@okres=1">
                                <xsl:for-each select="@okres">
                                  <span>
                                    <xsl:text> kwartalnie </xsl:text>
                                  </span>
                                </xsl:for-each>
                              </xsl:if>
                              <xsl:if test="@okres=2">
                                <xsl:for-each select="@okres">
                                  <span>
                                    <xsl:text> miesięcznie</xsl:text>
                                  </span>
                                </xsl:for-each>
                              </xsl:if>
                              <xsl:if test="@okres=3">
                                <xsl:for-each select="@okres">
                                  <span>
                                    <xsl:text> tygodniowo</xsl:text>
                                  </span>
                                </xsl:for-each>
                              </xsl:if>
                              <xsl:if test="@okres=4">
                                <xsl:for-each select="@okres">
                                  <span>
                                    <xsl:text> dziennie</xsl:text>
                                  </span>
                                </xsl:for-each>
                              </xsl:if>
                              <xsl:choose>
                                <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                  <span>
                                    <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                  </span>
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:for-each select="@dataOd">
                                    <span>
                                      <xsl:text> od </xsl:text>
                                    </span>
                                    <span>
                                      <xsl:value-of select="string(.)" />
                                    </span>
                                  </xsl:for-each>
                                </xsl:otherwise>
                              </xsl:choose>
                              <xsl:for-each select="@dataDo">
                                <br />
                                <span>
                                  <xsl:text> do </xsl:text>
                                </span>
                                <span>
                                  <xsl:value-of select="string(.)" />
                                </span>
                              </xsl:for-each>
                              <xsl:if test="@czyUstawowe=2">
                                <span>
                                  <xsl:text> ale nie więcej niż czterokrotność stopy lombardowej NBP</xsl:text>
                                </span>
                              </xsl:if>
                            </xsl:for-each>
                            <xsl:for-each select="curr:OkresOdsetkowy[(@czyUstawowe=1 or @czyUstawowe=2) and (not(name(@dataDo)) or name(@dataDo)='')]">
                              <br />
                              <span>
                                <xsl:text>umownymi </xsl:text>
                              </span>
                              <xsl:if test="number(translate(translate(string(@kwota),',','.'),' ',''))!=0 and number(translate(translate(string(@kwota),',','.'),' ',''))!=../../@wartosc">
                                <xsl:for-each select="@kwota">
                                  <span>
                                    <xsl:text> od kwoty </xsl:text>
                                  </span>
                                  <span>
                                    <xsl:value-of select="format-number(number(translate(translate(string(.), ' ',''),',','.')), '### ##0,00', 'european')" />
                                  </span>
                                </xsl:for-each>
                                <span>
                                  <xsl:text> </xsl:text>
                                </span>
                                <span>
                                  <xsl:value-of select="../../@waluta" />
                                </span>
                              </xsl:if>
                              <span>
                                <xsl:text>  </xsl:text>
                              </span>
                              <xsl:for-each select="@stopa">
                                <span>
                                  <xsl:value-of select="string(.)" />
                                </span>
                                <span>
                                  <xsl:text> %</xsl:text>
                                </span>
                              </xsl:for-each>
                              <xsl:if test="@okres=0">
                                <xsl:for-each select="@okres">
                                  <span>
                                    <xsl:text> rocznie </xsl:text>
                                  </span>
                                </xsl:for-each>
                              </xsl:if>
                              <xsl:if test="@okres=1">
                                <xsl:for-each select="@okres">
                                  <span>
                                    <xsl:text> kwartalnie </xsl:text>
                                  </span>
                                </xsl:for-each>
                              </xsl:if>
                              <xsl:if test="@okres=2">
                                <xsl:for-each select="@okres">
                                  <span>
                                    <xsl:text> miesięcznie</xsl:text>
                                  </span>
                                </xsl:for-each>
                              </xsl:if>
                              <xsl:if test="@okres=3">
                                <xsl:for-each select="@okres">
                                  <span>
                                    <xsl:text> tygodniowo</xsl:text>
                                  </span>
                                </xsl:for-each>
                              </xsl:if>
                              <xsl:if test="@okres=4">
                                <xsl:for-each select="@okres">
                                  <span>
                                    <xsl:text> dziennie</xsl:text>
                                  </span>
                                </xsl:for-each>
                              </xsl:if>
                              <span>
                                <xsl:text> </xsl:text>
                              </span>
                              <xsl:choose>
                                <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                  <span>
                                    <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                  </span>
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:for-each select="@dataOd">
                                    <span>
                                      <xsl:text> od </xsl:text>
                                    </span>
                                    <span>
                                      <xsl:value-of select="string(.)" />
                                    </span>
                                  </xsl:for-each>
                                </xsl:otherwise>
                              </xsl:choose>
                              <span>
                                <xsl:text> do dnia zapłaty </xsl:text>
                              </span>
                              <xsl:if test="@czyUstawowe=2">
                                <span>
                                  <xsl:text> ale nie więcej niż czterokrotność stopy lombardowej NBP </xsl:text>
                                </span>
                              </xsl:if>
                            </xsl:for-each>
                          </xsl:for-each>
                        </td>
                        <td>
                          <xsl:for-each select="curr:Dowody">
                            <xsl:for-each select="curr:Dowod">
                              <p>
                                <span>
                                  <xsl:text> dowód nr </xsl:text>
                                </span>
                                <xsl:apply-templates />
                              </p>
                            </xsl:for-each>
                          </xsl:for-each>
                        </td>
                        <xsl:choose>
                          <xsl:when test="@dataWymagalnosci and $ukryjDatWymagalnosci != 'true'">
                            <td>
                              <xsl:for-each select="@dataWymagalnosci">
                                <span>
                                  <xsl:value-of select="string(.)" />
                                </span>
                              </xsl:for-each>
                            </td>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:if test="count( ../curr:Roszczenie[@dataWymagalnosci] )&gt;0  and $ukryjDatWymagalnosci != 'true'">
                              <td>
                                <span />
                              </td>
                            </xsl:if>
                          </xsl:otherwise>
                        </xsl:choose>
                      </tr>
                    </xsl:for-each>
                  </xsl:for-each>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </tbody>
        </table>
      </div>
      <div>
        <xsl:for-each select="curr:PozewEPU">
          <xsl:for-each select="curr:InneRoszczenia">
            <xsl:apply-templates />
          </xsl:for-each>
        </xsl:for-each>
      </div>
      <xsl:if test="curr:PozewEPU/curr:OplataSadowa/@zasadzenie=1 or curr:PozewEPU/curr:KosztyZastepstwa/@zasadzenie=1 or curr:PozewEPU/curr:InneKoszty/@zasadzenie=1">
        <div>
          <span>
            <xsl:text>oraz</xsl:text>
          </span>
        </div>
      </xsl:if>
      <div>
        <xsl:for-each select="curr:PozewEPU">
          <xsl:for-each select="curr:OplataSadowa[@zasadzenie=1]">
            <xsl:for-each select="@wartosc">
              <span>
                <xsl:text>zasądzenie zwrotu kosztów sądowych </xsl:text>
              </span>
              <span>
                <xsl:value-of select="format-number(number(translate(translate(string(.), ' ',''),',','.')), '### ##0,00', 'european')" />
              </span>
              <span>
                <xsl:text> zł z odsetkami ustawowymi za opóźnienie</xsl:text>
              </span>
            </xsl:for-each>
          </xsl:for-each>
          <xsl:for-each select="curr:KosztyZastepstwa[@zasadzenie=1 and @wartosc&gt;0]">
            <br />
            <xsl:for-each select="@wartosc">
              <span>
                <xsl:text>zasądzenie zwrotu kosztów zastępstwa procesowego </xsl:text>
              </span>
              <span>
                <xsl:value-of select="format-number(number(translate(translate(string(.), ' ',''),',','.')), '### ##0,00', 'european')" />
              </span>
              <span>
                <xsl:text> zł z odsetkami ustawowymi za opóźnienie</xsl:text>
              </span>
            </xsl:for-each>
          </xsl:for-each>
          <xsl:for-each select="curr:KosztyZastepstwa[@zasadzenie=1 and @wgNorm=1 and @wartosc=0]">
            <br />
            <span>
              <xsl:text>zasądzenie zwrotu kosztów zastępstwa procesowego wg norm przepisanych</xsl:text>
            </span>
          </xsl:for-each>
        </xsl:for-each>
      </div>
      <div>
        <xsl:for-each select="curr:PozewEPU">
          <xsl:for-each select="curr:InneKoszty[@zasadzenie=1]">
            <xsl:for-each select="@wartosc">
              <span>
                <xsl:text>zasądzenie zwrotu innych kosztów </xsl:text>
              </span>
              <span>
                <xsl:value-of select="format-number(number(translate(translate(string(.), ' ',''),',','.')), '### ##0,00', 'european')" />
              </span>
              <span>
                <xsl:text> zł z odsetkami ustawowymi za opóźnienie</xsl:text>
              </span>
            </xsl:for-each>
            <xsl:for-each select="@opis">
              <span>
                <xsl:text> (</xsl:text>
              </span>
              <span>
                <xsl:value-of select="string(.)" />
              </span>
              <span>
                <xsl:text>)</xsl:text>
              </span>
            </xsl:for-each>
          </xsl:for-each>
        </xsl:for-each>
      </div>
      <xsl:if test="curr:PozewEPU/curr:OplataSadowa/@zwolnienie&gt;=1">
        <div>
          <xsl:for-each select="curr:PozewEPU">
            <xsl:for-each select="curr:PodstawaZwolnienia">
              <span>
                <xsl:text>Pozew zwolniony z kosztów sądowych </xsl:text>
              </span>
              <xsl:for-each select="@typ">
                <span>
                  <xsl:text> na podstawie  </xsl:text>
                </span>
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
              </xsl:for-each>
              <xsl:for-each select="@opis">
                <span>
                  <xsl:text> </xsl:text>
                </span>
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
              </xsl:for-each>
            </xsl:for-each>
          </xsl:for-each>
        </div>
      </xsl:if>
      <xsl:if test="curr:PozewEPU/curr:OplataSadowa/@ObnizenieKosztowOplatySadowej='true'">
        <br />
        <xsl:text> 
			Obniżenie opłaty sądowej w wypadku roszczeń wynikających z czynności bankowych, przysługujące konsumentom lub osobom fizycznym prowadzącym gospodarstwo rodzinne.
				</xsl:text>
        <br />
      </xsl:if>
      <xsl:if test="curr:PozewEPU/curr:OplataSadowa/@czyobnizplanowanieprzestrzenne='true'">
        <br />
        <xsl:text> 
			Obniżenienie kwoty opłaty sądowej  z art. 36 ustawy z dnia 27 marca 2003 r. o planowaniu i zagospodarowaniu przestrzennym (Dz. U. z 2018 r. poz. 1945 oraz z 2019 r. poz. 60, 235, 730 i 1009) .
				</xsl:text>
        <br />
      </xsl:if>
      <xsl:if test="curr:PozewEPU/curr:OplataSadowa/@czyobnizmediacja='true'">
        <br />
        <xsl:text> 
			Obniżenienie kwoty opłaty sądowej w na podstawie art. 13e ustawy o kosztach sądowych w sprawach cywilnych.
				</xsl:text>
        <br />
        <br />
      </xsl:if>
      <div align="center">
        <span style="font-weight:bold; ">
          <xsl:text>U Z A S A D N I E N I E</xsl:text>
        </span>
      </div>
      <div align="justify">
        <xsl:for-each select="curr:PozewEPU">
          <xsl:for-each select="curr:Uzasadnienie">
            <span style="font-family:Times New Roman; font-size:medium; ">
              <xsl:apply-templates />
            </span>
          </xsl:for-each>
        </xsl:for-each>
      </div>
      <div>
        <xsl:for-each select="curr:PozewEPU">
          <xsl:for-each select="curr:ListaDowodow">
            <br />
            <xsl:if test="count( curr:Dowod )&gt;0">
              <span style="text-decoration:underline; ">
                <xsl:text>Lista dowodów </xsl:text>
              </span>
            </xsl:if>
            <xsl:for-each select="curr:Dowod">
              <br />
              <xsl:for-each select="@numer">
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
                <span>
                  <xsl:text>. </xsl:text>
                </span>
              </xsl:for-each>
              <xsl:for-each select="@typDowodu">
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
              </xsl:for-each>
              <xsl:for-each select="@oznaczenie">
                <span>
                  <xsl:text> </xsl:text>
                </span>
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
              </xsl:for-each>
              <xsl:for-each select="@dataDowodu">
                <span>
                  <xsl:text> z dnia </xsl:text>
                </span>
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
              </xsl:for-each>
              <xsl:for-each select="curr:FaktStwierdzany">
                <br />
                <xsl:apply-templates />
              </xsl:for-each>
              <xsl:for-each select="curr:Opis">
                <br />
                <xsl:apply-templates />
              </xsl:for-each>
            </xsl:for-each>
          </xsl:for-each>
        </xsl:for-each>
      </div>
      <br />
      <xsl:if test="count( curr:PozewEPU/curr:ListaPodpisow/curr:Podpis )&gt;0">
        <div>
          <span style="text-decoration:underline; ">
            <xsl:text>Lista podpisów</xsl:text>
          </span>
        </div>
      </xsl:if>
      <div>
        <xsl:for-each select="curr:PozewEPU">
          <xsl:for-each select="curr:ListaPodpisow">
            <xsl:for-each select="curr:Podpis">
              <xsl:for-each select="curr:Imie">
                <br />
                <xsl:apply-templates />
              </xsl:for-each>
              <xsl:for-each select="curr:Imie2">
                <span>
                  <xsl:text> </xsl:text>
                </span>
                <xsl:apply-templates />
              </xsl:for-each>
              <xsl:for-each select="curr:Nazwisko">
                <span>
                  <xsl:text> </xsl:text>
                </span>
                <xsl:apply-templates />
              </xsl:for-each>
              <xsl:if test="contains($peselePelnomocReprezent, curr:PESEL)=false">
                <xsl:for-each select="curr:PESEL">
                  <span>
                    <xsl:text>  PESEL </xsl:text>
                  </span>
                  <xsl:apply-templates />
                </xsl:for-each>
              </xsl:if>
              <xsl:for-each select="curr:stanowisko">
                <span>
                  <xsl:text> </xsl:text>
                </span>
                <xsl:apply-templates />
              </xsl:for-each>
            </xsl:for-each>
          </xsl:for-each>
        </xsl:for-each>
      </div>
      <xsl:for-each select="curr:PozewEPU/curr:ListaPowodow/curr:Powod/curr:numerKonta">
        <div>
          <br />
          <span style="text-decoration:underline; font-weight:700">
            <xsl:text>Numer rachunku bankowego do wszelkich wpłat dokonywanych przez stronę pozwaną</xsl:text>
          </span>
          <br />
          <span>
            <xsl:value-of select="string(.)" />
          </span>
          <span style="text-decoration:underline; font-weight:700">
            <br />
            <br />na rzecz powoda<br /></span>
          <span>
            <xsl:for-each select="..">
              <xsl:for-each select="curr:OsobaFizyczna">
                <xsl:for-each select="curr:Imie">
                  <br />
                  <xsl:apply-templates />
                </xsl:for-each>
                <xsl:for-each select="curr:Imie2">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <xsl:apply-templates />
                </xsl:for-each>
                <xsl:for-each select="curr:Nazwisko">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <xsl:apply-templates />
                </xsl:for-each>
              </xsl:for-each>
              <xsl:for-each select="curr:Instytucja">
                <xsl:for-each select="curr:Nazwa">
                  <br />
                  <xsl:apply-templates />
                </xsl:for-each>
                <xsl:if test="contains( curr:Siedziba , 'z siedzibą' )=false">
                  <xsl:for-each select="curr:Siedziba">
                    <span>
                      <xsl:if test="((starts-with((.), 'W') or starts-with((.), 'F'))and (not(contains('AĄEĘIOÓUY',substring((.),2,1)) or contains('aąeęioóuy', substring((.),2,1)))))">
                        <xsl:text> z siedzibą we</xsl:text>
                      </xsl:if>
                      <xsl:if test="not(((starts-with((.), 'W') or starts-with((.), 'F')) and (not(contains('AĄEĘIOÓUY',substring((.),2,1)) or contains('aąeęioóuy', substring((.),2,1)) ) ) ))">
                        <xsl:text> z siedzibą w</xsl:text>
                      </xsl:if>
                    </span>
                  </xsl:for-each>
                </xsl:if>
                <xsl:for-each select="curr:Siedziba">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <xsl:apply-templates />
                </xsl:for-each>
              </xsl:for-each>
            </xsl:for-each>
          </span>
        </div>
      </xsl:for-each>
      <xsl:for-each select="curr:PozewEPU/curr:RachunekDoZwrotuOplat">
        <br />
        <span style="text-decoration:underline; font-weight:700">
          <xsl:text>Numer rachunku bankowego do zwrotu opłaty sądowej przez Sąd</xsl:text>
        </span>
        <br />
        <span>
          <xsl:for-each select="curr:NumerRachunkuDoZwrotuOplat">
            <xsl:apply-templates />
          </xsl:for-each>
        </span>
        <br />
        <span>
          <xsl:for-each select="curr:WlascicielRachunku">
            <xsl:apply-templates />
          </xsl:for-each>
        </span>
        <br />
      </xsl:for-each>
      <xsl:if test="contains(curr:Oswiadczenie , 'tak' )=true">
        <xsl:for-each select="/curr:PozewEPU/curr:ListaPowodow">
          <xsl:for-each select="curr:Powod">
            <xsl:if test="contains(curr:Obcokrajowiec , 'true')&gt;0">
              <br />
              <xsl:for-each select="curr:OsobaFizyczna">
                <xsl:for-each select="curr:Imie">
                  <xsl:apply-templates />
                </xsl:for-each>
                <xsl:for-each select="curr:Imie2">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <xsl:apply-templates />
                </xsl:for-each>
                <xsl:for-each select="curr:Nazwisko">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <xsl:apply-templates />
                </xsl:for-each>
              </xsl:for-each>
              <br />
              <span>
                <xsl:text>Oświadczam, że powód będący osobą fizyczną nie jest zobowiązany do posiadania oraz nie posiada numeru Powszechnego Elektronicznego Systemu Ewidencji Ludności (PESEL) i numeru identyfikacji podatkowej (NIP).</xsl:text>
              </span>
              <br />
            </xsl:if>
            <xsl:if test="contains(curr:BrakNumerowIdentyfikacyjnych , 'true')&gt;0">
              <br />
              <xsl:for-each select="curr:Instytucja">
                <xsl:for-each select="curr:Nazwa">
                  <xsl:apply-templates />
                </xsl:for-each>
                <xsl:for-each select="curr:Siedziba">
                  <span>
                    <xsl:if test="((starts-with((.), 'W') or starts-with((.), 'F'))and (not(contains('AĄEĘIOÓUY',substring((.),2,1)) or contains('aąeęioóuy', substring((.),2,1)))))">
                      <xsl:text> z siedzibą we </xsl:text>
                    </xsl:if>
                    <xsl:if test="not(((starts-with((.), 'W') or starts-with((.), 'F')) and (not(contains('AĄEĘIOÓUY',substring((.),2,1)) or contains('aąeęioóuy', substring((.),2,1)) ) ) ))">
                      <xsl:text> z siedzibą w </xsl:text>
                    </xsl:if>
                  </span>
                  <xsl:apply-templates />
                </xsl:for-each>
              </xsl:for-each>
              <br />
              <span>
                <xsl:text>Oświadczam, że powód niebędący osobą fizyczną nie ma obowiązku wpisu we właściwym rejestrze lub ewidencji i nie jest zobowiązany do posiadania numeru w Krajowym Rejestrze Sądowym, numeru w innym właściwym rejestrze, ewidencji i numeru identyfikacji podatkowej (NIP).</xsl:text>
              </span>
              <br />
            </xsl:if>
          </xsl:for-each>
        </xsl:for-each>
      </xsl:if>
      <xsl:if test="contains(curr:Oswiadczenie , 'tak' )=true">
        <xsl:for-each select="/curr:PozewEPU/curr:ListaPozwanych">
          <xsl:for-each select="curr:Pozwany">
            <xsl:if test="contains(curr:Obcokrajowiec , 'true')&gt;0">
              <br />
              <xsl:for-each select="curr:OsobaFizyczna">
                <xsl:for-each select="curr:Imie">
                  <xsl:apply-templates />
                </xsl:for-each>
                <xsl:for-each select="curr:Imie2">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <xsl:apply-templates />
                </xsl:for-each>
                <xsl:for-each select="curr:Nazwisko">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <xsl:apply-templates />
                </xsl:for-each>
              </xsl:for-each>
              <br />
              <span>
                <xsl:text>Oświadczam, że pozwany będący osobą fizyczną nie jest zobowiązany do posiadania oraz nie posiada numeru Powszechnego Elektronicznego Systemu Ewidencji Ludności (PESEL) i numeru identyfikacji podatkowej (NIP).</xsl:text>
              </span>
              <br />
            </xsl:if>
            <xsl:if test="contains(curr:BrakNumerowIdentyfikacyjnych , 'true')&gt;0">
              <br />
              <xsl:for-each select="curr:Instytucja">
                <xsl:for-each select="curr:Nazwa">
                  <xsl:apply-templates />
                </xsl:for-each>
                <xsl:for-each select="curr:Siedziba">
                  <span>
                    <xsl:if test="((starts-with((.), 'W') or starts-with((.), 'F'))and (not(contains('AĄEĘIOÓUY',substring((.),2,1)) or contains('aąeęioóuy', substring((.),2,1)))))">
                      <xsl:text> z siedzibą we </xsl:text>
                    </xsl:if>
                    <xsl:if test="not(((starts-with((.), 'W') or starts-with((.), 'F')) and (not(contains('AĄEĘIOÓUY',substring((.),2,1)) or contains('aąeęioóuy', substring((.),2,1)) ) ) ))">
                      <xsl:text> z siedzibą w </xsl:text>
                    </xsl:if>
                  </span>
                  <xsl:apply-templates />
                </xsl:for-each>
              </xsl:for-each>
              <br />
              <span>
                <xsl:text>Oświadczam, że pozwany niebędący osobą fizyczną nie ma obowiązku wpisu we właściwym rejestrze lub ewidencji i nie jest zobowiązany do posiadania numeru w Krajowym Rejestrze Sądowym, numeru w innym właściwym rejestrze, ewidencji i numeru identyfikacji podatkowej (NIP).</xsl:text>
              </span>
              <br />
            </xsl:if>
          </xsl:for-each>
        </xsl:for-each>
      </xsl:if>
      <!--wniosek o umorzenie-->
      <xsl:if test="curr:PozewEPU/@CzyWniosekUmorzBrakPodst = 1">
        <div style=" page-break-before: always;" />
        <!-- Data złożenia -->
        <div align="right">
          <xsl:for-each select="curr:PozewEPU">
            <br />
            <xsl:text> Data złożenia: </xsl:text>
            <xsl:value-of select="@dataZlozenia" />
          </xsl:for-each>
        </div>
        <!-- Osoba składająca -->
        <br />
        <span style="text-decoration:underline; ">
          <xsl:text>Osoba składająca</xsl:text>
        </span>
        <xsl:for-each select="curr:PozewEPU">
          <xsl:for-each select="curr:OsobaSkladajaca/curr:Osoba">
            <br />
            <xsl:value-of select="curr:Imie" />
            <xsl:text> </xsl:text>
            <xsl:value-of select="curr:Imie2" />
            <xsl:text> </xsl:text>
            <xsl:value-of select="curr:Nazwisko" />
            <!-- 	<xsl:if test="contains($peselePelnomocReprezent, curr:PESEL)=false">
						<xsl:text> PESEL: </xsl:text>
						<xsl:value-of select="curr:PESEL"/>
					</xsl:if> -->
            <xsl:if test="curr:stanowisko!=''">
              <br />
              <xsl:value-of select="curr:stanowisko" />
            </xsl:if>
          </xsl:for-each>
          <xsl:for-each select="curr:OsobaSkladajaca/curr:Adres">
            <br />
            <xsl:for-each select="@ulica">
              <span>
                <xsl:value-of select="string(.)" />
              </span>
              <span>
                <xsl:text> </xsl:text>
              </span>
            </xsl:for-each>
            <xsl:if test="string-length(@ulica) &lt; 3">
              <xsl:for-each select="@miejscowosc">
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
                <span>
                  <xsl:text> </xsl:text>
                </span>
              </xsl:for-each>
            </xsl:if>
            <xsl:for-each select="@nr_domu">
              <span>
                <xsl:value-of select="string(.)" />
              </span>
              <span>
                <xsl:text> </xsl:text>
              </span>
            </xsl:for-each>
            <span>
              <xsl:text> </xsl:text>
            </span>
            <xsl:if test="string-length( @nr_mieszkania )&gt;0">
              <xsl:if test="name(@nr_mieszkania) and  name(@nr_mieszkania)!='' and string-length( normalize-space( @nr_mieszkania)) &gt;0">
                <xsl:for-each select="@nr_mieszkania">
                  <span>
                    <xsl:text>/</xsl:text>
                  </span>
                  <span>
                    <xsl:value-of select="string(.)" />
                  </span>
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                </xsl:for-each>
              </xsl:if>
            </xsl:if>
            <xsl:if test="string-length( @kod )!=5">
              <xsl:for-each select="@kod">
                <span>
                  <xsl:text> </xsl:text>
                </span>
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
              </xsl:for-each>
            </xsl:if>
            <span>
              <xsl:text> </xsl:text>
            </span>
            <xsl:if test="string-length( @kod )=5">
              <xsl:for-each select="@kod">
                <span>
                  <xsl:text> </xsl:text>
                </span>
                <span>
                  <xsl:value-of select="concat( substring( . ,1, 2 ),'-' ,substring( . , 3 ,3 ) )" />
                </span>
              </xsl:for-each>
            </xsl:if>
            <xsl:if test="string-length(@ulica)&gt;2">
              <xsl:for-each select="@miejscowosc">
                <span>
                  <xsl:text> </xsl:text>
                </span>
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
              </xsl:for-each>
            </xsl:if>
            <span>
              <xsl:text> </xsl:text>
            </span>
            <xsl:if test="@poczta!=@miejscowosc or string-length( @ulica )&lt;3">
              <xsl:for-each select="@poczta">
                <span>
                  <xsl:text> </xsl:text>
                </span>
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
              </xsl:for-each>
            </xsl:if>
            <br />
          </xsl:for-each>
          <!-- jesli pełnomocnictwo -->
          <xsl:if test="curr:OsobaSkladajaca[@pelnomocnik=1]">
            <xsl:for-each select="curr:OsobaSkladajaca">
              <br />
              <xsl:value-of select="@podstawa" />
            </xsl:for-each>
          </xsl:if>
          <!-- w imieniu -->
          <br />
          <br />
          <span style="text-decoration:underline; ">
            <xsl:text>W imieniu</xsl:text>
          </span>
          <xsl:for-each select="curr:ListaPowodow/curr:Powod">
            <xsl:for-each select="curr:Instytucja">
              <br />
              <xsl:value-of select="curr:Nazwa" />
            </xsl:for-each>
            <xsl:for-each select="curr:OsobaFizyczna">
              <br />
              <xsl:value-of select="curr:Imie" />
              <xsl:text> </xsl:text>
              <xsl:value-of select="curr:Imie2" />
              <xsl:text> </xsl:text>
              <xsl:value-of select="curr:Nazwisko" />
              <!-- 		<xsl:if test="contains($peselePelnomocReprezent, curr:PESEL)=false">
							<xsl:text> PESEL: </xsl:text>
							<xsl:value-of select="curr:PESEL"/>
							<xsl:text> </xsl:text>
						</xsl:if> -->
            </xsl:for-each>
            <xsl:for-each select="curr:Adres">
              <br />
              <xsl:for-each select="@ulica">
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
                <span>
                  <xsl:text> </xsl:text>
                </span>
              </xsl:for-each>
              <xsl:if test="string-length(@ulica) &lt; 3">
                <xsl:for-each select="@miejscowosc">
                  <span>
                    <xsl:value-of select="string(.)" />
                  </span>
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                </xsl:for-each>
              </xsl:if>
              <xsl:for-each select="@nr_domu">
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
                <span>
                  <xsl:text> </xsl:text>
                </span>
              </xsl:for-each>
              <span>
                <xsl:text> </xsl:text>
              </span>
              <xsl:if test="string-length( @nr_mieszkania )&gt;0">
                <xsl:if test="name(@nr_mieszkania) and  name(@nr_mieszkania)!='' and string-length( normalize-space( @nr_mieszkania)) &gt;0">
                  <xsl:for-each select="@nr_mieszkania">
                    <span>
                      <xsl:text>/</xsl:text>
                    </span>
                    <span>
                      <xsl:value-of select="string(.)" />
                    </span>
                    <span>
                      <xsl:text> </xsl:text>
                    </span>
                  </xsl:for-each>
                </xsl:if>
              </xsl:if>
              <xsl:if test="string-length( @kod )!=5">
                <xsl:for-each select="@kod">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <span>
                    <xsl:value-of select="string(.)" />
                  </span>
                </xsl:for-each>
              </xsl:if>
              <span>
                <xsl:text> </xsl:text>
              </span>
              <xsl:if test="string-length( @kod )=5">
                <xsl:for-each select="@kod">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <span>
                    <xsl:value-of select="concat( substring( . ,1, 2 ),'-' ,substring( . , 3 ,3 ) )" />
                  </span>
                </xsl:for-each>
              </xsl:if>
              <xsl:if test="string-length(@ulica)&gt;2">
                <xsl:for-each select="@miejscowosc">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <span>
                    <xsl:value-of select="string(.)" />
                  </span>
                </xsl:for-each>
              </xsl:if>
              <span>
                <xsl:text> </xsl:text>
              </span>
              <xsl:if test="@poczta!=@miejscowosc or string-length( @ulica )&lt;3">
                <xsl:for-each select="@poczta">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <span>
                    <xsl:value-of select="string(.)" />
                  </span>
                </xsl:for-each>
              </xsl:if>
              <br />
            </xsl:for-each>
          </xsl:for-each>
          <!-- naglowek -->
          <div>
            <h3 style="text-align:center; ">
              <span>
                <br />
                <br />
                <xsl:text>WNIOSEK</xsl:text>
                <br />
                <br />
              </span>
            </h3>
          </div>
          <xsl:text> 
			Na podstawie art. 505[33] § 3 K.p.c. w przypadku braku podstaw do wydania nakazu zapłaty wnoszę o umorzenie postępowania.
					</xsl:text>
        </xsl:for-each>
      </xsl:if>
      <xsl:if test="curr:PozewEPU/@CzyWniosekUmorzUchylenie = 1">
        <div style=" page-break-before: always;" />
        <!-- Data złożenia -->
        <div align="right">
          <xsl:for-each select="curr:PozewEPU">
            <br />
            <xsl:text> Data złożenia: </xsl:text>
            <xsl:value-of select="@dataZlozenia" />
          </xsl:for-each>
        </div>
        <!-- Osoba składająca -->
        <br />
        <span style="text-decoration:underline; ">
          <xsl:text>Osoba składająca</xsl:text>
        </span>
        <xsl:for-each select="curr:PozewEPU">
          <xsl:for-each select="curr:OsobaSkladajaca/curr:Osoba">
            <br />
            <xsl:value-of select="curr:Imie" />
            <xsl:text> </xsl:text>
            <xsl:value-of select="curr:Imie2" />
            <xsl:text> </xsl:text>
            <xsl:value-of select="curr:Nazwisko" />
            <!-- 	<xsl:if test="contains($peselePelnomocReprezent, curr:PESEL)=false">
						<xsl:text> PESEL: </xsl:text>
						<xsl:value-of select="curr:PESEL"/>
					</xsl:if> -->
            <xsl:if test="curr:stanowisko!=''">
              <br />
              <xsl:value-of select="curr:stanowisko" />
            </xsl:if>
          </xsl:for-each>
          <xsl:for-each select="curr:OsobaSkladajaca/curr:Adres">
            <br />
            <xsl:for-each select="@ulica">
              <span>
                <xsl:value-of select="string(.)" />
              </span>
              <span>
                <xsl:text> </xsl:text>
              </span>
            </xsl:for-each>
            <xsl:if test="string-length(@ulica) &lt; 3">
              <xsl:for-each select="@miejscowosc">
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
                <span>
                  <xsl:text> </xsl:text>
                </span>
              </xsl:for-each>
            </xsl:if>
            <xsl:for-each select="@nr_domu">
              <span>
                <xsl:value-of select="string(.)" />
              </span>
              <span>
                <xsl:text> </xsl:text>
              </span>
            </xsl:for-each>
            <span>
              <xsl:text> </xsl:text>
            </span>
            <xsl:if test="string-length( @nr_mieszkania )&gt;0">
              <xsl:if test="name(@nr_mieszkania) and  name(@nr_mieszkania)!='' and string-length( normalize-space( @nr_mieszkania)) &gt;0">
                <xsl:for-each select="@nr_mieszkania">
                  <span>
                    <xsl:text>/</xsl:text>
                  </span>
                  <span>
                    <xsl:value-of select="string(.)" />
                  </span>
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                </xsl:for-each>
              </xsl:if>
            </xsl:if>
            <xsl:if test="string-length( @kod )!=5">
              <xsl:for-each select="@kod">
                <span>
                  <xsl:text> </xsl:text>
                </span>
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
              </xsl:for-each>
            </xsl:if>
            <span>
              <xsl:text> </xsl:text>
            </span>
            <xsl:if test="string-length( @kod )=5">
              <xsl:for-each select="@kod">
                <span>
                  <xsl:text> </xsl:text>
                </span>
                <span>
                  <xsl:value-of select="concat( substring( . ,1, 2 ),'-' ,substring( . , 3 ,3 ) )" />
                </span>
              </xsl:for-each>
            </xsl:if>
            <xsl:if test="string-length(@ulica)&gt;2">
              <xsl:for-each select="@miejscowosc">
                <span>
                  <xsl:text> </xsl:text>
                </span>
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
              </xsl:for-each>
            </xsl:if>
            <span>
              <xsl:text> </xsl:text>
            </span>
            <xsl:if test="@poczta!=@miejscowosc or string-length( @ulica )&lt;3">
              <xsl:for-each select="@poczta">
                <span>
                  <xsl:text> </xsl:text>
                </span>
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
              </xsl:for-each>
            </xsl:if>
            <br />
          </xsl:for-each>
          <!-- jesli pełnomocnictwo -->
          <xsl:if test="curr:OsobaSkladajaca[@pelnomocnik=1]">
            <xsl:for-each select="curr:OsobaSkladajaca">
              <br />
              <xsl:value-of select="@podstawa" />
            </xsl:for-each>
          </xsl:if>
          <!-- w imieniu -->
          <br />
          <br />
          <span style="text-decoration:underline; ">
            <xsl:text>W imieniu</xsl:text>
          </span>
          <xsl:for-each select="curr:ListaPowodow/curr:Powod">
            <xsl:for-each select="curr:Instytucja">
              <br />
              <xsl:value-of select="curr:Nazwa" />
            </xsl:for-each>
            <xsl:for-each select="curr:OsobaFizyczna">
              <br />
              <xsl:value-of select="curr:Imie" />
              <xsl:text> </xsl:text>
              <xsl:value-of select="curr:Imie2" />
              <xsl:text> </xsl:text>
              <xsl:value-of select="curr:Nazwisko" />
              <!-- 		<xsl:if test="contains($peselePelnomocReprezent, curr:PESEL)=false">
							<xsl:text> PESEL: </xsl:text>
							<xsl:value-of select="curr:PESEL"/>
							<xsl:text> </xsl:text>
						</xsl:if> -->
            </xsl:for-each>
            <xsl:for-each select="curr:Adres">
              <br />
              <xsl:for-each select="@ulica">
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
                <span>
                  <xsl:text> </xsl:text>
                </span>
              </xsl:for-each>
              <xsl:if test="string-length(@ulica) &lt; 3">
                <xsl:for-each select="@miejscowosc">
                  <span>
                    <xsl:value-of select="string(.)" />
                  </span>
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                </xsl:for-each>
              </xsl:if>
              <xsl:for-each select="@nr_domu">
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
                <span>
                  <xsl:text> </xsl:text>
                </span>
              </xsl:for-each>
              <span>
                <xsl:text> </xsl:text>
              </span>
              <xsl:if test="string-length( @nr_mieszkania )&gt;0">
                <xsl:if test="name(@nr_mieszkania) and  name(@nr_mieszkania)!='' and string-length( normalize-space( @nr_mieszkania)) &gt;0">
                  <xsl:for-each select="@nr_mieszkania">
                    <span>
                      <xsl:text>/</xsl:text>
                    </span>
                    <span>
                      <xsl:value-of select="string(.)" />
                    </span>
                    <span>
                      <xsl:text> </xsl:text>
                    </span>
                  </xsl:for-each>
                </xsl:if>
              </xsl:if>
              <xsl:if test="string-length( @kod )!=5">
                <xsl:for-each select="@kod">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <span>
                    <xsl:value-of select="string(.)" />
                  </span>
                </xsl:for-each>
              </xsl:if>
              <span>
                <xsl:text> </xsl:text>
              </span>
              <xsl:if test="string-length( @kod )=5">
                <xsl:for-each select="@kod">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <span>
                    <xsl:value-of select="concat( substring( . ,1, 2 ),'-' ,substring( . , 3 ,3 ) )" />
                  </span>
                </xsl:for-each>
              </xsl:if>
              <xsl:if test="string-length(@ulica)&gt;2">
                <xsl:for-each select="@miejscowosc">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <span>
                    <xsl:value-of select="string(.)" />
                  </span>
                </xsl:for-each>
              </xsl:if>
              <span>
                <xsl:text> </xsl:text>
              </span>
              <xsl:if test="@poczta!=@miejscowosc or string-length( @ulica )&lt;3">
                <xsl:for-each select="@poczta">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <span>
                    <xsl:value-of select="string(.)" />
                  </span>
                </xsl:for-each>
              </xsl:if>
              <br />
            </xsl:for-each>
          </xsl:for-each>
          <!-- naglowek -->
          <div>
            <h3 style="text-align:center; ">
              <span>
                <br />
                <br />
                <xsl:text>WNIOSEK</xsl:text>
                <br />
                <br />
              </span>
            </h3>
          </div>
          <xsl:text> 
			Na podstawie art. 505[34] § 3 K.p.c. w przypadku uchylenia nakazu zapłaty wnoszę o umorzenie postępowania.
					</xsl:text>
        </xsl:for-each>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>