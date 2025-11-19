<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei"
    version="1.0">

  <xsl:output method="html" indent="yes" encoding="UTF-8"/>

  <!-- ========================================================= -->
  <!--                     ROOT: HTML-GERÜST                      -->
  <!-- ========================================================= -->

  <xsl:template match="/tei:TEI">
    <html lang="de">
      <head>
        <meta charset="UTF-8"/>
        <title>
          <xsl:value-of select="//tei:titleStmt/tei:title"/>
        </title>
        <!-- CSS im Root-Pfad des Repos -->
        <link rel="stylesheet" href="css/styles.css?v=2"/>
      </head>
      <body>

        <h1>
          <xsl:value-of select="//tei:titleStmt/tei:title"/>
        </h1>

        <div class="page-container">

          <!-- LINKE SPALTE: Manuskriptbild -->
          <div class="image-column">
            <img>
              <xsl:attribute name="src">
                <!-- Dateiname aus <recordHist>/<source> hinter dem Doppelpunkt -->
                <xsl:value-of select="concat('images/', normalize-space(substring-after(//tei:recordHist/tei:source, ': ')))"/>
              </xsl:attribute>
              <xsl:attribute name="alt">
                <xsl:text>Manuskriptseite</xsl:text>
              </xsl:attribute>
            </img>
          </div>

          <!-- RECHTE SPALTE: Text mit View-Toggle -->
          <div class="text-column">

            <div class="view-toggle">
              <button type="button" onclick="showView('critical')">kritischer Text</button>
              <button type="button" onclick="showView('reading')">Lesefassung</button>
              <button type="button" onclick="showView('meta')">Metadaten</button>
            </div>

            <!-- Kritische Ansicht: Abkürzungen + Zeilenumbrüche + Fußnoten -->
            <div id="critical-view" class="text-view">
              <xsl:apply-templates select="//tei:body" mode="crit"/>

              <!-- Fußnotenblock -->
            <div class="footnotes-block">
              <h2>Kommentar</h2>
              <ol>
                <xsl:for-each select="//tei:note">
                  <li>
                    <xsl:apply-templates select="." mode="foot"/>
                  </li>
                </xsl:for-each>
              </ol>
            </div>


            <!-- Lesefassung: nur expan, Zeilenumbrüche aufgelöst -->
            <div id="reading-view" class="text-view">
              <xsl:apply-templates select="//tei:body" mode="read"/>
            </div>

          </div>
        </div>

        <!-- Metadaten-Ansicht -->
        <div id="meta-view" class="text-view">
          <h2>Metadaten</h2>
          <dl class="meta-list">
            <dt>Titel</dt>
            <dd>
              <xsl:value-of select="//tei:titleStmt/tei:title"/>
            </dd>

            <dt>Verantwortlichkeiten</dt>
            <dd>
              <xsl:for-each select="//tei:titleStmt/tei:respStmt">
                <span class="meta-role">
                  <xsl:value-of select="tei:resp"/>:
                  <xsl:text> </xsl:text>
                  <xsl:value-of select="tei:name"/>
                </span>
                <xsl:if test="position() != last()">
                  <br/>
                </xsl:if>
              </xsl:for-each>
            </dd>

            <dt>Aufbewahrungsort</dt>
            <dd>
              <xsl:value-of select="//tei:msIdentifier/tei:repository"/>
              <xsl:text>; Signatur: </xsl:text>
              <xsl:value-of select="//tei:msIdentifier/tei:idno"/>
            </dd>

            <dt>Umfang</dt>
            <dd>
              <xsl:value-of select="//tei:extent"/>
            </dd>

            <dt>Material</dt>
            <dd>
              <xsl:value-of select="//tei:support"/>
            </dd>

            <dt>Entstehungszeitraum</dt>
            <dd>
              <xsl:value-of select="normalize-space(//tei:origin/tei:origDate)"/>
            </dd>

            <dt>Sprache</dt>
            <dd>
              <xsl:value-of select="//tei:langUsage/tei:language"/>
            </dd>

            <dt>Digitalisat</dt>
            <dd>
              <xsl:value-of select="//tei:recordHist/tei:source"/>
            </dd>
          </dl>
        </div>


        <!-- Entitäten-Legende -->
        <div class="entity-legend">
          <h2>Entitäten</h2>

          <!-- Personen -->
          <xsl:if test="//tei:listPerson/tei:person">
            <div class="legend-section">
              <h3>Personen</h3>
              <ul>
                <xsl:for-each select="//tei:listPerson/tei:person">
                  <li>
                    <span class="person">
                      <xsl:value-of select="tei:persName"/>
                    </span>
                    <xsl:if test="@ref">
                      <xsl:text> – </xsl:text>
                      <a href="{@ref}">
                        <xsl:value-of select="@ref"/>
                      </a>
                    </xsl:if>
                  </li>
                </xsl:for-each>
              </ul>
            </div>
          </xsl:if>

          <!-- Orte -->
          <xsl:if test="//tei:listPlace/tei:place">
            <div class="legend-section">
              <h3>Orte</h3>
              <ul>
                <xsl:for-each select="//tei:listPlace/tei:place">
                  <li>
                    <span class="place">
                      <xsl:value-of select="tei:placeName"/>
                    </span>
                    <xsl:if test="@ref">
                      <xsl:text> – </xsl:text>
                      <a href="{@ref}">
                        <xsl:value-of select="@ref"/>
                      </a>
                    </xsl:if>
                  </li>
                </xsl:for-each>
              </ul>
            </div>
          </xsl:if>

          <!-- Ereignisse -->
          <xsl:if test="//tei:listEvent/tei:event">
            <div class="legend-section">
              <h3>Ereignisse</h3>
              <ul>
                <xsl:for-each select="//tei:listEvent/tei:event">
                  <li>
                    <span class="event">
                      <xsl:value-of select="tei:title"/>
                    </span>
                    <xsl:if test="tei:idno[@type='url']">
                      <xsl:text> – </xsl:text>
                      <a href="{tei:idno[@type='url']}">Webseite</a>
                    </xsl:if>
                  </li>
                </xsl:for-each>
              </ul>
            </div>
          </xsl:if>

        </div>

      </body>
    </html>
  </xsl:template>

  <!-- ========================================================= -->
  <!--              MODUS: KRITISCHER TEXT (mode="crit")          -->
  <!-- ========================================================= -->

  <xsl:template match="tei:body" mode="crit">
    <div class="body">
      <xsl:apply-templates mode="crit"/>
    </div>
  </xsl:template>

  <xsl:template match="tei:div" mode="crit">
    <div class="entry">
      <xsl:apply-templates mode="crit"/>
    </div>
  </xsl:template>

  <xsl:template match="tei:dateline" mode="crit">
    <p class="dateline">
      <xsl:apply-templates mode="crit"/>
    </p>
  </xsl:template>

  <xsl:template match="tei:p" mode="crit">
    <p>
      <xsl:apply-templates mode="crit"/>
    </p>
  </xsl:template>

  <xsl:template match="tei:lb" mode="crit">
    <br/>
  </xsl:template>

  <xsl:template match="tei:pb" mode="crit">
    <a>
      <xsl:attribute name="id">
        <xsl:value-of select="@xml:id"/>
      </xsl:attribute>
    </a>
  </xsl:template>

  <xsl:template match="tei:hi[@rend='underline']" mode="crit">
    <span class="underline">
      <xsl:apply-templates mode="crit"/>
    </span>
  </xsl:template>

  <xsl:template match="tei:persName" mode="crit">
    <span class="person">
      <xsl:apply-templates mode="crit"/>
    </span>
  </xsl:template>

  <xsl:template match="tei:placeName" mode="crit">
    <span class="place">
      <xsl:apply-templates mode="crit"/>
    </span>
  </xsl:template>

  <xsl:template match="tei:event" mode="crit">
    <span class="event">
      <xsl:apply-templates mode="crit"/>
    </span>
  </xsl:template>

  <!-- choice: in kritischer Ansicht nur <abbr> anzeigen -->
  <xsl:template match="tei:choice" mode="crit">
    <xsl:apply-templates select="tei:abbr" mode="crit"/>
  </xsl:template>

  <xsl:template match="tei:abbr" mode="crit">
    <xsl:apply-templates mode="crit"/>
  </xsl:template>

  <xsl:template match="tei:expan" mode="crit">
    <!-- in kritischer Ansicht unterdrückt -->
  </xsl:template>

  <!-- Stellenkommentar im Text: nur Marker -->
  <xsl:template match="tei:note" mode="crit">
    <span class="footnote-marker">
      <sup>
        <xsl:number level="any" count="tei:note"/>
      </sup>
    </span>
  </xsl:template>

  <!-- Default im kritischen Modus -->
  <xsl:template match="*" mode="crit">
    <xsl:apply-templates mode="crit"/>
  </xsl:template>

  <xsl:template match="text()" mode="crit">
    <xsl:value-of select="."/>
  </xsl:template>

  <!-- ========================================================= -->
  <!--              MODUS: LESEFASSUNG (mode="read")             -->
  <!-- ========================================================= -->

  <xsl:template match="tei:body" mode="read">
    <div class="body">
      <xsl:apply-templates mode="read"/>
    </div>
  </xsl:template>

  <xsl:template match="tei:div" mode="read">
    <div class="entry">
      <xsl:apply-templates mode="read"/>
    </div>
  </xsl:template>

  <xsl:template match="tei:dateline" mode="read">
    <p class="dateline">
      <xsl:apply-templates mode="read"/>
    </p>
  </xsl:template>

  <xsl:template match="tei:p" mode="read">
    <p>
      <xsl:apply-templates mode="read"/>
    </p>
  </xsl:template>

  <!-- Zeilenumbrüche in Lesefassung aufgelöst -->
  <xsl:template match="tei:lb" mode="read">
    <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="tei:pb" mode="read">
    <!-- in Lesefassung unsichtbar -->
  </xsl:template>

  <xsl:template match="tei:hi[@rend='underline']" mode="read">
    <span class="underline">
      <xsl:apply-templates mode="read"/>
    </span>
  </xsl:template>

  <xsl:template match="tei:persName" mode="read">
    <span class="person">
      <xsl:apply-templates mode="read"/>
    </span>
  </xsl:template>

  <xsl:template match="tei:placeName" mode="read">
    <span class="place">
      <xsl:apply-templates mode="read"/>
    </span>
  </xsl:template>

  <xsl:template match="tei:event" mode="read">
    <span class="event">
      <xsl:apply-templates mode="read"/>
    </span>
  </xsl:template>

  <!-- choice: in Lesefassung nur expan -->
  <xsl:template match="tei:choice" mode="read">
    <xsl:apply-templates select="tei:expan" mode="read"/>
  </xsl:template>

  <xsl:template match="tei:abbr" mode="read">
    <!-- in Lesefassung unterdrückt -->
  </xsl:template>

  <xsl:template match="tei:expan" mode="read">
    <xsl:apply-templates mode="read"/>
  </xsl:template>

  <!-- Stellenkommentar in Lesefassung: keine Marker -->
  <xsl:template match="tei:note" mode="read">
    <!-- bewusst leer -->
  </xsl:template>

  <!-- Default im Lesemodus -->
  <xsl:template match="*" mode="read">
    <xsl:apply-templates mode="read"/>
  </xsl:template>

  <xsl:template match="text()" mode="read">
    <xsl:value-of select="."/>
  </xsl:template>

  <!-- ========================================================= -->
  <!--           MODUS: FUSSNOTENINHALT (mode="foot")            -->
  <!-- ========================================================= -->

<xsl:template match="text()[contains(., 'http')]" mode="foot">
  <xsl:variable name="t" select="."/>
  <xsl:variable name="before" select="substring-before($t, 'http')"/>
  <xsl:variable name="urlAndAfter" select="substring-after($t, 'http')"/>

  <!-- URL bis zum nächsten Leerzeichen oder bis zum Ende -->
  <xsl:variable name="urlCore">
    <xsl:choose>
      <xsl:when test="contains($urlAndAfter, ' ')">
        <xsl:value-of select="concat('http', substring-before($urlAndAfter, ' '))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat('http', $urlAndAfter)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="after">
    <xsl:choose>
      <xsl:when test="contains($urlAndAfter, ' ')">
        <xsl:value-of select="substring-after($urlAndAfter, ' ')"/>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:variable>

  <xsl:value-of select="$before"/>
  <a href="{$urlCore}">
    <xsl:value-of select="$urlCore"/>
  </a>
  <xsl:value-of select="$after"/>
</xsl:template>

<!-- danach das generische text()-Template -->
<xsl:template match="text()" mode="foot">
  <xsl:value-of select="."/>
</xsl:template>


</xsl:stylesheet>
