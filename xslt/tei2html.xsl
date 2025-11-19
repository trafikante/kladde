<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei"
    version="1.0">

  <xsl:output method="html" indent="yes" encoding="UTF-8"/>

  <!-- Haupttemplate: Seite mit zweispaltigem Layout -->
  <xsl:template match="/tei:TEI">
    <html lang="de">
      <head>
        <meta charset="UTF-8"/>
        <title>
          <xsl:value-of select="//tei:titleStmt/tei:title"/>
        </title>
        <link rel="stylesheet" href="css/styles.css"/>
      </head>
      <body>

        <h1>
          <xsl:value-of select="//tei:titleStmt/tei:title"/>
        </h1>

        <div class="page-container">

          <!-- LINKE SPALTE: Bild -->
          <div class="image-column">
            <img>
              <xsl:attribute name="src">
                <!-- nimmt den Dateinamen aus recordHist/source hinter dem Doppelpunkt -->
                <xsl:value-of select="concat('images/', normalize-space(substring-after(//tei:recordHist/tei:source, ': ')))"/>
              </xsl:attribute>
              <xsl:attribute name="alt">
                <xsl:text>Manuskriptseite</xsl:text>
              </xsl:attribute>
            </img>
          </div>

          <!-- RECHTE SPALTE: TEI-Text -->
          <div class="text-column">
            <xsl:apply-templates select="//tei:body"/>
          </div>

        </div>

      </body>
    </html>
  </xsl:template>

  <!-- ***** Text- und Inline-Templates ***** -->

  <xsl:template match="tei:body">
    <div class="body">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="tei:div">
    <div class="entry">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="tei:dateline">
    <p class="dateline">
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="tei:p">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="tei:lb">
    <br/>
  </xsl:template>

  <xsl:template match="tei:pb">
    <!-- unsichtbarer Anker, z.B. für Sprungmarken -->
    <a>
      <xsl:attribute name="id">
        <xsl:value-of select="@xml:id"/>
      </xsl:attribute>
    </a>
  </xsl:template>

  <xsl:template match="tei:hi[@rend='underline']">
    <span class="underline">
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
      <sup>*</sup>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- Fallback: alles andere rekursiv durchreichen -->
  <xsl:template match="*">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:value-of select="."/>
  </xsl:template>

</xsl:stylesheet>
