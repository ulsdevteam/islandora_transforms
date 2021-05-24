<?xml version="1.0" encoding="UTF-8"?>
<!-- EAD -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:foxml="info:fedora/fedora-system:def/foxml#">
  <xsl:template match="foxml:datastream[@ID='EAD']/foxml:datastreamVersion[last()]" name="index_EAD">
    <xsl:param name="content"/>
    <!--
      EAD structure is mad crazy customizable and balloons Solr's fields.
      Instead of slurping fields, we're going to chunk the whole text content into one field
    -->
    <field>
      <xsl:attribute name="name">ead_fulltext_ms</xsl:attribute>
      <xsl:value-of select="$content/*[local-name() = 'ead']"/>
    </field>
  </xsl:template>
</xsl:stylesheet>
