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
  <xsl:param name="peselePelnomocReprezent" />
  <xsl:variable name="XML" select="/" />
  <xsl:decimal-format name="format1" grouping-separator=" " decimal-separator="," />
  <xsl:template match="/">
    <html>
      <head>
        <title />
      </head>
      <body style="margin-left=0.6in; margin-right=0.6in; margin-top=0.79in; margin-bottom=0.79in">
        <xsl:for-each select="$XML">
          <br />
          <div align="right">
            <xsl:for-each select="curr:DokumentEPU">
              <xsl:for-each select="curr:DataZlozenia">
                <span>
                  <xsl:text>Data złożenia </xsl:text>
                </span>
                <span>
                  <xsl:value-of
                    select="format-number(number(substring(string(string(string(.))), 1, 4)), '0000', 'format1')" />
                  <xsl:text>-</xsl:text>
                  <xsl:value-of
                    select="format-number(number(substring(string(string(.)), 6, 2)), '00', 'format1')" />
                  <xsl:text>-</xsl:text>
                  <xsl:value-of
                    select="format-number(number(substring(string(string(.)), 9, 2)), '00', 'format1')" />
                </span>
              </xsl:for-each>
            </xsl:for-each>
          </div>
          <div>
            <xsl:for-each select="curr:DokumentEPU">
              <xsl:for-each select="curr:Sygnatura">
                <span>
                  <xsl:text>Sygnatura akt </xsl:text>
                </span>
                <xsl:apply-templates />
              </xsl:for-each>
            </xsl:for-each>
          </div>
          <br />
          <pre
            style="font-family:Times New Roman; font-size:medium; ">
            <div style="font-family:Times New Roman; font-size:medium; ">
              <xsl:for-each select="curr:DokumentEPU">
                <xsl:for-each select="curr:OsobaSkladajaca">
                  <span style="text-decoration:underline; ">
                    <xsl:text>Osoba składająca</xsl:text>
                  </span>
                  <br />
                  <xsl:for-each
                    select="curr:Osoba">
                    <xsl:for-each select="curr:Imie">
                      <xsl:apply-templates />
                      <span>
                        <xsl:text> </xsl:text>
                      </span>
                    </xsl:for-each>
                    <xsl:for-each
                      select="curr:Nazwisko">
                      <xsl:apply-templates />
                      <span>
                        <xsl:text> </xsl:text>
                      </span>
                    </xsl:for-each>
                    <!--<xsl:if
                    test="contains($peselePelnomocReprezent, curr:PESEL)=false">
                      <xsl:if test="string-length( curr:PESEL )&gt;0">
                        <xsl:for-each select="curr:PESEL">
                          <span>
                            <xsl:text> PESEL </xsl:text>
                          </span>
                          <xsl:apply-templates />
                        </xsl:for-each>
                      </xsl:if>
                    </xsl:if>-->
                    <br />
                    <xsl:for-each
                      select="curr:stanowisko">
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
                  <xsl:for-each
                    select="curr:Adres">
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
                    </xsl:for-each>
                    <xsl:for-each
                      select="@nr_mieszkania">
                      <span>
                        <xsl:text>/</xsl:text>
                      </span>
                      <span>
                        <xsl:value-of select="string(.)" />
                      </span>
                    </xsl:for-each>
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
                            select="concat(substring( . , 1 ,2 ),'-',substring( . , 3 , 3 ))" />
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
                </xsl:for-each>
              </xsl:for-each>
            </div>
          </pre>
          <br />
          <xsl:if
            test="curr:DokumentEPU/curr:Rodzaj=13">
            <span style="text-decoration:underline; ">
              <xsl:text />
            </span>
          </xsl:if>
          <xsl:if
            test="curr:DokumentEPU/curr:Rodzaj!=5 and curr:DokumentEPU/curr:Rodzaj!=13">
            <span style="text-decoration:underline; ">
              <xsl:text>w imieniu</xsl:text>
            </span>
          </xsl:if>
          <xsl:if
            test="curr:DokumentEPU/curr:Rodzaj=5">
            <span style="text-decoration:underline; ">
              <xsl:text>Dotyczy</xsl:text>
            </span>
          </xsl:if>
          <br />
          <xsl:for-each
            select="curr:DokumentEPU">
            <xsl:for-each select="curr:ListaPowodow">
              <xsl:for-each select="curr:Powod">
                <xsl:for-each select="curr:OsobaFizyczna">
                  <xsl:for-each select="curr:Imie">
                    <xsl:apply-templates />
                    <span>
                      <xsl:text> </xsl:text>
                    </span>
                  </xsl:for-each>
                  <xsl:for-each
                    select="curr:Nazwisko">
                    <xsl:apply-templates />
                  </xsl:for-each>
                </xsl:for-each>
                <span>
                  <xsl:text> </xsl:text>
                </span>
                <xsl:for-each select="curr:Instytucja">
                  <xsl:for-each select="curr:Nazwa">
                    <xsl:apply-templates />
                  </xsl:for-each>
                  <xsl:for-each
                    select="curr:Siedziba">
                    <xsl:apply-templates />
                  </xsl:for-each>
                </xsl:for-each>
                <br />
              </xsl:for-each>
            </xsl:for-each>
          </xsl:for-each>
          <xsl:for-each
            select="curr:DokumentEPU">
            <xsl:for-each select="curr:ListaPozwanych">
              <xsl:for-each select="curr:Pozwany">
                <xsl:for-each select="curr:OsobaFizyczna">
                  <xsl:for-each select="curr:Imie">
                    <xsl:apply-templates />
                    <span>
                      <xsl:text>  </xsl:text>
                    </span>
                  </xsl:for-each>
                  <xsl:for-each
                    select="curr:Nazwisko">
                    <xsl:apply-templates />
                  </xsl:for-each>
                </xsl:for-each>
                <xsl:for-each
                  select="curr:Instytucja">
                  <xsl:for-each select="curr:Nazwa">
                    <xsl:apply-templates />
                  </xsl:for-each>
                  <xsl:for-each
                    select="curr:Siedziba">
                    <xsl:apply-templates />
                  </xsl:for-each>
                </xsl:for-each>
                <br />
              </xsl:for-each>
            </xsl:for-each>
          </xsl:for-each>
          <br />
          <div
            align="center">
            <xsl:for-each select="curr:DokumentEPU">
              <xsl:if test="curr:Rodzaj=3">
                <xsl:for-each select="curr:Rodzaj">
                  <span style="font-weight:bold; ">
                    <xsl:text>P I S M O </xsl:text>
                  </span>
                </xsl:for-each>
              </xsl:if>
              <xsl:if
                test="curr:Rodzaj=4">
                <xsl:for-each select="curr:Rodzaj">
                  <span style="font-weight:bold; ">
                    <xsl:text>W N I O S E K</xsl:text>
                  </span>
                </xsl:for-each>
              </xsl:if>
              <xsl:if
                test="curr:Rodzaj=5">
                <xsl:for-each select="curr:Rodzaj">
                  <span style="font-weight:bold; ">
                    <xsl:text>Odpowiedź na wezwanie</xsl:text>
                  </span>
                  <span>
                    <xsl:text>  </xsl:text>
                  </span>
                  <br />
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <span style="font-weight:bold; ">
                    <xsl:text>do uzupełnienia adresu</xsl:text>
                  </span>
                </xsl:for-each>
              </xsl:if>
              <xsl:if
                test="curr:Rodzaj=15">
                <xsl:for-each select="curr:Rodzaj">
                  <span style="font-weight:bold; ">
                    <xsl:text>W N I O S E K   O   K L A U Z U L Ę   N A   R Z E C Z   N A S T Ę P C Y   P R A W N E G O</xsl:text>
                  </span>
                </xsl:for-each>
              </xsl:if>
              <xsl:if
                test="curr:Rodzaj=16">
                <xsl:for-each select="curr:Rodzaj">
                  <span style="font-weight:bold; ">
                    <xsl:text>W N I O S E K   O   W Y D A N I E   D A L S Z E G O   T Y T U Ł U   W Y K O N A W C Z E G O</xsl:text>
                  </span>
                </xsl:for-each>
              </xsl:if>
              <xsl:if
                test="curr:Rodzaj=17">
                <xsl:for-each select="curr:Rodzaj">
                  <span style="font-weight:bold; ">
                    <xsl:text>W N I O S E K   O   S P R O S T O W A N I E</xsl:text>
                  </span>
                </xsl:for-each>
              </xsl:if>
              <xsl:if
                test="curr:Rodzaj=18">
                <xsl:for-each select="curr:Rodzaj">
                  <span style="font-weight:bold; ">
                    <xsl:text>W N I O S E K   O   U D Z I E L E N I E   K O D U   D O S T Ę P U</xsl:text>
                  </span>
                </xsl:for-each>
              </xsl:if>
              <xsl:if
                test="curr:Rodzaj=19">
                <xsl:for-each select="curr:Rodzaj">
                  <span style="font-weight:bold; ">
                    <xsl:text>W N I O S E K   O   R E A S U M P C J Ę</xsl:text>
                  </span>
                </xsl:for-each>
              </xsl:if>
              <xsl:if
                test="curr:Rodzaj=20">
                <xsl:for-each select="curr:Rodzaj">
                  <span style="font-weight:bold; ">
                    <xsl:text>O D S Z K O D O W A N I E / K A R A   O D   O P E R A T O R A   P O C Z T O W E G O</xsl:text>
                  </span>
                </xsl:for-each>
              </xsl:if>
              <xsl:if
                test="curr:Rodzaj=21">
                <xsl:for-each select="curr:Rodzaj">
                  <span style="font-weight:bold; ">
                    <xsl:text>C O F N I Ę C I E   P O W Ó D Z T W A   W   C A Ł O Ś C I</xsl:text>
                  </span>
                </xsl:for-each>
              </xsl:if>
            </xsl:for-each>
          </div>
          <br />
          <xsl:for-each
            select="curr:DokumentEPU">
            <xsl:for-each select="curr:Przedmiot">
              <span>
                <xsl:text>Przedmiot: </xsl:text>
              </span>
              <span style="font-weight:bold; ">
                <xsl:apply-templates />
              </span>
              <span>
                <xsl:text> </xsl:text>
              </span>
            </xsl:for-each>
          </xsl:for-each>
          <br />
          <br />
          <xsl:if
            test="curr:DokumentEPU/curr:Rodzaj=5">
            <xsl:for-each select="curr:DokumentEPU">
              <xsl:for-each select="curr:ListaPozwanych">
                <xsl:for-each select="curr:Pozwany">
                  <span>
                    <xsl:text>Podany adres dotyczy:</xsl:text>
                  </span>
                  <br />
                  <xsl:for-each
                    select="curr:OsobaFizyczna">
                    <xsl:for-each select="curr:Imie">
                      <xsl:apply-templates />
                      <span>
                        <xsl:text>  </xsl:text>
                      </span>
                    </xsl:for-each>
                    <xsl:for-each
                      select="curr:Imie2">
                      <xsl:apply-templates />
                      <span>
                        <xsl:text> </xsl:text>
                      </span>
                    </xsl:for-each>
                    <xsl:for-each
                      select="curr:Nazwisko">
                      <xsl:apply-templates />
                    </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each
                    select="curr:Instytucja">
                    <xsl:for-each select="curr:Nazwa">
                      <xsl:apply-templates />
                    </xsl:for-each>
                    <xsl:for-each
                      select="curr:Siedziba">
                      <xsl:apply-templates />
                    </xsl:for-each>
                  </xsl:for-each>
                  <br />
                  <xsl:for-each
                    select="curr:Adres">
                    <br />
                    <xsl:for-each select="@ulica">
                      <span>
                        <xsl:text>Ulica:    </xsl:text>
                      </span>
                      <span>
                        <xsl:value-of select="string(.)" />
                      </span>
                      <span>
                        <xsl:text> </xsl:text>
                      </span>
                    </xsl:for-each>
                    <br />
                    <xsl:for-each
                      select="@nr_domu">
                      <span>
                        <xsl:text>Nr domu:    </xsl:text>
                      </span>
                      <span>
                        <xsl:value-of select="string(.)" />
                      </span>
                    </xsl:for-each>
                    <br />
                    <xsl:for-each
                      select="@nr_mieszkania">
                      <span>
                        <xsl:text>Nr lokalu:    </xsl:text>
                      </span>
                      <span>
                        <xsl:value-of select="string(.)" />
                      </span>
                    </xsl:for-each>
                    <br />
                    <xsl:if
                      test="string-length( @kod )!=5">
                      <xsl:for-each select="@kod">
                        <span>
                          <xsl:text>Kod:    </xsl:text>
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
                          <xsl:text>Kod:   </xsl:text>
                        </span>
                        <span>
                          <xsl:value-of
                            select="concat(substring( . , 1 ,2 ),'-',substring( . , 3 , 3 ))" />
                        </span>
                      </xsl:for-each>
                    </xsl:if>
                    <br />
                    <xsl:for-each
                      select="@miejscowosc">
                      <span>
                        <xsl:text>Miejscowość:    </xsl:text>
                      </span>
                      <span>
                        <xsl:value-of select="string(.)" />
                      </span>
                    </xsl:for-each>
                    <br />
                    <xsl:for-each
                      select="@poczta">
                      <span>
                        <xsl:text>Poczta:    </xsl:text>
                      </span>
                      <span>
                        <xsl:value-of select="string(.)" />
                      </span>
                    </xsl:for-each>
                    <br />
                    <xsl:for-each
                      select="@wojewodztwo">
                      <span>
                        <xsl:text>Województwo:    </xsl:text>
                      </span>
                      <span>
                        <xsl:value-of select="string(.)" />
                      </span>
                    </xsl:for-each>
                    <br />
                    <br />
                  </xsl:for-each>
                </xsl:for-each>
              </xsl:for-each>
            </xsl:for-each>
          </xsl:if>
          <br />
          <pre
            style="font-family:Times New Roman; font-size:medium; ">
            <div style="font-family:Times New Roman; font-size:medium; " align="justify">
              <xsl:for-each select="curr:DokumentEPU">
                <xsl:for-each select="curr:Tresc">
                  <xsl:apply-templates />
                </xsl:for-each>
              </xsl:for-each>
            </div>
          </pre>
          <br />
          <br />
          <br />
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>