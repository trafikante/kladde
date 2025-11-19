<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei"
    version="1.0">

  <xsl:output method="html" indent="yes" encoding="UTF-8"/>

  <!-- Haupttemplate -->
  <xsl:template match="/tei:TEI">
    <html>
      <head>
        <title><xsl:value-of select="//tei:titleStmt/tei:title"/></title>
        <link rel="stylesheet" href="../css/styles.css"/>
      </head>
      <body>

        <div class="page-container">

          <!-- *************** LINKER BEREICH: BILD *************** -->
          <div class="image-column">
            <img>
              <xsl:attribute name="src">
                <xsl:value-of select="concat('../images/', substring-after(//tei:recordHist/tei:source, ': '))"/>
              </xsl:attribute>
            </img>
          </div>

          <!-- *************** RECHTER BEREICH: TEXT *************** -->
          <div class="text-column">
            <xsl:apply-templates select="//tei:body"/>
          </div>
        </div>

      </body>
    </html>
  </xsl:template>


  <!-- Grundlegende Textverarbeitung -->

  <xsl:template match="tei:lb">
    <br/>
  </xsl:template>

  <xsl:template match="tei:pb">
    <!-- pb wird nicht angezeigt, aber als Anker benutzt -->
    <a>
      <xsl:attribute name="name"><xsl:value-of select="@xml:id"/></xsl:attribute>
    </a>
  </xsl:template>

  <xsl:template match="tei:hi[@rend='underline']">
    <span style="text-decoration: underline;">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="tei:persName">
    <span class="person">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="tei:placeName">
    <span class="place">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="tei:event">
    <span class="event">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="tei:note">
    <span class="footnote">
      <sup>*</sup> <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- Standardfall -->
  <xsl:template match="*">
    <div>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="tei"
  version="1.0">

  <xsl:output method="html" indent="yes" encoding="UTF-8"/>
  <xsl:strip-space elements="*"/>

  <xsl:template match="/tei:TEI">
  <html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>
      <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
    </title>
    <link rel="stylesheet" href="../css/styles.css"/>
    </head>
    <body>
    <div class="page-container">
      <div class="image-column">
      <img src="{concat('../images/', substring-after(/tei:TEI//tei:recordHist/tei:source, ': '))" alt=""/>
      </div>
      <div class="text-column">
      <xsl:apply-templates select="/tei:TEI/tei:text/tei:body"/>
      </div>
    </div>
    </body>
  </html>
  </xsl:template>

  <!-- Struktur-/Blockelemente gezielt behandeln -->
  <xsl:template match="tei:text|tei:body|tei:div|tei:p|tei:head">
  <div>
    <xsl:apply-templates/>
  </div>
  </xsl:template>

  <xsl:template match="tei:lb"><br/></xsl:template>

  <xsl:template match="tei:pb">
  <a name="{@xml:id}"/>
  </xsl:template>

  <xsl:template match="tei:hi[@rend='underline']">
  <span style="text-decoration: underline;"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="tei:persName"><span class="person"><xsl:apply-templates/></span></xsl:template>
  <xsl:template match="tei:placeName"><span class="place"><xsl:apply-templates/></span></xsl:template>
  <xsl:template match="tei:event"><span class="event"><xsl:apply-templates/></span></xsl:template>
  <xsl:template match="tei:note"><span class="footnote"><sup>*</sup> <xsl:apply-templates/></span></xsl:template>

  <!-- Textknoten direkt ausgeben, sonst Templates rekursiv anwenden -->
  <xsl:template match="text()"><xsl:value-of select="."/></xsl:template>
  <xsl:template match="*"><xsl:apply-templates/></xsl:template>

</xsl:stylesheet>
