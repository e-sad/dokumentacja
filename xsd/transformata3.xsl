<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:curr="http://www.currenda.pl/epu" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:link="http://www.xbrl.org/2003/linkbase" xmlns:xbrldi="http://xbrl.org/2006/xbrldi" xmlns:xbrli="http://www.xbrl.org/2003/instance" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:altova="http://www.altova.com" version="1.0" exclude-result-prefixes="curr fn link xbrldi xbrli xdt xlink xs xsd xsi">
  <xsl:output version="4.0" method="html" indent="no" encoding="UTF-8" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd" />
  <xsl:param name="SV_OutputFormat" select="'HTML'" />
  <xsl:variable name="XML" select="/" />
  <xsl:decimal-format name="european" decimal-separator="," grouping-separator=" " />
  <xsl:template name="stopaTemplate">
    <xsl:for-each select="@stopa">
      <span>
        <xsl:text> </xsl:text>
      </span>
      <span>
        <xsl:value-of select="format-number(number(translate(string(.), '  ','')), '### ##0,00##', 'european')" />
      </span>
      <span>
        <xsl:text> %</xsl:text>
      </span>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="dataTemplate">
    <!-- <xsl:value-of select="substring(replace(string(.), '(\d{2})-(\d{2})-(\d{4})', '$3-$2-$1'), 0, 11)"/>-->
    <xsl:choose>
      <xsl:when test="substring(string(.),3,1) = '-' and string-length(string(.)) = 10">
        <xsl:value-of select="substring(string(.),7,4)" />
        <xsl:text>-</xsl:text>
        <xsl:value-of select="substring(string(.),4,2)" />
        <xsl:text>-</xsl:text>
        <xsl:value-of select="substring(string(.),1,2)" />
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
    <html>
      <head>
        <title />
        <style type="text/css">
                    span.spanStyle1{ font-family:"3 of 9 Barcode"; font-size:large;  }
				</style>
      </head>
      <body style="margin-left=0.6in; margin-right=0.6in; margin-top=0.79in; margin-bottom=0.79in">
        <xsl:for-each select="$XML">
          <br />
          <div align="right">
            <xsl:if test="string-length(curr:NakazEPU/@KOD )&gt;0">
              <div align="right">
                <span class="spanStyle1">
                  <xsl:value-of select="concat( '*',curr:NakazEPU/@KOD,'*')" />
                </span>
              </div>
            </xsl:if>
            <xsl:for-each select="curr:NakazEPU">
              <xsl:for-each select="@KOD">
                <span>
                  <xsl:text>KOD  </xsl:text>
                </span>
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
              </xsl:for-each>
            </xsl:for-each>
          </div>
          <br />
          <div>
            <span style="font-weight:bold; ">
              <xsl:text> Sygnatura akt</xsl:text>
            </span>
            <span>
              <xsl:text> </xsl:text>
            </span>
            <xsl:for-each select="curr:NakazEPU">
              <xsl:for-each select="curr:Sygnatura">
                <span style="font-weight:bold; ">
                  <xsl:text> </xsl:text>
                </span>
                <span style="font-weight:bold; ">
                  <xsl:apply-templates />
                </span>
              </xsl:for-each>
            </xsl:for-each>
          </div>
          <div>
            <h2 align="center">
              <span style="font-weight:bold; ">
                <xsl:text>N A K A Z    Z A P Ł A T Y </xsl:text>
              </span>
            </h2>
          </div>
          <div>
            <h3 align="center">
              <span>
                <xsl:text>W  POSTĘPOWANIU  UPOMINAWCZYM</xsl:text>
              </span>
            </h3>
          </div>
          <div align="right">
            <xsl:for-each select="curr:NakazEPU">
              <xsl:for-each select="@dataNakazu">
                <span>
                  <xsl:text>Data wydania </xsl:text>
                </span>
                <span>
                  <xsl:value-of select="string(.)" />
                </span>
              </xsl:for-each>
            </xsl:for-each>
          </div>
          <br />
          <div align="left">
            <xsl:for-each select="curr:NakazEPU">
              <xsl:for-each select="curr:SadEPU">
                <xsl:for-each select="curr:Nazwa">
                  <xsl:apply-templates />
                </xsl:for-each>
                <xsl:for-each select="curr:Wydzial">
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <xsl:apply-templates />
                </xsl:for-each>
              </xsl:for-each>
              <br />
              <xsl:for-each select="curr:WSkladzie">
                <span>
                  <xsl:text> </xsl:text>
                </span>
                <xsl:apply-templates />
              </xsl:for-each>
              <br />
              <xsl:for-each select="curr:Sedzia">
                <span>
                  <xsl:text>           </xsl:text>
                </span>
                <xsl:apply-templates />
              </xsl:for-each>
            </xsl:for-each>
            <span>
              <xsl:text> </xsl:text>
            </span>
          </div>
          <!--Wycofane ze zmiany 3.1-->
          <!--<div align="left">
						<xsl:for-each select="curr:NakazEPU">
				
							<xsl:for-each select="curr:Sedzia">
								<span>
									<xsl:text>           </xsl:text>
								</span>
								<xsl:apply-templates/>
							</xsl:for-each>
							<xsl:text>&#xA0;</xsl:text>
							<xsl:for-each select="curr:SadEPU">
								<xsl:for-each select="curr:Nazwa">
									<span>
										<xsl:text> </xsl:text>
									</span>
									<xsl:apply-templates/>
								</xsl:for-each>
								 <xsl:for-each select="curr:Wydzial">
                  <span>

                    <xsl:text> </xsl:text>
                  </span>

                  <xsl:apply-templates />
                </xsl:for-each>
              </xsl:for-each>
              <br />

              <xsl:for-each select="curr:WSkladzie">
                <span>

                  <xsl:text> </xsl:text>
                </span>

                <xsl:apply-templates />
				</xsl:for-each>
							<br/>
						</xsl:for-each>
						<span>
							<xsl:text> </xsl:text>
						</span>
					</div>
