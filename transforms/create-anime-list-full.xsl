<xsl:stylesheet
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:output encoding="utf-8" indent="yes" />

  <xsl:strip-space elements="anime-list" />

  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="@*" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
 
  <xsl:template match='anime' />
 
  <xsl:template match='anime[(@tvdbid != "") or (@tmdbtv != "")]'> 
    <xsl:copy>
      <xsl:copy-of select='@*[. != ""]' />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>