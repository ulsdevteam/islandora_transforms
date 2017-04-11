<?xml version="1.0" encoding="UTF-8"?>
<!-- JSON converted into XML -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:java="http://xml.apache.org/xalan/java"
  xmlns:xalan="http://xml.apache.org/xalan"
  xmlns:foxml="info:fedora/fedora-system:def/foxml#">
  <xsl:template match="foxml:datastream/foxml:datastreamVersion[last()][@MIMETYPE='application/json']" name="index_converted_json">
    <xsl:param name="content"/>
    <xsl:param name="prefix">
      <xsl:value-of select="concat(../@ID, '_')"/>
    </xsl:param>
    <xsl:param name="suffix">ms</xsl:param>

    <xsl:apply-templates mode="index_converted_json" select="$content/*[local-name() = 'json']">
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- Build up the list prefix with the element context. -->
  <xsl:template match="*" mode="index_converted_json">
    <xsl:param name="prefix"/>
    <xsl:param name="suffix"/>

    <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz_'" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ '" />

    <xsl:variable name="this_prefix">
      <xsl:value-of select="concat($prefix, local-name(), '_')"/>
      <xsl:if test="@type">
        <xsl:value-of select="concat(@type, '_')"/>
      </xsl:if>
    </xsl:variable>

    <xsl:variable name="textValue">
      <xsl:value-of select="normalize-space(text())"/>
    </xsl:variable>

    <xsl:if test="$textValue">
      <field>
        <xsl:attribute name="name">
          <xsl:value-of select="concat($this_prefix, $suffix)"/>
        </xsl:attribute>
        <xsl:value-of select="$textValue"/>
      </field>
    </xsl:if>

    <xsl:apply-templates mode="index_converted_json">
      <xsl:with-param name="prefix" select="$this_prefix"/>
      <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- Avoid using text alone. -->
  <xsl:template match="text()" mode="index_converted_json"/>
</xsl:stylesheet>
