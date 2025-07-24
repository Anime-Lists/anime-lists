<xsl:stylesheet
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:output encoding="utf-8" indent="yes" />

  <xsl:strip-space elements="anime-list" />

  <xsl:template name="newline">
    <xsl:text disable-output-escaping="yes">
</xsl:text>
  </xsl:template>

  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="@*" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>

  <xsl:template match='anime-list'>
    <xsl:copy>
      <xsl:comment>TEMPLATE
  &lt;anime anidbid=&quot;&quot; tvdbid=&quot;&quot; defaulttvdbseason=&quot;&quot; tmdbtv=&quot;&quot; tmdbseason=&quot;&quot; tmdbid=&quot;&quot; imdbid=&quot;&quot;&gt;
    &lt;name&gt;&lt;/name&gt;
    &lt;mapping-list&gt;
      &lt;mapping anidbseason=&quot;&quot; tvdbseason=&quot;&quot; tmdbseason=&quot;&quot;&gt;&lt;/mapping&gt;
    &lt;/mapping-list&gt;
    &lt;before&gt;&lt;/before&gt;
    &lt;supplemental-info replace=&quot;&quot;&gt;
      &lt;studio&gt;&lt;/studio&gt;
      &lt;genre&gt;&lt;/genre&gt;
      &lt;actor&gt;&lt;/actor&gt;
      &lt;director&gt;&lt;/director&gt;
      &lt;credits&gt;&lt;/credits&gt;
      &lt;thumb aspect=&quot;&quot;&gt;&lt;/thumb&gt;
      &lt;fanart&gt;
        &lt;thumb dim=&quot;&quot; colors=&quot;&quot; preview=&quot;&quot;&gt;&lt;/thumb&gt;
      &lt;/fanart&gt;
    &lt;/supplemental-info&gt;
  &lt;/anime&gt; </xsl:comment> 
      <xsl:copy-of select='@*' />
      <xsl:apply-templates />
    </xsl:copy>
    <xsl:call-template name="newline" />
    <xsl:comment><xsl:value-of select="count(anime[(@tvdbid = '') and (@tmdbtv = '')])"/> titles remaining</xsl:comment>
  </xsl:template>
 
  <xsl:template match='anime' />
 
  <xsl:template match='anime[(@tvdbid = "") and (@tmdbtv = "")]'> 
    <xsl:copy>
      <xsl:copy-of select='@*' />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>