-->
          <div>
            <xsl:for-each select="curr:NakazEPU">
              <xsl:for-each select="curr:NaPosiedzeniu">
                <xsl:apply-templates />
              </xsl:for-each>
              <span>
                <xsl:text> </xsl:text>
              </span>
              <xsl:for-each select="curr:DataWplywu">
                <span>
                  <xsl:text> </xsl:text>
                </span>
                <xsl:apply-templates />
              </xsl:for-each>
              <span>
                <xsl:text> </xsl:text>
              </span>
              <xsl:for-each select="curr:Przez">
                <xsl:apply-templates />
              </xsl:for-each>
            </xsl:for-each>
          </div>
          <div>
            <xsl:for-each select="curr:NakazEPU">
              <xsl:for-each select="curr:ListaPowodow">
                <xsl:for-each select="curr:Powod">
                  <xsl:for-each select="curr:Nazwa">
                    <span style="font-weight:bold; ">
                      <xsl:apply-templates />
                    </span>
                    <span style="font-weight:bold; ">
                      <xsl:text> </xsl:text>
                    </span>
                  </xsl:for-each>
                </xsl:for-each>
                <br />
              </xsl:for-each>
            </xsl:for-each>
          </div>
          <div>
            <xsl:for-each select="curr:NakazEPU">
              <xsl:for-each select="curr:NakazujeAby">
                <xsl:apply-templates />
              </xsl:for-each>
            </xsl:for-each>
          </div>
          <div>
            <xsl:for-each select="curr:NakazEPU">
              <xsl:for-each select="curr:ListaPozwanych">
                <xsl:for-each select="curr:Pozwany">
                  <xsl:for-each select="curr:Nazwa">
                    <span style="font-weight:bold; ">
                      <xsl:apply-templates />
                    </span>
                    <span style="font-weight:bold; ">
                      <xsl:text> </xsl:text>
                    </span>
                  </xsl:for-each>
                </xsl:for-each>
              </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="curr:NakazEPU">
              <br />
              <xsl:for-each select="curr:ZaplacilPowodowi">
                <xsl:apply-templates />
              </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="curr:NakazEPU">
              <xsl:for-each select="curr:ListaRoszczen">
                <xsl:for-each select="curr:Roszczenie">
                  <br />
                  <xsl:if test="@typ&gt;=10">
                    <xsl:for-each select="@opisy">
                      <br />
                      <span style="font-weight:bold; ">
                        <xsl:value-of select="string(.)" />
                      </span>
                      <span style="font-weight:bold; ">
                        <xsl:text> </xsl:text>
                      </span>
                    </xsl:for-each>
                  </xsl:if>
                  <!-- <xsl:if test="@typ&lt;10 or (not(name(@typ)) or name(@typ)=')"> -->
                  <xsl:for-each select="@opisKwoty">
                    <span>
                      <xsl:value-of select="string(.)" />
                    </span>
                    <span>
                      <xsl:text> </xsl:text>
                    </span>
                  </xsl:for-each>
                  <!-- </xsl:if> -->
                  <xsl:if test="@typ&gt;=10">
                    <xsl:for-each select="@wartosc">
                      <span style="font-weight:bold; ">
                        <xsl:value-of select="format-number(number(translate(string(.), '  ','')), '### ##0,00', 'european')" />
                      </span>
                    </xsl:for-each>
                  </xsl:if>
                  <xsl:if test="@typ&lt;10 or (not(name(@typ)) or name(@typ)='')">
                    <xsl:for-each select="@wartosc">
                      <span>
                        <xsl:text> </xsl:text>
                      </span>
                      <span>
                        <xsl:value-of select="format-number(number(translate(string(.), '  ','')), '### ##0,00', 'european')" />
                      </span>
                    </xsl:for-each>
                  </xsl:if>
                  <xsl:if test="@typ&gt;=10">
                    <xsl:for-each select="@waluta">
                      <span style="font-weight:bold; ">
                        <xsl:text> </xsl:text>
                      </span>
                      <span style="font-weight:bold; ">
                        <xsl:value-of select="string(.)" />
                      </span>
                      <span style="font-weight:bold; ">
                        <xsl:text> </xsl:text>
                      </span>
                    </xsl:for-each>
                  </xsl:if>
                  <xsl:if test="@typ&lt;10 or (not(name(@typ)) or name(@typ)='')">
                    <xsl:for-each select="@waluta">
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
                  <xsl:if test="@typ&gt;=10">
                    <xsl:for-each select="@wartoscSlownie">
                      <span style="font-weight:bold; ">
                        <xsl:text>(słownie: </xsl:text>
                      </span>
                      <span style="font-weight:bold; ">
                        <xsl:value-of select="string(.)" />
                      </span>
                      <span>
                        <xsl:text>)</xsl:text>
                      </span>
                    </xsl:for-each>
                  </xsl:if>
                  <xsl:if test="@typ&lt;10 or (not(name(@typ)) or name(@typ)='')">
                    <xsl:for-each select="@wartoscSlownie">
                      <span>
                        <xsl:text>(słownie: </xsl:text>
                      </span>
                      <span>
                        <xsl:value-of select="string(.)" />
                      </span>
                      <span>
                        <xsl:text>)</xsl:text>
                      </span>
                    </xsl:for-each>
                  </xsl:if>
                  <xsl:for-each select="@opis">
                    <xsl:if test="string-length(@opis)=0">
                      <span>
                        <xsl:text> </xsl:text>
                      </span>
                      <span>
                        <xsl:value-of select="string(.)" />
                      </span>
                    </xsl:if>
                  </xsl:for-each>
                  <span>
                    <xsl:text> </xsl:text>
                  </span>
                  <xsl:if test="@odsetki=1">
                    <xsl:for-each select="@odsetki">
                      <span>
                        <xsl:text>z odsetkami: </xsl:text>
                      </span>
                      <br />
                    </xsl:for-each>
                  </xsl:if>
                  <xsl:for-each select="curr:Odsetki[../@odsetki=1]">
                    <xsl:for-each select="curr:OkresOdsetkowy">
                      <!--	 <xsl:if test="@czyUstawowe=0 or @czyUstawowe=1 or @czyUstawowe=2 or @czyUstawowe=3" >
                      <xsl:choose>
                        <xsl:when test="@czyUstawowe=0">
                          <xsl:for-each select="@czyUstawowe">
                            <span>
                              <xsl:text>ustawowymi</xsl:text>
                            </span>
                          </xsl:for-each>
                        </xsl:when>
                        <xsl:when test="@czyUstawowe=1 or @czyUstawowe=2">
                          <span>
                            <xsl:text>umownymi</xsl:text>
                          </span>
                        </xsl:when>
                        <xsl:when test="@czyUstawowe=3">
                          <span>
                            <xsl:text>umownymi w wysokości czterokrotności stopy lombardowej NBP</xsl:text>
                          </span>
                        </xsl:when>
                      </xsl:choose>
                      <xsl:if test="@czyUstawowe=1 or @czyUstawowe=2">
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
                      </xsl:if>
                      <xsl:if test="@okres=0">
                        <xsl:for-each select="@okres">
                          <span>
                            <xsl:text> rocznie</xsl:text>
                          </span>
                        </xsl:for-each>
                      </xsl:if>
                      <xsl:if test="@okres=1">
                        <xsl:for-each select="@okres">
                          <span>
                            <xsl:text> kwartalnie</xsl:text>
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
                      <xsl:if test="@czyUstawowe=2">
                        <span>
                          <xsl:text> ale nie więcej niż czterokrotność stopy lombardowej NBP</xsl:text>
                        </span>
                      </xsl:if>
                      <xsl:if test="name(@dataDo)">
                        <xsl:for-each select="@dataOd">
                          <span>
                            <xsl:text> od dnia </xsl:text>
                          </span>
                          <span>
                            <xsl:value-of select="string(.)" />
                          </span>
                        </xsl:for-each>
                      </xsl:if>
                      <xsl:if test="(not(name(@dataDo)) or name(@dataDo)='')">
                        <xsl:for-each select="@dataOd">
                          <span>
                            <xsl:text> od dnia </xsl:text>
                          </span>
                          <span>
                            <xsl:value-of select="string(.)" />
                          </span>
                          <span>
                            <xsl:text> do dnia zapłaty</xsl:text>
                          </span>
                        </xsl:for-each>
                      </xsl:if>



                      <xsl:for-each select="@dataDo">
                        <span>
                          <xsl:text> do dnia </xsl:text>
                        </span>
                        <span>
                          <xsl:value-of select="string(.)" />
                        </span>
                      </xsl:for-each>
                    </xsl:if>-->
                      <xsl:choose>
                        <xsl:when test="@czyUstawowe=0">
                          <span>
                            <xsl:text>ustawowymi</xsl:text>
                            <xsl:choose>
                              <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
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
                              <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
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
                            <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
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
                            <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
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
                            <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
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
                            <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
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
                            <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
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
                            <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
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
                              <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
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
                              <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
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
                              <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
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
                              <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
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
                              <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
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
                              <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
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
                                    <xsl:text> od dnia </xsl:text>
                                  </span>
                                  <span>
                                    <xsl:call-template name="dataTemplate" />
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
                              <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
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
                              <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
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
                              <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
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
                              <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
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
                                    <xsl:text> od dnia </xsl:text>
                                  </span>
                                  <span>
                                    <xsl:call-template name="dataTemplate" />
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
                              <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
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
                              <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
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
                              <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
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
                              <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
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
                              <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
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
                              <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
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
                              <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
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
                              <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
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
                              <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
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
                              <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
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
                              <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
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
                              <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
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
                              <xsl:when test="@odWniesienia='1' or boolean(@dataOd)=false or @dataOd = ''">
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
                              <xsl:when test="@doZaplaty='1' or boolean(@dataDo)=false or @dataDo = ''">
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
                      </xsl:choose>
                      <xsl:if test="@kwota!=0 and @czyUstawowe != 18">
                        <xsl:for-each select="@kwota">
                          <span>
                            <xsl:text> od kwoty </xsl:text>
                          </span>
                          <span>
                            <xsl:value-of select="format-number(number(translate(string(.), '  ','')), '### ##0,00', 'european')" />
                          </span>
                          <span>
                            <xsl:text> </xsl:text>
                          </span>
                          <span>
                            <xsl:value-of select="../../../@waluta" />
                          </span>
                        </xsl:for-each>
                      </xsl:if>
                      <xsl:if test="count(following-sibling::curr:OkresOdsetkowy)&gt;0">
                        <span>
                          <xsl:text>, </xsl:text>
                          <br />
                        </span>
                      </xsl:if>
                    </xsl:for-each>
                  </xsl:for-each>
                </xsl:for-each>
                <br />
              </xsl:for-each>
            </xsl:for-each>
          </div>
          <div>
            <pre style="font-family:Times New Roman; ">
              <xsl:for-each select="curr:NakazEPU">
                <xsl:for-each select="curr:WTerminie">
                  <br />
                  <span style="font-family:Times New Roman; font-size:medium; ">
                    <xsl:apply-templates />
                  </span>
                </xsl:for-each>
              </xsl:for-each>
            </pre>
          </div>
          <br />
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>