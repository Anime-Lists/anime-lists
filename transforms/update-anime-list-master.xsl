<xsl:stylesheet
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:output encoding="utf-8" indent="yes" />

  <xsl:param name="doc2" select="'../anime-list-master.xml'" />

  <xsl:key name="animebyid" match="anime" use="@anidbid"/>

  <xsl:template match="animetitles">
   <anime-list>		
     <xsl:for-each select="anime">  	  
        <xsl:variable name="aid" select="@aid" />
        <xsl:variable name="name" select='translate(title[@type = "main"], "`", "&apos;")' />
        <xsl:for-each select="document($doc2)">
          <xsl:variable name="done" select="key('animebyid', $aid)" />
          <anime>
            <xsl:attribute name="anidbid"><xsl:value-of select="$aid" /></xsl:attribute>
            <xsl:attribute name="tvdbid"><xsl:value-of select="$done/@tvdbid" /></xsl:attribute>
            <xsl:attribute name="defaulttvdbseason"><xsl:value-of select="$done/@defaulttvdbseason" /></xsl:attribute>
            <xsl:attribute name="episodeoffset"><xsl:value-of select="$done/@episodeoffset" /></xsl:attribute>
            <xsl:attribute name="tmdbtv"><xsl:value-of select="$done/@tmdbtv" /></xsl:attribute>
            <xsl:attribute name="tmdbseason"><xsl:value-of select="$done/@tmdbseason" /></xsl:attribute>
            <xsl:attribute name="tmdboffset"><xsl:value-of select="$done/@tmdboffset" /></xsl:attribute>
            <xsl:attribute name="tmdbid"><xsl:value-of select="$done/@tmdbid" /></xsl:attribute>
            <xsl:attribute name="imdbid"><xsl:value-of select="$done/@imdbid" /></xsl:attribute>
            <xsl:copy-of select="$done/comment()" />
            <name><xsl:value-of select="$name" /></name>
            <xsl:for-each select="$done/mapping-list">
              <xsl:copy>
                <xsl:for-each select="mapping">
                  <xsl:sort select="@anidbseason" data-type="number" />
                  <xsl:sort select="@tvdbseason" data-type="number" />
                  <xsl:sort select="@tmdbseason" data-type="number" />
                  <xsl:sort select="@tmdboffset" data-type="number" />
                  <xsl:copy-of select="." />
                </xsl:for-each>
              </xsl:copy>
            </xsl:for-each>
            <xsl:copy-of select="$done/before" />
            <xsl:copy-of select="$done/supplemental-info" />		  
          </anime>
        </xsl:for-each>
      </xsl:for-each>
    </anime-list>
  </xsl:template>

</xsl:stylesheet>