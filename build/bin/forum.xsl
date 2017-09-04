<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
xmlns:rss="http://purl.org/rss/1.0/" >
  <xsl:output method="html" />
  
  <xsl:template match="/rdf:RDF">
    <xsl:apply-templates select="rss:item" />
  </xsl:template>
  
  <xsl:template match="rss:item">
    <div class="forumEntry">
      <a href="{rss:link}">
      <xsl:value-of select="rss:title" /></a>
    </div>
  </xsl:template>

</xsl:stylesheet> 