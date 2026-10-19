<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:curr="http://www.currenda.pl/epu" xmlns:fn="http://www.w3.org/2005/xpath-functions"
  xmlns:link="http://www.xbrl.org/2003/linkbase" xmlns:xbrldi="http://xbrl.org/2006/xbrldi"
  xmlns:xbrli="http://www.xbrl.org/2003/instance" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:altova="http://www.altova.com" version="1.0"
  exclude-result-prefixes="curr fn link xbrldi xbrli xdt xlink xs xsd xsi">
  <xsl:output version="4.0" method="html" indent="no" encoding="UTF-8"
    doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
    doctype-system="http://www.w3.org/TR/html4/loose.dtd" />
  <xsl:param name="SV_OutputFormat" select="'HTML'" />
  <xsl:variable name="XML" select="/" />
  <xsl:decimal-format name="format1" grouping-separator=" " decimal-separator="," />
  <xsl:decimal-format name="european" decimal-separator="," grouping-separator=" " />
  <xsl:template name="stopaTemplate">
    <xsl:for-each select="@stopa">
      <span>
        <xsl:text> </xsl:text>
      </span>
      <span>
        <xsl:value-of
          select="format-number(number(translate(translate(string(.), '  ',''),',','.')), '### ##0,00##', 'european')" />
      </span>
      <span>
        <xsl:text> %</xsl:text>
      </span>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="dataTemplate">
    <!-- <xsl:value-of select="substring(replace(string(.), '(\d{2})-(\d{2})-(\d{4})', '$3-$2-$1'),
    0, 11)"/>-->
    <xsl:choose>
      <xsl:when test="substring(string(.),3,1) = '-' and string-length(string(.)) &gt; 9">
        <xsl:value-of select="substring(string(.),7,4)" />
        <xsl:text>-</xsl:text>
        <xsl:value-of
          select="substring(string(.),4,2)" />
        <xsl:text>-</xsl:text>
        <xsl:value-of
          select="substring(string(.),1,2)" />
      </xsl:when>
      <xsl:when test="substring(string(.),5,1) = '-' and string-length(string(.))  &gt; 9">
        <xsl:value-of select="substring(string(.),1,4)" />
        <xsl:text>-</xsl:text>
        <xsl:value-of
          select="substring(string(.),6,2)" />
        <xsl:text>-</xsl:text>
        <xsl:value-of
          select="substring(string(.),9,2)" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="string(.)" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="@okres" name="okresTemplate">
    <xsl:if test="@okres=0">
      <xsl:for-each select="@okres">
        <span>
          <xsl:text> rocznie </xsl:text>
        </span>
      </xsl:for-each>
    </xsl:if>
    <xsl:if
      test="@okres=1">
      <xsl:for-each select="@okres">
        <span>
          <xsl:text> kwartalnie </xsl:text>
        </span>
      </xsl:for-each>
    </xsl:if>
    <xsl:if
      test="@okres=2">
      <xsl:for-each select="@okres">
        <span>
          <xsl:text> miesięcznie</xsl:text>
        </span>
      </xsl:for-each>
    </xsl:if>
    <xsl:if
      test="@okres=3">
      <xsl:for-each select="@okres">
        <span>
          <xsl:text> tygodniowo</xsl:text>
        </span>
      </xsl:for-each>
    </xsl:if>
    <xsl:if
      test="@okres=4">
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
      <div>
        <xsl:for-each select="curr:WniosekEgzekucyjny">
          <xsl:for-each select="@dataWniosku">
            <span>
              <xsl:text>Data złożenia </xsl:text>
            </span>
            <span>
              <xsl:value-of select="string(.)" />
            </span>
          </xsl:for-each>
        </xsl:for-each>
      </div>
      <br />
      <div
        align="right">
        <xsl:for-each select="curr:WniosekEgzekucyjny">
          <xsl:for-each select="curr:Komornik">
            <xsl:for-each select="curr:Nazwa">
              <span style="font-weight:bold; ">
                <xsl:apply-templates />
              </span>
            </xsl:for-each>
          </xsl:for-each>
        </xsl:for-each>
      </div>
      <br />
      <div>
        <span style="text-decoration:underline; ">
          <xsl:text>Osoba składająca</xsl:text>
        </span>
      </div>
      <div>
        <xsl:for-each select="curr:WniosekEgzekucyjny">
          <xsl:for-each select="curr:OsobaSkladajaca">
            <xsl:for-each select="curr:Osoba">
              <xsl:for-each select="curr:Imie">
                <xsl:apply-templates />
              </xsl:for-each>
              <xsl:for-each
                select="curr:Imie2">
                <span>
                  <xsl:text> </xsl:text>
                </span>
                <xsl:apply-templates />
              </xsl:for-each>
              <xsl:for-each
                select="curr:Nazwisko">
                <span>
                  <xsl:text> </xsl:text>
                </span>
                <xsl:apply-templates />
              </xsl:for-each>
              <xsl:for-each
                select="curr:PESEL">
                <span>
                  <xsl:text> PESEL </xsl:text>
                </span>
                <xsl:apply-templates />
              </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each
              select="curr:Nazwa">
              <span>
                <xsl:text> </xsl:text>
              </span>
              <xsl:apply-templates />
            </xsl:for-each>
          </xsl:for-each>
        </xsl:for-each>
      </div>
      <div>
        <xsl:for-each select="curr:WniosekEgzekucyjny">
          <xsl:for-each select="curr:OsobaSkladajaca">
            <xsl:for-each select="curr:Adres">
              <xsl:for-each select="@ulica">
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
              </xsl:for-each>
              <xsl:for-each
                select="@nr_domu">
                <span>
                  <xsl:text> </xsl:text>
                </span>
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
              </xsl:for-each>
              <xsl:if
                test="string-length( @nr_mieszkania )&gt;0">
                <xsl:for-each select="@nr_mieszkania">
                  <span>
                    <xsl:text>/</xsl:text>
                  </span>
                  <span>
                    <xsl:value-of select="string(.)" />
                  </span>
                </xsl:for-each>
              </xsl:if>
              <xsl:if
                test="string-length( @kod )!=5">
                <xsl:for-each select="@kod">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <span>
                    <xsl:value-of select="string(.)" />
                  </span>
                </xsl:for-each>
              </xsl:if>
              <xsl:if
                test="string-length( @kod )=5">
                <xsl:for-each select="@kod">
                  <span>
                    <xsl:value-of
                      select="concat( substring( . ,1, 2 ) ,'-', substring( . , 3 , 3 ) )" />
                  </span>
                </xsl:for-each>
              </xsl:if>
              <xsl:for-each
                select="@miejscowosc">
                <span>
                  <xsl:text> </xsl:text>
                </span>
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
              </xsl:for-each>
              <xsl:if
                test="@poczta!=@miejscowosc">
                <xsl:for-each select="@poczta">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <span>
                    <xsl:value-of select="string(.)" />
                  </span>
                </xsl:for-each>
              </xsl:if>
            </xsl:for-each>
            <br />
            <xsl:for-each
              select="@podstawa">
              <span>
                <xsl:value-of select="string(.)" />
              </span>
            </xsl:for-each>
          </xsl:for-each>
        </xsl:for-each>
      </div>
      <div>
        <h2 align="center">
          <span>
            <xsl:text>W N I O S E K    O  WSZCZĘCIE   EGZEKUCJI</xsl:text>
          </span>
        </h2>
      </div>
      <div>
        <span>
          <xsl:text>Przedkładając prawomocny nakaz z dnia </xsl:text>
        </span>
        <xsl:for-each select="curr:WniosekEgzekucyjny">
          <xsl:for-each select="curr:Nakaz">
            <xsl:for-each select="curr:DataNakazu">
              <span style="font-weight:bold; ">
                <xsl:apply-templates />
              </span>
            </xsl:for-each>
          </xsl:for-each>
        </xsl:for-each>
        <span>
          <xsl:text> wydany przez </xsl:text>
        </span>
        <xsl:for-each select="curr:WniosekEgzekucyjny">
          <xsl:for-each select="curr:Sad">
            <xsl:for-each select="curr:Nazwa">
              <xsl:apply-templates />
            </xsl:for-each>
            <span>
              <xsl:text> </xsl:text>
            </span>
            <xsl:for-each select="curr:Wydzial">
              <xsl:apply-templates />
            </xsl:for-each>
          </xsl:for-each>
        </xsl:for-each>
        <span>
          <xsl:text> w sprawie sygn. akt  </xsl:text>
        </span>
        <xsl:for-each select="curr:WniosekEgzekucyjny">
          <xsl:for-each select="curr:Nakaz">
            <xsl:for-each select="curr:Sygnatura">
              <span style="font-weight:bold; ">
                <xsl:apply-templates />
              </span>
            </xsl:for-each>
          </xsl:for-each>
        </xsl:for-each>
        <span>
          <xsl:text> zaopatrzony w klauzulę wykonalności z dnia </xsl:text>
        </span>
        <xsl:for-each select="curr:WniosekEgzekucyjny">
          <xsl:for-each select="curr:Klauzula">
            <xsl:for-each select="curr:DataKlauzuli">
              <span style="font-weight:bold; ">
                <xsl:apply-templates />
              </span>
            </xsl:for-each>
          </xsl:for-each>
        </xsl:for-each>
        <span>
          <xsl:text> wierzyciel(e)</xsl:text>
        </span>
      </div>
      <div>
        <table border="1">
          <xsl:variable name="altova:CurrContextGrid_0802F1F8" select="." />
          <thead>
            <tr>
              <th>
                <span>
                  <xsl:text>Wierzyciel</xsl:text>
                </span>
              </th>
              <th>
                <span>
                  <xsl:text>Adres</xsl:text>
                </span>
              </th>
              <th>
                <span>
                  <xsl:text>KontoBankowe</xsl:text>
                </span>
              </th>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="curr:WniosekEgzekucyjny">
              <xsl:for-each select="curr:ListaWierzycieli">
                <xsl:for-each select="curr:Wierzyciel">
                  <tr>
                    <td>
                      <xsl:for-each select="curr:OsobaFizyczna">
                        <xsl:for-each select="curr:Imie">
                          <xsl:apply-templates />
                        </xsl:for-each>
                        <xsl:for-each
                          select="curr:Imie2">
                          <span>
                            <xsl:text> </xsl:text>
                          </span>
                          <xsl:apply-templates />
                        </xsl:for-each>
                        <xsl:for-each
                          select="curr:Nazwisko">
                          <span>
                            <xsl:text> </xsl:text>
                          </span>
                          <xsl:apply-templates />
                        </xsl:for-each>
                        <xsl:for-each
                          select="curr:Nazwa">
                          <span>
                            <xsl:text> </xsl:text>
                          </span>
                          <xsl:apply-templates />
                        </xsl:for-each>
                        <xsl:for-each
                          select="curr:PESEL">
                          <span>
                            <xsl:text> PESEL </xsl:text>
                          </span>
                          <xsl:apply-templates />
                        </xsl:for-each>
                        <span>
                          <xsl:text> </xsl:text>
                        </span>
                      </xsl:for-each>
                      <xsl:for-each select="curr:Instytucja">
                        <xsl:for-each select="curr:Nazwa">
                          <xsl:apply-templates />
                        </xsl:for-each>
                        <xsl:if
                          test="(contains( curr:Siedziba , 'z siedzibą')=false and not(contains((translate(curr:Nazwa,'aąbcdefghijklmnopqrstuvwxyz','AĄBCDEFGHIJKLMNOPQRSTUVWXYZ')),'Z SIEDZIBĄ')))">
                          <xsl:for-each select="curr:Siedziba">
                            <span>
                              <xsl:if
                                test="((starts-with((.), 'W') or starts-with((.), 'F'))and (not(contains('AĄEĘIOÓUY',substring((.),2,1)) or contains('aąeęioóuy', substring((.),2,1)))))">
                                <xsl:text> z siedzibą we</xsl:text>
                              </xsl:if>
                              <xsl:if
                                test="not(((starts-with((.), 'W') or starts-with((.), 'F')) and (not(contains('AĄEĘIOÓUY',substring((.),2,1)) or contains('aąeęioóuy', substring((.),2,1)) ) ) ))">
                                <xsl:text> z siedzibą w</xsl:text>
                              </xsl:if>
                            </span>
                          </xsl:for-each>
                        </xsl:if>
                        <xsl:if
                          test="(not(contains((translate(curr:Nazwa,'aąbcdefghijklmnopqrstuvwxyz','AĄBCDEFGHIJKLMNOPQRSTUVWXYZ')),'Z SIEDZIBĄ')))">
                          <xsl:for-each select="curr:Siedziba">
                            <span>
                              <xsl:text> </xsl:text>
                            </span>
                            <xsl:apply-templates />
                          </xsl:for-each>
                        </xsl:if>
                      </xsl:for-each>
                    </td>
                    <td>
                      <xsl:for-each select="curr:Adres">
                        <xsl:for-each select="@ulica">
                          <span>
                            <xsl:value-of select="string(.)" />
                          </span>
                          <span>
                            <xsl:text> </xsl:text>
                          </span>
                        </xsl:for-each>
                        <xsl:for-each
                          select="@nr_domu">
                          <span>
                            <xsl:value-of select="string(.)" />
                          </span>
                          <span>
                            <xsl:text> </xsl:text>
                          </span>
                        </xsl:for-each>
                        <xsl:if
                          test="string-length( @nr_mieszkania )&gt;0">
                          <xsl:for-each select="@nr_mieszkania">
                            <span>
                              <xsl:text>/</xsl:text>
                            </span>
                            <span>
                              <xsl:value-of select="string(.)" />
                            </span>
                          </xsl:for-each>
                        </xsl:if>
                        <xsl:if
                          test="string-length( @kod )!=5">
                          <xsl:for-each select="@kod">
                            <span>
                              <xsl:text> </xsl:text>
                            </span>
                            <span>
                              <xsl:value-of select="string(.)" />
                            </span>
                          </xsl:for-each>
                        </xsl:if>
                        <xsl:if
                          test="string-length( @kod )=5">
                          <xsl:for-each select="@kod">
                            <span>
                              <xsl:text> </xsl:text>
                            </span>
                            <span>
                              <xsl:value-of
                                select="concat(substring( . , 1 ,2 ),'-',substring( . , 3 ,3 ))" />
                            </span>
                          </xsl:for-each>
                        </xsl:if>
                        <xsl:for-each
                          select="@miejscowosc">
                          <span>
                            <xsl:text> </xsl:text>
                          </span>
                          <span>
                            <xsl:value-of select="string(.)" />
                          </span>
                        </xsl:for-each>
                        <xsl:for-each
                          select="@poczta">
                          <span>
                            <xsl:text> </xsl:text>
                          </span>
                          <span>
                            <xsl:value-of select="string(.)" />
                          </span>
                        </xsl:for-each>
                        <span>
                          <xsl:text>; </xsl:text>
                        </span>
                        <br />
                      </xsl:for-each>
                    </td>
                    <td>
                      <xsl:for-each select="curr:KontoBankowe">
                        <xsl:apply-templates />
                      </xsl:for-each>
                    </td>
                  </tr>
                </xsl:for-each>
              </xsl:for-each>
            </xsl:for-each>
          </tbody>
        </table>
      </div>
      <div>
        <span>
          <xsl:text>wnoszą o </xsl:text>
        </span>
      </div>
      <div>
        <span>
          <xsl:text>I. Wszczęcie egzekucji wobec dłużnika(ów) </xsl:text>
        </span>
      </div>
      <div>
        <table border="1">
          <xsl:variable name="altova:CurrContextGrid_083F0C70" select="." />
          <thead>
            <tr>
              <th>
                <span>
                  <xsl:text>Dłużnik</xsl:text>
                </span>
              </th>
              <th>
                <span>
                  <xsl:text>NIP</xsl:text>
                </span>
              </th>
              <th>
                <span>
                  <xsl:text>Adres</xsl:text>
                </span>
              </th>
              <th>
                <span>
                  <xsl:text>ListaSposobow</xsl:text>
                </span>
              </th>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="curr:WniosekEgzekucyjny">
              <xsl:for-each select="curr:ListaDluznikow">
                <xsl:for-each select="curr:Dluznik">
                  <tr>
                    <td>
                      <xsl:for-each select="curr:OsobaFizyczna">
                        <xsl:for-each select="curr:Imie">
                          <xsl:apply-templates />
                        </xsl:for-each>
                        <xsl:for-each
                          select="curr:Imie2">
                          <span>
                            <xsl:text> </xsl:text>
                          </span>
                          <xsl:apply-templates />
                        </xsl:for-each>
                        <xsl:for-each
                          select="curr:Nazwisko">
                          <span>
                            <xsl:text> </xsl:text>
                          </span>
                          <xsl:apply-templates />
                        </xsl:for-each>
                        <xsl:for-each
                          select="curr:Nazwa">
                          <span>
                            <xsl:text> </xsl:text>
                          </span>
                          <xsl:apply-templates />
                        </xsl:for-each>
                        <xsl:for-each
                          select="curr:PESEL">
                          <span>
                            <xsl:text> PESEL </xsl:text>
                          </span>
                          <xsl:apply-templates />
                        </xsl:for-each>
                        <xsl:for-each
                          select="curr:DataUrodzenia">
                          <span>
                            <xsl:text> data ur. </xsl:text>
                          </span>
                          <xsl:apply-templates />
                        </xsl:for-each>
                        <xsl:for-each
                          select="curr:MiejsceUrodzenia">
                          <span>
                            <xsl:text> miejsce ur. </xsl:text>
                          </span>
                          <xsl:apply-templates />
                        </xsl:for-each>
                        <xsl:for-each
                          select="curr:ImieOjca">
                          <span>
                            <xsl:text> imię ojca: </xsl:text>
                          </span>
                          <xsl:apply-templates />
                        </xsl:for-each>
                        <xsl:for-each
                          select="curr:ImieMatki">
                          <span>
                            <xsl:text> imie matki: </xsl:text>
                          </span>
                          <xsl:apply-templates />
                        </xsl:for-each>
                      </xsl:for-each>
                      <xsl:for-each select="curr:Instytucja">
                        <xsl:for-each select="curr:Nazwa">
                          <xsl:apply-templates />
                        </xsl:for-each>
                        <xsl:if
                          test="(contains( curr:Siedziba , 'z siedzibą')=false and not(contains((translate(curr:Nazwa,'aąbcdefghijklmnopqrstuvwxyz','AĄBCDEFGHIJKLMNOPQRSTUVWXYZ')),'Z SIEDZIBĄ')))">
                          <xsl:for-each select="curr:Siedziba">
                            <span>
                              <xsl:if
                                test="((starts-with((.), 'W') or starts-with((.), 'F'))and (not(contains('AĄEĘIOÓUY',substring((.),2,1)) or contains('aąeęioóuy', substring((.),2,1)))))">
                                <xsl:text> z siedzibą we</xsl:text>
                              </xsl:if>
                              <xsl:if
                                test="not(((starts-with((.), 'W') or starts-with((.), 'F')) and (not(contains('AĄEĘIOÓUY',substring((.),2,1)) or contains('aąeęioóuy', substring((.),2,1)) ) ) ))">
                                <xsl:text> z siedzibą w</xsl:text>
                              </xsl:if>
                            </span>
                          </xsl:for-each>
                        </xsl:if>
                        <xsl:if
                          test="(not(contains((translate(curr:Nazwa,'aąbcdefghijklmnopqrstuvwxyz','AĄBCDEFGHIJKLMNOPQRSTUVWXYZ')),'Z SIEDZIBĄ')))">
                          <xsl:for-each select="curr:Siedziba">
                            <span>
                              <xsl:text> </xsl:text>
                            </span>
                            <xsl:apply-templates />
                          </xsl:for-each>
                        </xsl:if>
                        <xsl:for-each
                          select="curr:KRS">
                          <span>
                            <xsl:text> KRS </xsl:text>
                          </span>
                          <xsl:apply-templates />
                        </xsl:for-each>
                        <xsl:for-each
                          select="curr:REGON">
                          <span>
                            <xsl:text> REGON </xsl:text>
                          </span>
                          <xsl:apply-templates />
                        </xsl:for-each>
                        <xsl:for-each
                          select="curr:InnyRejestr">
                          <xsl:for-each select="@typ">
                            <span>
                              <xsl:text> </xsl:text>
                            </span>
                            <span>
                              <xsl:value-of select="string(.)" />
                            </span>
                          </xsl:for-each>
                          <xsl:for-each
                            select="@organ">
                            <span>
                              <xsl:text> </xsl:text>
                            </span>
                            <span>
                              <xsl:value-of select="string(.)" />
                            </span>
                          </xsl:for-each>
                          <xsl:for-each
                            select="@numer">
                            <span>
                              <xsl:text> </xsl:text>
                            </span>
                            <span>
                              <xsl:value-of select="string(.)" />
                            </span>
                          </xsl:for-each>
                        </xsl:for-each>
                      </xsl:for-each>
                    </td>
                    <td>
                      <xsl:for-each select="curr:NIP">
                        <xsl:apply-templates />
                      </xsl:for-each>
                    </td>
                    <td>
                      <xsl:for-each select="curr:Adres">
                        <xsl:for-each select="@ulica">
                          <span>
                            <xsl:value-of select="string(.)" />
                          </span>
                          <span>
                            <xsl:text>  </xsl:text>
                          </span>
                        </xsl:for-each>
                        <xsl:for-each
                          select="@nr_domu">
                          <span>
                            <xsl:value-of select="string(.)" />
                          </span>
                          <span>
                            <xsl:text>  </xsl:text>
                          </span>
                        </xsl:for-each>
                        <xsl:if
                          test="string-length( @nr_mieszkania )&gt;0">
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
                        <xsl:if
                          test="string-length( @kod )!=5">
                          <xsl:for-each select="@kod">
                            <span>
                              <xsl:text> </xsl:text>
                            </span>
                            <span>
                              <xsl:value-of select="string(.)" />
                            </span>
                            <span>
                              <xsl:text> </xsl:text>
                            </span>
                          </xsl:for-each>
                        </xsl:if>
                        <xsl:if
                          test="string-length( @kod )=5">
                          <xsl:for-each select="@kod">
                            <span>
                              <xsl:text> </xsl:text>
                            </span>
                            <span>
                              <xsl:value-of
                                select="concat( substring( . ,1, 2 ) ,'-', substring( . , 3 , 3 ) )" />
                            </span>
                            <span>
                              <xsl:text> </xsl:text>
                            </span>
                          </xsl:for-each>
                        </xsl:if>
                        <xsl:for-each
                          select="@miejscowosc">
                          <span>
                            <xsl:text> </xsl:text>
                          </span>
                          <span>
                            <xsl:value-of select="string(.)" />
                          </span>
                        </xsl:for-each>
                        <xsl:for-each
                          select="@poczta">
                          <span>
                            <xsl:text> </xsl:text>
                          </span>
                          <span>
                            <xsl:value-of select="string(.)" />
                          </span>
                        </xsl:for-each>
                        <span>
                          <xsl:text>; </xsl:text>
                        </span>
                        <br />
                      </xsl:for-each>
                    </td>
                    <td>
                      <xsl:for-each select="curr:ListaSposobow">
                        <xsl:for-each select="curr:SposobEgzekucji">
                          <ul>
                            <li>
                              <xsl:for-each select="curr:Rodzaj">
                                <xsl:apply-templates />
                              </xsl:for-each>
                            </li>
                          </ul>
                          <xsl:for-each
                            select="curr:Opis">
                            <xsl:apply-templates />
                          </xsl:for-each>
                        </xsl:for-each>
                      </xsl:for-each>
                    </td>
                  </tr>
                </xsl:for-each>
              </xsl:for-each>
            </xsl:for-each>
          </tbody>
        </table>
      </div>
      <div>
        <span>
          <xsl:text>w celu wyegzekwowania następujących kwot</xsl:text>
        </span>
      </div>
      <div>
        <table border="1">
          <xsl:variable name="altova:CurrContextGrid_0812CE60" select="." />
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
              <th>
                <span>
                  <xsl:text>waluta</xsl:text>
                </span>
              </th>
              <th>
                <span>
                  <xsl:text>opis</xsl:text>
                </span>
              </th>
              <th>
                <span>
                  <xsl:text> odsetki</xsl:text>
                </span>
              </th>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="curr:WniosekEgzekucyjny">
              <xsl:for-each select="curr:ListaRoszczen">
                <xsl:for-each select="curr:Roszczenie">
                  <tr>
                    <td>
                      <xsl:for-each select="@numer">
                        <span>
                          <xsl:value-of select="string(.)" />
                        </span>
                      </xsl:for-each>
                    </td>
                    <td>
                      <xsl:for-each select="@wartosc">
                        <span>
                          <xsl:value-of
                            select="format-number(number(translate(translate(string(.), '  ',''),',','.')), '### ##0,00##', 'european')" />
                        </span>
                      </xsl:for-each>
                    </td>
                    <td>
                      <xsl:for-each select="@waluta">
                        <span>
                          <xsl:value-of select="string(.)" />
                        </span>
                      </xsl:for-each>
                    </td>
                    <td>
                      <xsl:if
                        test="(@solidarnie=0 or (@solidarnie=1 and (string-length( @opis )=0 or name(@opis)=''))) and (count(../../curr:ListaWierzycieli/curr:Wierzyciel )+count(../../curr:ListaDluznikow/curr:Dluznik)&gt;2)">
                        <span>
                          <xsl:text>solidarnie</xsl:text>
                        </span>
                      </xsl:if>
                      <br />
                      <xsl:if test="@solidarnie=2">
                        <span>
                          <xsl:text>solidarność bierna </xsl:text>
                        </span>
                      </xsl:if>
                      <br />
                      <xsl:if test="@solidarnie=3">
                        <span>
                          <xsl:text>solidarność czynna </xsl:text>
                        </span>
                      </xsl:if>
                      <br />
                      <xsl:if test="@solidarnie=4">
                        <span>
                          <xsl:text>in solidum </xsl:text>
                        </span>
                      </xsl:if>
                      <xsl:for-each select="@opis">
                        <span>
                          <xsl:value-of select="string(.)" />
                        </span>
                      </xsl:for-each>
                    </td>
                    <td align="center">
                      <br />
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
                            <xsl:text>z odsetkami</xsl:text>
                          </span>
                        </xsl:for-each>
                        <br />
                        <br />
                        <xsl:for-each
                          select="curr:Odsetki">
                          <xsl:for-each select="curr:OkresOdsetkowy">
                            <xsl:choose>
                              <xsl:when test="@czyUstawowe=0">
                                <span>
                                  <xsl:text>ustawowymi</xsl:text>
                                  <xsl:choose>
                                    <xsl:when
                                      test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                      <span>
                                        <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataOd">
                                        <span>
                                          <xsl:text> od dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
                                        </span>
                                      </xsl:for-each>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                  <xsl:choose>
                                    <xsl:when
                                      test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                      <span>
                                        <xsl:text> do dnia zapłaty</xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataDo">
                                        <span>
                                          <xsl:text> do dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
                                        </span>
                                      </xsl:for-each>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                </span>
                              </xsl:when>
                              <xsl:when test="@czyUstawowe=1">
                                <span>
                                  <xsl:text>umownymi </xsl:text>
                                  <xsl:call-template name="stopaTemplate" />
                                  <xsl:call-template name="okresTemplate" />
                                </span>
                                <xsl:choose>
                                  <xsl:when
                                    test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                    <span>
                                      <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                    </span>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:for-each select="@dataOd">
                                      <span>
                                        <xsl:text> od dnia </xsl:text>
                                      </span>
                                      <span>
                                        <xsl:call-template name="dataTemplate" />
                                      </span>
                                    </xsl:for-each>
                                  </xsl:otherwise>
                                </xsl:choose>
                                <xsl:choose>
                                  <xsl:when
                                    test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                    <span>
                                      <xsl:text> do dnia zapłaty</xsl:text>
                                    </span>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:for-each select="@dataDo">
                                      <span>
                                        <xsl:text> do dnia </xsl:text>
                                      </span>
                                      <span>
                                        <xsl:call-template name="dataTemplate" />
                                      </span>
                                    </xsl:for-each>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </xsl:when>
                              <xsl:when test="@czyUstawowe=2">
                                <span>
                                  <xsl:text>umownymi </xsl:text>
                                  <xsl:call-template name="stopaTemplate" />
                                  <xsl:call-template name="okresTemplate" />
                                  <xsl:text> ale nie więcej niż czterokrotność stopy lombardowej NBP</xsl:text>
                                </span>
                                <xsl:choose>
                                  <xsl:when
                                    test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                    <span>
                                      <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                    </span>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:for-each select="@dataOd">
                                      <span>
                                        <xsl:text> od dnia </xsl:text>
                                      </span>
                                      <span>
                                        <xsl:call-template name="dataTemplate" />
                                      </span>
                                    </xsl:for-each>
                                  </xsl:otherwise>
                                </xsl:choose>
                                <xsl:choose>
                                  <xsl:when
                                    test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                    <span>
                                      <xsl:text> do dnia zapłaty</xsl:text>
                                    </span>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:for-each select="@dataDo">
                                      <span>
                                        <xsl:text> do dnia </xsl:text>
                                      </span>
                                      <span>
                                        <xsl:call-template name="dataTemplate" />
                                      </span>
                                    </xsl:for-each>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </xsl:when>
                              <xsl:when test="@czyUstawowe=3">
                                <span>
                                  <xsl:text>umownymi w wysokości czterokrotności stopy lombardowej NBP</xsl:text>
                                </span>
                                <xsl:choose>
                                  <xsl:when
                                    test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                    <span>
                                      <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                    </span>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:for-each select="@dataOd">
                                      <span>
                                        <xsl:text> od dnia </xsl:text>
                                      </span>
                                      <span>
                                        <xsl:call-template name="dataTemplate" />
                                      </span>
                                    </xsl:for-each>
                                  </xsl:otherwise>
                                </xsl:choose>
                                <xsl:choose>
                                  <xsl:when
                                    test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                    <span>
                                      <xsl:text> do dnia zapłaty</xsl:text>
                                    </span>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:for-each select="@dataDo">
                                      <span>
                                        <xsl:text> do dnia </xsl:text>
                                      </span>
                                      <span>
                                        <xsl:call-template name="dataTemplate" />
                                      </span>
                                    </xsl:for-each>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </xsl:when>
                              <xsl:when test="@czyUstawowe=4">
                                <span>
                                  <xsl:text>umownymi </xsl:text>
                                  <xsl:call-template name="stopaTemplate" />
                                  <xsl:call-template name="okresTemplate" />
                                  <xsl:text> ale nie więcej niż w wysokości odsetek maksymalnych </xsl:text>
                                  <xsl:choose>
                                    <xsl:when
                                      test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                      <span>
                                        <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataOd">
                                        <span>
                                          <xsl:text> od dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
                                        </span>
                                      </xsl:for-each>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                  <xsl:choose>
                                    <xsl:when
                                      test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                      <span>
                                        <xsl:text> do dnia zapłaty</xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataDo">
                                        <span>
                                          <xsl:text> do dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
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
                                    <xsl:when
                                      test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                      <span>
                                        <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataOd">
                                        <span>
                                          <xsl:text> od dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
                                        </span>
                                      </xsl:for-each>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                </span>
                                <span>
                                  <xsl:choose>
                                    <xsl:when
                                      test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                      <span>
                                        <xsl:text> do dnia zapłaty</xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataDo">
                                        <span>
                                          <xsl:text> do dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
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
                                    <xsl:when
                                      test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                      <span>
                                        <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataOd">
                                        <span>
                                          <xsl:text> od dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
                                        </span>
                                      </xsl:for-each>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                  <xsl:text> do dnia 2015-12-31 i odsetkami umownymi w wysokości czterokrotności stopy lombardowej NBP rocznie ale nie więcej niż w wysokości odsetek maksymalnych od dnia 2016-01-01 </xsl:text>
                                  <xsl:choose>
                                    <xsl:when
                                      test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                      <span>
                                        <xsl:text> do dnia zapłaty</xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dUgrataDo">
                                        <span>
                                          <xsl:text> do dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
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
                                    <xsl:when
                                      test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                      <span>
                                        <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataOd">
                                        <span>
                                          <xsl:text> od dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
                                        </span>
                                      </xsl:for-each>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                  <xsl:choose>
                                    <xsl:when
                                      test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                      <span>
                                        <xsl:text> do dnia zapłaty</xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataDo">
                                        <span>
                                          <xsl:text> do dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
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
                                    <xsl:when
                                      test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                      <span>
                                        <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataOd">
                                        <span>
                                          <xsl:text> od dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
                                        </span>
                                      </xsl:for-each>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                  <xsl:choose>
                                    <xsl:when
                                      test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                      <span>
                                        <xsl:text> do dnia zapłaty</xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataDo">
                                        <span>
                                          <xsl:text> do dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
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
                                    <xsl:when
                                      test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                      <span>
                                        <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataOd">
                                        <span>
                                          <xsl:text> od dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
                                        </span>
                                      </xsl:for-each>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                  <xsl:text> do dnia 2015-12-31 i odsetkami ustawowymi za opóźnienie od dnia 2016-01-01</xsl:text>
                                  <xsl:choose>
                                    <xsl:when
                                      test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                      <span>
                                        <xsl:text> do dnia zapłaty</xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataDo">
                                        <span>
                                          <xsl:text> do dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
                                        </span>
                                      </xsl:for-each>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                </span>
                              </xsl:when>
                              <xsl:when test="@czyUstawowe=10">
                                <span>
                                  <xsl:text>umownymi </xsl:text>
                                  <xsl:call-template name="stopaTemplate" />
                                  <xsl:text>  ale nie więcej niż w wysokości odsetek maksymalnych za opóźnienie </xsl:text>
                                  <xsl:choose>
                                    <xsl:when
                                      test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                      <span>
                                        <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataOd">
                                        <span>
                                          <xsl:text> od dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
                                        </span>
                                      </xsl:for-each>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                  <xsl:choose>
                                    <xsl:when
                                      test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                      <span>
                                        <xsl:text> do dnia zapłaty</xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataDo">
                                        <span>
                                          <xsl:text> do dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
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
                                    <xsl:when
                                      test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                      <span>
                                        <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataOd">
                                        <span>
                                          <xsl:text> od dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
                                        </span>
                                      </xsl:for-each>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                  <xsl:choose>
                                    <xsl:when
                                      test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                      <span>
                                        <xsl:text> do dnia zapłaty</xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataDo">
                                        <span>
                                          <xsl:text> do dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
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
                                    <xsl:when
                                      test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                      <span>
                                        <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataOd">
                                        <span>
                                          <xsl:text> od dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
                                        </span>
                                      </xsl:for-each>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                  <xsl:text> do dnia 2015-12-31 i odsetkami umownymi w wysokości czterokrotności stopy lombardowej NBP rocznie ale nie więcej niż w wysokości odsetek maksymalnych za opóźnienie od dnia 2016-01-01</xsl:text>
                                  <xsl:choose>
                                    <xsl:when
                                      test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                      <span>
                                        <xsl:text> do dnia zapłaty</xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataDo">
                                        <span>
                                          <xsl:text> do dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
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
                                    <xsl:when
                                      test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                      <span>
                                        <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataOd">
                                        <span>
                                          <xsl:text> od dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
                                        </span>
                                      </xsl:for-each>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                  <xsl:choose>
                                    <xsl:when
                                      test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                      <span>
                                        <xsl:text> do dnia zapłaty</xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataDo">
                                        <span>
                                          <xsl:text> do dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
                                        </span>
                                      </xsl:for-each>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                </span>
                              </xsl:when>
                              <xsl:when test="@czyUstawowe=14">
                                <span>
                                  <xsl:text>umownymi  </xsl:text>
                                  <xsl:call-template name="stopaTemplate" />
                                  <xsl:call-template name="okresTemplate" />
                                  <xsl:text> ale nie więcej niż w wysokości czterokrotności stopy lombardowej NBP rocznie </xsl:text>
                                  <xsl:choose>
                                    <xsl:when
                                      test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                      <span>
                                        <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataOd">
                                        <span>
                                          <xsl:text> od dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
                                        </span>
                                      </xsl:for-each>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                  <xsl:text> do dnia 2015-12-31 i odsetkami umownymi   </xsl:text>
                                  <xsl:call-template name="stopaTemplate" />
                                  <xsl:call-template name="okresTemplate" />
                                  <xsl:text> ale nie więcej niż w wysokości odsetek maksymalnych za opóźnienie od dnia 2016-01-01</xsl:text>
                                  <xsl:choose>
                                    <xsl:when
                                      test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                      <span>
                                        <xsl:text> do dnia zapłaty</xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataDo">
                                        <span>
                                          <xsl:text> do dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
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
                                    <xsl:when
                                      test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                      <span>
                                        <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataOd">
                                        <span>
                                          <xsl:text> od dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
                                        </span>
                                      </xsl:for-each>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                  <xsl:choose>
                                    <xsl:when
                                      test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                      <span>
                                        <xsl:text> do dnia zapłaty</xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataDo">
                                        <span>
                                          <xsl:text> do dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
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
                                    <xsl:when
                                      test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                      <span>
                                        <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataOd">
                                        <span>
                                          <xsl:text> od dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
                                        </span>
                                      </xsl:for-each>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                  <xsl:text> do dnia 2015-12-31 i odsetkami ustawowymi za opóźnienie w transakcjach handlowych od dnia 2016-01-01</xsl:text>
                                  <xsl:choose>
                                    <xsl:when
                                      test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                      <span>
                                        <xsl:text> do dnia zapłaty</xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataDo">
                                        <span>
                                          <xsl:text> do dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
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
                                    <xsl:when
                                      test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
                                      <span>
                                        <xsl:text> od dnia wniesienia pozwu </xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataOd">
                                        <span>
                                          <xsl:text> od dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
                                        </span>
                                      </xsl:for-each>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                  <xsl:text> do dnia 2015-12-31 i odsetkami ustawowymi za opóźnienie w transakcjach handlowych od dnia 2016-01-01</xsl:text>
                                  <xsl:choose>
                                    <xsl:when
                                      test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
                                      <span>
                                        <xsl:text> do dnia zapłaty</xsl:text>
                                      </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:for-each select="@dataDo">
                                        <span>
                                          <xsl:text> do dnia </xsl:text>
                                        </span>
                                        <span>
                                          <xsl:call-template name="dataTemplate" />
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
                              <xsl:when test="@czyUstawowe=100">
                                <span>
                                  <xsl:text>ustawowymi za opóźnienie od dnia uprawomocnienia nakazu zapłaty do dnia zapłaty</xsl:text>
                                </span>
                              </xsl:when>
                            </xsl:choose>
                            <xsl:if
                              test="@kwota!=0 and @czyUstawowe != 18">
                              <xsl:for-each select="@kwota">
                                <span>
                                  <xsl:text> od kwoty </xsl:text>
                                </span>
                                <span>
                                  <xsl:value-of
                                    select="format-number(number(translate(translate(string(.), '  ',''),',','.')), '### ##0,00##', 'european')" />
                                </span>
                                <span>
                                  <xsl:text> </xsl:text>
                                </span>
                                <span>
                                  <xsl:value-of select="../../../@waluta" />
                                </span>
                              </xsl:for-each>
                            </xsl:if>
                          </xsl:for-each>
                        </xsl:for-each>
                      </xsl:if>
                    </td>
                  </tr>
                </xsl:for-each>
              </xsl:for-each>
            </xsl:for-each>
          </tbody>
        </table>
      </div>
      <div>
        <span>
          <xsl:text>II. Ustalenie i ściągnięcie wraz z egzekwowanymi roszczeniami kosztów postępowania egzekucyjnego.</xsl:text>
        </span>
      </div>
      <xsl:if
        test="curr:WniosekEgzekucyjny/curr:KosztyZastepstwa/@zasadzenie=1 or curr:WniosekEgzekucyjny/curr:InneKoszty/@zasadzenie=1">
        <div>
          <span>
            <xsl:text>III. Przyznanie i ściągnięcie </xsl:text>
          </span>
          <xsl:if test="curr:WniosekEgzekucyjny/curr:KosztyZastepstwa/@zasadzenie=1">
            <span>
              <xsl:text>kosztów zastępstwa</xsl:text>
            </span>
          </xsl:if>
          <span>
            <xsl:text> w postępowaniu egzekucyjnym </xsl:text>
          </span>
          <xsl:if test="curr:WniosekEgzekucyjny/curr:KosztyZastepstwa/@zasadzenie=1">
            <xsl:if test="curr:WniosekEgzekucyjny/curr:KosztyZastepstwa/@wgNorm=1">
              <span>
                <xsl:text>według norm przepisanych</xsl:text>
              </span>
            </xsl:if>
            <span>
              <xsl:text> </xsl:text>
            </span>
          </xsl:if>
          <xsl:if
            test="curr:WniosekEgzekucyjny/curr:KosztyZastepstwa/@wgNorm=0 and curr:WniosekEgzekucyjny/curr:KosztyZastepstwa/@wartosc &gt; 0">
            <xsl:if test="curr:WniosekEgzekucyjny/curr:KosztyZastepstwa/@zasadzenie=1">
              <span>
                <xsl:text>w kwocie </xsl:text>
              </span>
              <xsl:for-each
                select="curr:WniosekEgzekucyjny">
                <xsl:for-each select="curr:KosztyZastepstwa">
                  <xsl:for-each select="@wartosc">
                    <span>
                      <xsl:text> </xsl:text>
                    </span>
                    <span>
                      <xsl:value-of
                        select="format-number(number(translate(translate(string(.), '  ',''),',','.')), '### ##0,00##', 'european')" />
                    </span>
                    <span>
                      <xsl:text> zł</xsl:text>
                    </span>
                  </xsl:for-each>
                  <xsl:for-each
                    select="@opis">
                    <span>
                      <xsl:text> </xsl:text>
                    </span>
                    <span>
                      <xsl:value-of select="string(.)" />
                    </span>
                  </xsl:for-each>
                </xsl:for-each>
              </xsl:for-each>
            </xsl:if>
          </xsl:if>
          <span>
            <xsl:text> </xsl:text>
          </span>
          <xsl:if
            test="curr:WniosekEgzekucyjny/curr:KosztyZastepstwa/@zasadzenie=1 and curr:WniosekEgzekucyjny/curr:InneKoszty/@zasadzenie=1">
            <span>
              <xsl:text>oraz</xsl:text>
            </span>
          </xsl:if>
          <span>
            <xsl:text> </xsl:text>
          </span>
          <xsl:if test="curr:WniosekEgzekucyjny/curr:InneKoszty/@zasadzenie=1">
            <span>
              <xsl:text> innych kosztów w kwocie </xsl:text>
            </span>
            <xsl:for-each select="curr:WniosekEgzekucyjny">
              <xsl:for-each select="curr:InneKoszty">
                <xsl:for-each select="@wartosc">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <span>
                    <xsl:value-of
                      select="format-number(number(translate(translate(string(.), '  ',''),',','.')), '### ##0,00##', 'european')" />
                  </span>
                  <span>
                    <xsl:text> zł</xsl:text>
                  </span>
                </xsl:for-each>
                <span>
                  <xsl:text> </xsl:text>
                </span>
                <xsl:for-each select="@opis">
                  <span>
                    <xsl:text>(</xsl:text>
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
          </xsl:if>
        </div>
      </xsl:if>
      <br />
      <xsl:if
        test="curr:WniosekEgzekucyjny/curr:ZleceniePoszukiwaniaMajatku=1">
        <span>
          <xsl:text>Wierzyciel(e) wnosi(szą), aby tutejszy Komornik w trybie art.801[2] K.p.c podjął czynności mające na celu ustalenie majątku dłużnika, z którego może być prowadzona egzekucja.</xsl:text>
        </span>
      </xsl:if>
      <br />
      <br />
      <xsl:if
        test="curr:WniosekEgzekucyjny/curr:ZlecenieProwadzeniaArt85=1">
        <span>
          <xsl:text>Wierzyciel(e) oświadcza(ją), że dokonuje(ą) wyboru Komornika na podstawie przepisu art. 10 ust.3 ustawy z dnia 22 marca 2018 r. o komornikach sądowych i egzekucji (Dz.U.2018.771 ze zm.).</xsl:text>
        </span>
        <br />
      </xsl:if>
      <br />
      <br />
      <xsl:for-each
        select="curr:WniosekEgzekucyjny">
        <xsl:for-each select="curr:InformacjeDodatkowe">
          <xsl:apply-templates />
        </xsl:for-each>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>