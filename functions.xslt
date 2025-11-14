<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="widgets/functions.xslt"/>
	 <xsl:template mode="concat" match="@*">
			<xsl:if test="position()&gt;1">, </xsl:if>
			<xsl:apply-templates select="."/>
	 </xsl:template>
</xsl:stylesheet>