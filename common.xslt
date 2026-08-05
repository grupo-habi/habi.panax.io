<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns="http://www.w3.org/1999/xhtml"
xmlns:xo="http://panax.io/xover"
xmlns:session="http://panax.io/session"
xmlns:data="http://panax.io/data"
xmlns:state="http://panax.io/state"
xmlns:env="http://panax.io/state/environment"
exclude-result-prefixes="xo xsl"
>
	<xsl:import href="functions.xslt"/>

	<xsl:key name="data_type" match="path-to-attrib" use="'type'"/>
	<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

	<xsl:template mode="class" match="*|@*"></xsl:template>
	<xsl:template mode="styles" match="*|@*"></xsl:template>

	<xsl:template mode="styles" match="*[@color]|*[@color]/@*" priority="1">
		background:<xsl:value-of select="ancestor-or-self::*/@color"/> !important; color: white;
	</xsl:template>

	<xsl:template mode="value" match="@status">
		<xsl:value-of select="concat(translate(substring(.,1,1),$lowercase,$uppercase), substring(.,2))"/>
	</xsl:template>

	<xsl:template mode="value" match="@*">
		<xsl:value-of select="../@id"/>
	</xsl:template>

	<xsl:template mode="value" match="fecha/@*">
		<xsl:value-of select="../@mes"/>
	</xsl:template>

	<xsl:template mode="key" match="@*">
		<xsl:text>::</xsl:text>
		<xsl:value-of select="name(..)"/>
		<xsl:text>:</xsl:text>
		<xsl:value-of select="../@id"/>
	</xsl:template>

	<xsl:template mode="key" match="fecha/@*">
		<xsl:text>::</xsl:text>
		<xsl:value-of select="name(..)"/>
		<xsl:text>:</xsl:text>
		<xsl:value-of select="../@mes"/>
	</xsl:template>

	<xsl:template mode="dimension-attribute" match="@*">
		<xsl:attribute name="{name(..)}">
			<xsl:apply-templates mode="value" select="."/>
		</xsl:attribute>
	</xsl:template>

	<xsl:template mode="dimension-attribute" match="razon_social/@*">
		<xsl:attribute name="rs">
			<xsl:apply-templates mode="value" select="."/>
		</xsl:attribute>
	</xsl:template>

	<xsl:template mode="dimension-attribute" match="producto/@*">
		<xsl:attribute name="prod">
			<xsl:apply-templates mode="value" select="."/>
		</xsl:attribute>
	</xsl:template>

	<xsl:template mode="button" match="*|@*">
		<xsl:variable name="element" select="ancestor-or-self::*[1]"/>
		<xsl:variable name="active" select="$element/@state:checked='true'"/>
		<xsl:variable name="style">
			<xsl:if test="$active">
				<xsl:text>active</xsl:text>
			</xsl:if>
		</xsl:variable>
		<button type="button" class="btn btn-outline-secondary {$style}" xo-slot="state:checked" onclick="scope.toggle('true');" style="white-space: nowrap;">
			<xsl:choose>
				<xsl:when test="$active">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-square" viewBox="0 0 16 16" style="margin-right: 5pt" onclick="scope.remove(); event.stopPropagation(); return false" xo-slot="state:checked">
						<path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
						<path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
					</svg>
				</xsl:when>
				<xsl:otherwise>
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-square" viewBox="0 0 16 16" style="margin-right: 5pt" onclick="scope.set('true'); event.stopPropagation(); return false;" xo-slot="state:checked">
						<path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
					</svg>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates mode="headerText" select="."/>
		</button>
	</xsl:template>

	<xsl:template match="key('data_type', 'money')">
		<xsl:call-template name="format">
			<xsl:with-param name="value" select="."></xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="key('data_type', 'percent')">
		<xsl:call-template name="format-percent">
			<xsl:with-param name="value" select="."></xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="key('data_type', 'number')">
		<xsl:call-template name="format">
			<xsl:with-param name="value" select="number(.)"></xsl:with-param>
			<xsl:with-param name="mask">###,##0.00;-###,##0.00</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="key('data_type', 'integer')">
		<xsl:call-template name="format">
			<xsl:with-param name="value" select="number(.)"></xsl:with-param>
			<xsl:with-param name="mask">###,##0;-###,##0</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="key('data_type', 'date')">
		<xsl:value-of select="substring(.,1,4)"/>
		<xsl:text>-</xsl:text>
		<xsl:value-of select="substring(.,5,2)"/>
		<xsl:if test="substring(.,7,2)!=''">
			<xsl:text>-</xsl:text>
			<xsl:value-of select="substring(.,7,2)"/>
		</xsl:if>
	</xsl:template>

	<xsl:param name="session:server"></xsl:param>
	<xsl:template match="*[@f|@Ubicacion]/@uuid">
		<a href="{$session:server}/{../@f|../@Ubicacion}" title="{../@fecha}" target="_blank" style="padding-right:.5rem;">
			<xsl:value-of select="."/>
		</a>
		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-filetype-pdf" viewBox="0 0 16 16" onclick="cfdi.mostrarFactura.call(this)">
			<path fill-rule="evenodd" d="M14 4.5V14a2 2 0 0 1-2 2h-1v-1h1a1 1 0 0 0 1-1V4.5h-2A1.5 1.5 0 0 1 9.5 3V1H4a1 1 0 0 0-1 1v9H2V2a2 2 0 0 1 2-2h5.5zM1.6 11.85H0v3.999h.791v-1.342h.803q.43 0 .732-.173.305-.175.463-.474a1.4 1.4 0 0 0 .161-.677q0-.375-.158-.677a1.2 1.2 0 0 0-.46-.477q-.3-.18-.732-.179m.545 1.333a.8.8 0 0 1-.085.38.57.57 0 0 1-.238.241.8.8 0 0 1-.375.082H.788V12.48h.66q.327 0 .512.181.185.183.185.522m1.217-1.333v3.999h1.46q.602 0 .998-.237a1.45 1.45 0 0 0 .595-.689q.196-.45.196-1.084 0-.63-.196-1.075a1.43 1.43 0 0 0-.589-.68q-.396-.234-1.005-.234zm.791.645h.563q.371 0 .609.152a.9.9 0 0 1 .354.454q.118.302.118.753a2.3 2.3 0 0 1-.068.592 1.1 1.1 0 0 1-.196.422.8.8 0 0 1-.334.252 1.3 1.3 0 0 1-.483.082h-.563zm3.743 1.763v1.591h-.79V11.85h2.548v.653H7.896v1.117h1.606v.638z"/>
		</svg>
		<xsl:apply-templates select="../@UbicacionPDF"/>
	</xsl:template>
	<xsl:template match="@UbicacionPDF">
		<a href="{$session:server}/{.}" title="{../@fecha}" target="_blank" style="padding-right:.5rem;">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-earmark-pdf-fill" viewBox="0 0 16 16">
				<path d="M5.523 12.424q.21-.124.459-.238a8 8 0 0 1-.45.606c-.28.337-.498.516-.635.572l-.035.012a.3.3 0 0 1-.026-.044c-.056-.11-.054-.216.04-.36.106-.165.319-.354.647-.548m2.455-1.647q-.178.037-.356.078a21 21 0 0 0 .5-1.05 12 12 0 0 0 .51.858q-.326.048-.654.114m2.525.939a4 4 0 0 1-.435-.41q.344.007.612.054c.317.057.466.147.518.209a.1.1 0 0 1 .026.064.44.44 0 0 1-.06.2.3.3 0 0 1-.094.124.1.1 0 0 1-.069.015c-.09-.003-.258-.066-.498-.256M8.278 6.97c-.04.244-.108.524-.2.829a5 5 0 0 1-.089-.346c-.076-.353-.087-.63-.046-.822.038-.177.11-.248.196-.283a.5.5 0 0 1 .145-.04c.013.03.028.092.032.198q.008.183-.038.465z"/>
				<path fill-rule="evenodd" d="M4 0h5.293A1 1 0 0 1 10 .293L13.707 4a1 1 0 0 1 .293.707V14a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2m5.5 1.5v2a1 1 0 0 0 1 1h2zM4.165 13.668c.09.18.23.343.438.419.207.075.412.04.58-.03.318-.13.635-.436.926-.786.333-.401.683-.927 1.021-1.51a11.7 11.7 0 0 1 1.997-.406c.3.383.61.713.91.95.28.22.603.403.934.417a.86.86 0 0 0 .51-.138c.155-.101.27-.247.354-.416.09-.181.145-.37.138-.563a.84.84 0 0 0-.2-.518c-.226-.27-.596-.4-.96-.465a5.8 5.8 0 0 0-1.335-.05 11 11 0 0 1-.98-1.686c.25-.66.437-1.284.52-1.794.036-.218.055-.426.048-.614a1.24 1.24 0 0 0-.127-.538.7.7 0 0 0-.477-.365c-.202-.043-.41 0-.601.077-.377.15-.576.47-.651.823-.073.34-.04.736.046 1.136.088.406.238.848.43 1.295a20 20 0 0 1-1.062 2.227 7.7 7.7 0 0 0-1.482.645c-.37.22-.699.48-.897.787-.21.326-.275.714-.08 1.103"/>
			</svg>
		</a>
	</xsl:template>
	<xsl:template match="@Folio">
		<xsl:variable name="mask">$#,##0.##;-$#,##0.##</xsl:variable>
		<a href="{$session:server}/{../@Ubicacion}" title="{../@fecha}: {format-number(../@Total,$mask)} ({../@FormaPago})" target="_blank">
			<xsl:value-of select="."/>
		</a>
	</xsl:template>
	<xsl:template match="@Folio" mode="concat">
		<xsl:apply-templates select="."/>
		<xsl:if test="position()!=last()">
			<xsl:text>, </xsl:text>
			<wbr/>
		</xsl:if>
	</xsl:template>

	<xsl:template match="@adeudo_actual">
		<xsl:call-template name="format">
			<xsl:with-param name="value">
				<xsl:value-of select="."/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>