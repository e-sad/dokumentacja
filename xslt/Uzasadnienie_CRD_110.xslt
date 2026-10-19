<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:curr="http://www.currenda.pl/epu" xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:link="http://www.xbrl.org/2003/linkbase" xmlns:xbrldi="http://xbrl.org/2006/xbrldi"
	xmlns:xbrli="http://www.xbrl.org/2003/instance"
	xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsd="http://www.w3.org/2001/XMLSchema"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:altova="http://www.altova.com"
	version="1.0" exclude-result-prefixes="curr fn link xbrldi xbrli xdt xlink xs xsd xsi">
	<xsl:output version="4.0" method="html" indent="no" encoding="UTF-8"
		doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
		doctype-system="http://www.w3.org/TR/html4/loose.dtd" />
	<xsl:param name="SV_OutputFormat" select="HTML" />
	<xsl:variable name="XML" select="/" />
	<xsl:template match="/">
		<html>
			<head>
				<title />
			</head>
			<body
				style="margin-left=0.6in; margin-right=0.6in; margin-top=0.79in; margin-bottom=0.79in">
				<style type="text/css">                    span.spanStyle1{ font-family:"3 of 9 Barcode"; font-size:large;  }                </style>
				<div style="margin:auto; width:640px; ">
					<xsl:for-each select="$XML">
						<div>
							<table width="100%">
								<tr>
									<!-- LEWA KOLUMNA -->
									<td valign="top" align="left">
										<!-- KOD -->
										<xsl:if
											test="string-length(curr:UzasadnienieEPU/@KOD) &gt; 0">
											<div>
												<xsl:text>KOD </xsl:text>
												<xsl:value-of select="curr:UzasadnienieEPU/@KOD" />
											</div>
										</xsl:if>
									</td>
									<!-- PRAWA KOLUMNA -->
									<td valign="top" align="right">
										<xsl:if
											test="string-length(curr:UzasadnienieEPU/@KOD) &gt; 0">
											<div>
												<span class="spanStyle1">
													<xsl:value-of
														select="concat('*', curr:UzasadnienieEPU/@KOD, '*')" />
												</span>
											</div>
										</xsl:if>
									</td>
								</tr>
								<tr>
									<!-- LEWA KOLUMNA -->
									<td valign="top" align="left">
										<!-- SYGNATURA -->
										<div>
											<span style="font-weight:bold;">
												<xsl:text>Sygnatura akt </xsl:text>
											</span>
											<xsl:for-each
												select="curr:UzasadnienieEPU/curr:Sygnatura">
												<span style="font-weight:bold;">
													<xsl:apply-templates />
												</span>
											</xsl:for-each>
										</div>
									</td>
									<!-- PRAWA KOLUMNA -->
									<td valign="top" align="right" />
								</tr>
							</table>
						</div>
						<br />
						<div
							align="center">
							<xsl:for-each select="curr:UzasadnienieEPU">
								<h3 align="center"
									style="font-family: 'Arial'; font-size:17px; font-weight:bold;">
									<xsl:for-each select="@nazwaOrzeczenia">
										<span>
											<xsl:value-of select="string(.)" />
										</span>
									</xsl:for-each>
									<xsl:for-each select="curr:DoOrzeczenia">
										<h5 align="center"
											style=" font-size:17px; font-weight:bold; font-style: italic;">
											<span>
												<xsl:value-of select="string(.)" />
											</span>
										</h5>
									</xsl:for-each>
								</h3>
							</xsl:for-each>
						</div>
						<div
							align="right">
							<xsl:for-each select="curr:UzasadnienieEPU">
								<xsl:for-each select="@dataOrzeczenia">
									<span style="width:640px; ">
										<xsl:text>Data wydania </xsl:text>
									</span>
									<span>
										<xsl:value-of select="string(.)" />
									</span>
								</xsl:for-each>
							</xsl:for-each>
						</div>
						<p />
						<div
							style="width:inherit; " align="justify">
							<xsl:for-each select="curr:UzasadnienieEPU">
								<xsl:for-each select="curr:Uzasadnienie">
									<span style="width:640px; ">
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