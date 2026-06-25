<!DOCTYPE stylesheet [
	<!ENTITY body "background-color:#FFFFFF; padding:5px; font-size:10px; font-family:Verdana, Arial, sans-serif; color:#263238;">
	<!ENTITY header "background-color:#ECEDEC; padding:6px; text-align:center; border:1px solid #364C4A; font-family:Verdana, Arial, sans-serif;">
	<!ENTITY celda "padding:6px; border-top:1px solid #E0E1DD; border-bottom:1px solid #ADAFAF; border-left:1px solid #E0E1DD; border-right:0px solid #E0E1DD; font-family:Verdana, Arial, sans-serif;">
	<!ENTITY celdaRight "padding:6px; border-top:1px solid #E0E1DD; border-bottom:1px solid #ADAFAF; border-left:1px solid #E0E1DD; border-right:1px solid #E0E1DD; font-family:Verdana, Arial, sans-serif;">
	<!ENTITY card "border:1px solid #D7DAD7; border-radius:6px; padding:10px; margin:6px 0; background-color:#FAFAFA;">
	<!ENTITY ok "background-color:#7EA84A; color:#FFFFFF;">
	<!ENTITY error "background-color:#B00B11; color:#FFFFFF;">
	<!ENTITY warning "background-color:#FFCC00; color:#FFFFFF;">
	<!ENTITY neutral "background-color:#747678; color:#FFFFFF;">
	<!ENTITY title "background-color:#364C4A; color:#FFFFFF; font-size:18px; padding:12px; text-align:center; font-family:Verdana, Arial, sans-serif;">
	<!ENTITY nowrap "white-space:nowrap;">
]>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:strip-space elements="*"/>
	<xsl:output method="xml" omit-xml-declaration="yes" standalone="yes" indent="yes"/>
	<xsl:decimal-format name="money" grouping-separator="," decimal-separator="."/>

	<xsl:key name="solicitudesPorRFC" match="Solicitud" use="@RFC"/>

	<xsl:template match="DescargaMasiva">
		<body style="&body;">
			<xsl:if test="not(..)">
				<h1 style="&title;">Notificación de Descarga Masiva SAT CFDI:</h1>
			</xsl:if>
			<table cellpadding="0" cellspacing="2" style="width:100%; color:#000000; font-size:10px; font-family:Verdana, Arial, sans-serif;">
				<tr>
					<td style="width:180px;">Fecha del reporte:</td>
					<th style="&header; text-align:left;">
						<xsl:value-of select="@FechaReporte"/>
					</th>
				</tr>
				<xsl:if test="@FechaDesde and @FechaHasta">
					<tr>
						<td>Ventana consultada:</td>
						<th style="&header; text-align:left;">
							<xsl:value-of select="@FechaDesde"/>
							<xsl:text> a </xsl:text>
							<xsl:value-of select="@FechaHasta"/>
						</th>
					</tr>
					<tr>
						<td>Horario de reintentos:</td>
						<th style="&header; text-align:left;">
							<xsl:value-of select="@HoraInicio"/>
							<xsl:text> a </xsl:text>
							<xsl:value-of select="@HoraFin"/>
							<xsl:text> hrs</xsl:text>
						</th>
					</tr>
				</xsl:if>
			</table>

			<xsl:call-template name="resumenEjecutivo"/>
			<xsl:call-template name="estadoSolicitudes"/>
			<xsl:call-template name="incidenciasComplementos"/>
			<xsl:call-template name="resumenRFC"/>
			<xsl:call-template name="detalleSolicitudes"/>
			<xsl:if test="not(..)">
				<hr/>
				<div style="padding:10px; margin:10px; font-size:10px; color:#747678; font-family:Verdana, Arial, sans-serif;">
					AVISO DE CONFIDENCIALIDAD: Este correo electrónico es confidencial y para uso exclusivo de la(s) persona(s) a quien(es) se dirige. Si el lector de esta transmisión electrónica no es el destinatario, se le notifica que cualquier distribución o copia de la misma está estrictamente prohibida. Si ha recibido este correo por error le solicitamos notificar inmediatamente a la persona que lo envió y borrarlo definitivamente de su sistema.
				</div>
			</xsl:if>
		</body>
	</xsl:template>

	<xsl:template name="resumenEjecutivo">
		<h2 style="font-size:15px; color:#364C4A; margin-top:18px;">Resumen ejecutivo</h2>
		<table cellpadding="0" cellspacing="2" style="width:100%; font-size:10px; font-family:Verdana, Arial, sans-serif;">
			<tr>
				<th style="&header;">Concepto</th>
				<th style="&header; width:110px;">Cantidad</th>
				<th style="&header;">Comentario</th>
			</tr>
			<xsl:call-template name="summaryRow">
				<xsl:with-param name="label" select="'Solicitudes SAT'"/>
				<xsl:with-param name="value" select="count(Solicitud)"/>
				<xsl:with-param name="comment" select="'Consultas registradas en la ventana del reporte'"/>
			</xsl:call-template>
			<xsl:call-template name="summaryRow">
				<xsl:with-param name="label" select="'Solicitudes descargadas/terminadas'"/>
				<xsl:with-param name="value" select="count(Solicitud[@EstatusConsulta='Descargado' or @EstatusConsulta='Terminada' or @EstatusConsulta='Terminado'])"/>
				<xsl:with-param name="comment" select="'Con resultado final o paquetes descargados'"/>
			</xsl:call-template>
			<xsl:call-template name="summaryRow">
				<xsl:with-param name="label" select="'Solicitudes en proceso'"/>
				<xsl:with-param name="value" select="count(Solicitud[not(@EstatusConsulta='Descargado' or @EstatusConsulta='Terminada' or @EstatusConsulta='Terminado' or @EstatusConsulta='Error')])"/>
				<xsl:with-param name="comment" select="'Pueden continuar en reintento dentro de la ventana operativa'"/>
			</xsl:call-template>
			<xsl:call-template name="summaryRow">
				<xsl:with-param name="label" select="'Solicitudes con error'"/>
				<xsl:with-param name="value" select="count(Solicitud[@EstatusConsulta='Error'])"/>
				<xsl:with-param name="comment" select="'Requieren revisión o nuevo intento'"/>
			</xsl:call-template>
			<xsl:call-template name="summaryRow">
				<xsl:with-param name="label" select="'CFDI descargados'"/>
				<xsl:with-param name="value" select="count(//Comprobante)"/>
				<xsl:with-param name="comment" select="'Comprobantes registrados en el detalle'"/>
			</xsl:call-template>
			<xsl:call-template name="summaryRow">
				<xsl:with-param name="label" select="'Facturas'"/>
				<xsl:with-param name="value" select="count(//Comprobante[@Tipo='factura'])"/>
				<xsl:with-param name="comment" select="'CFDI de ingreso/egreso clasificados como factura'"/>
			</xsl:call-template>
			<xsl:call-template name="summaryRow">
				<xsl:with-param name="label" select="'Complementos'"/>
				<xsl:with-param name="value" select="count(//Comprobante[@Tipo='complemento'])"/>
				<xsl:with-param name="comment" select="'Complementos de pago descargados'"/>
			</xsl:call-template>
			<xsl:call-template name="summaryRow">
				<xsl:with-param name="label" select="'Notas de crédito'"/>
				<xsl:with-param name="value" select="count(//Comprobante[@Tipo='nota_credito'])"/>
				<xsl:with-param name="comment" select="'CFDI clasificados como nota de crédito'"/>
			</xsl:call-template>
			<xsl:call-template name="summaryRow">
				<xsl:with-param name="label" select="'Complementos con incidencias'"/>
				<xsl:with-param name="value" select="count(//Comprobante[@Tipo='complemento'][not(FacturaRelacionada) or FacturaRelacionada[@Estatus!='Aplicado']])"/>
				<xsl:with-param name="comment" select="'Complementos con facturas relacionadas no aplicadas, canceladas o no localizadas'"/>
			</xsl:call-template>
			<xsl:call-template name="summaryRow">
				<xsl:with-param name="label" select="'Facturas relacionadas no encontradas'"/>
				<xsl:with-param name="value" select="count(//Comprobante[@Tipo='complemento']/FacturaRelacionada[@Estatus='No encontrado'])"/>
				<xsl:with-param name="comment" select="'Relaciones que no existen en Compras.Facturas'"/>
			</xsl:call-template>
			<xsl:call-template name="summaryRow">
				<xsl:with-param name="label" select="'Facturas relacionadas canceladas'"/>
				<xsl:with-param name="value" select="count(//Comprobante[@Tipo='complemento']/FacturaRelacionada[@Estatus='Cancelado'])"/>
				<xsl:with-param name="comment" select="'Relaciones cuyo StatusSAT indica cancelación'"/>
			</xsl:call-template>
		</table>
	</xsl:template>

	<xsl:template name="summaryRow">
		<xsl:param name="label"/>
		<xsl:param name="value"/>
		<xsl:param name="comment"/>
		<tr>
			<td style="&celda;">
				<xsl:value-of select="$label"/>
			</td>
			<td style="&celda; text-align:right; font-weight:bold;">
				<xsl:value-of select="$value"/>
			</td>
			<td style="&celdaRight; color:#747678;">
				<xsl:value-of select="$comment"/>
			</td>
		</tr>
	</xsl:template>

	<xsl:template name="estadoSolicitudes">
		<h2 style="font-size:15px; color:#364C4A; margin-top:18px;">Estado de solicitudes</h2>
		<table cellpadding="0" cellspacing="2" style="width:100%; font-size:10px; font-family:Verdana, Arial, sans-serif;">
			<tr>
				<th style="&header;">RFC</th>
				<th style="&header;">Fecha consultada</th>
				<th style="&header;">Estatus SAT</th>
				<th style="&header;">CFDI SAT</th>
				<th style="&header;">Descargados</th>
				<th style="&header;">Última actualización</th>
			</tr>
			<xsl:for-each select="Solicitud">
				<xsl:sort select="@FechaConsultada" order="ascending"/>
				<tr>
					<td style="&celda;">
						<xsl:value-of select="@RFC"/>
					</td>
					<td style="&celda; &nowrap;">
						<xsl:value-of select="@FechaConsultada"/>
					</td>
					<td style="&celda; &nowrap; text-align:center; font-weight:bold;">
						<xsl:attribute name="style">
							<xsl:text>&celda; &nowrap; text-align:center; font-weight:bold; </xsl:text>
							<xsl:call-template name="styleEstatusSolicitud">
								<xsl:with-param name="estatus" select="@EstatusConsulta"/>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:value-of select="@EstatusConsulta"/>
					</td>
					<td style="&celda; text-align:right;">
						<xsl:value-of select="@Comprobantes"/>
					</td>
					<td style="&celda; text-align:right;">
						<xsl:value-of select="count(Comprobante)"/>
					</td>
					<td style="&celdaRight; &nowrap;">
						<xsl:value-of select="@UltimaActualizacion"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>

	<xsl:template name="incidenciasComplementos">
		<h2 style="font-size:15px; color:#364C4A; margin-top:18px;">Complementos con incidencias</h2>
		<xsl:choose>
			<xsl:when test="count(//Comprobante[@Tipo='complemento'][not(FacturaRelacionada) or FacturaRelacionada[@Estatus!='Aplicado']]) &gt; 0">
				<table cellpadding="0" cellspacing="2" style="width:100%; font-size:10px; font-family:Verdana, Arial, sans-serif;">
					<tr>
						<th style="&header;">RFC</th>
						<th style="&header;">UUID complemento</th>
						<th style="&header;">Emisor</th>
						<th style="&header;">Factura relacionada</th>
						<th style="&header;">Serie/Folio</th>
						<th style="&header;">Imp. pagado</th>
						<th style="&header;">Problema</th>
					</tr>
					<xsl:for-each select="//Comprobante[@Tipo='complemento'][not(FacturaRelacionada)]">
						<tr>
							<td style="&celda;">
								<xsl:value-of select="../@RFC"/>
							</td>
							<td style="&celda;">
								<xsl:value-of select="@UUID"/>
							</td>
							<td style="&celda;">
								<xsl:value-of select="@Emisor"/>
							</td>
							<td style="&celda;" colspan="3">Sin factura relacionada en el XML de reporte</td>
							<td style="&celdaRight; &warning; font-weight:bold;">Sin relación</td>
						</tr>
					</xsl:for-each>
					<xsl:for-each select="//Comprobante[@Tipo='complemento']/FacturaRelacionada[@Estatus!='Aplicado']">
						<tr>
							<td style="&celda;">
								<xsl:value-of select="../../@RFC"/>
							</td>
							<td style="&celda;">
								<xsl:value-of select="../@UUID"/>
							</td>
							<td style="&celda;">
								<xsl:value-of select="../@Emisor"/>
							</td>
							<td style="&celda;">
								<xsl:value-of select="@UUID"/>
							</td>
							<td style="&celda;">
								<xsl:value-of select="@Serie"/>
								<xsl:if test="@Serie and @Folio">
									<xsl:text> / </xsl:text>
								</xsl:if>
								<xsl:value-of select="@Folio"/>
							</td>
							<td style="&celda; text-align:right;">
								<xsl:call-template name="money">
									<xsl:with-param name="value" select="@ImpPagado"/>
								</xsl:call-template>
							</td>
							<td>
								<xsl:attribute name="style">
									<xsl:text>&celdaRight; font-weight:bold; text-align:center; </xsl:text>
									<xsl:call-template name="styleEstatusFactura">
										<xsl:with-param name="estatus" select="@Estatus"/>
									</xsl:call-template>
								</xsl:attribute>
								<xsl:value-of select="@Estatus"/>
							</td>
						</tr>
					</xsl:for-each>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<div style="&card; border-left:5px solid #7EA84A;">
					No se detectaron incidencias en facturas relacionadas de complementos.
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="resumenRFC">
		<h2 style="font-size:15px; color:#364C4A; margin-top:18px;">Resumen por RFC</h2>
		<table cellpadding="0" cellspacing="2" style="width:100%; font-size:10px; font-family:Verdana, Arial, sans-serif;">
			<tr>
				<th style="&header;">RFC</th>
				<th style="&header;">Solicitudes</th>
				<th style="&header;">CFDI SAT</th>
				<th style="&header;">Descargados</th>
				<th style="&header;">Complementos</th>
				<th style="&header;">Incidencias</th>
			</tr>
			<xsl:for-each select="Solicitud[generate-id() = generate-id(key('solicitudesPorRFC', @RFC)[1])]">
				<xsl:sort select="@RFC"/>
				<xsl:variable name="rfc" select="@RFC"/>
				<tr>
					<td style="&celda;">
						<xsl:value-of select="$rfc"/>
					</td>
					<td style="&celda; text-align:right;">
						<xsl:value-of select="count(key('solicitudesPorRFC', $rfc))"/>
					</td>
					<td style="&celda; text-align:right;">
						<xsl:value-of select="sum(key('solicitudesPorRFC', $rfc)/@Comprobantes)"/>
					</td>
					<td style="&celda; text-align:right;">
						<xsl:value-of select="count(key('solicitudesPorRFC', $rfc)/Comprobante)"/>
					</td>
					<td style="&celda; text-align:right;">
						<xsl:value-of select="count(key('solicitudesPorRFC', $rfc)/Comprobante[@Tipo='complemento'])"/>
					</td>
					<td style="&celdaRight; text-align:right; font-weight:bold;">
						<xsl:value-of select="count(key('solicitudesPorRFC', $rfc)/Comprobante[@Tipo='complemento'][not(FacturaRelacionada) or FacturaRelacionada[@Estatus!='Aplicado']])"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>

	<xsl:template name="detalleSolicitudes">
		<h2 style="font-size:15px; color:#364C4A; margin-top:18px;">Detalle de solicitudes</h2>
		<xsl:if test="not(..)">
			<div style="font-size:10px; color:#747678; margin-bottom:8px;">
				En clientes de correo compatibles, cada solicitud puede contraerse o expandirse. En Outlook puede mostrarse siempre abierto o sin interacción.
			</div>
		</xsl:if>
		<xsl:for-each select="Solicitud">
			<xsl:sort select="@FechaConsultada" order="ascending"/>
			<details>
				<xsl:if test="@EstatusConsulta='Error' or Comprobante[@Tipo='complemento'][not(FacturaRelacionada) or FacturaRelacionada[@Estatus!='Aplicado']]">
					<xsl:attribute name="open">open</xsl:attribute>
				</xsl:if>
				<summary style="font-weight:bold; cursor:pointer; padding:8px; border:1px solid #D7DAD7; margin-top:8px; background-color: #364c4a; color: white;">
					<xsl:value-of select="@RFC"/>
					<xsl:text> — </xsl:text>
					<xsl:value-of select="@FechaConsultada"/>
					<xsl:text> — </xsl:text>
					<xsl:value-of select="@EstatusConsulta"/>
					<xsl:text> — CFDI SAT: </xsl:text>
					<xsl:value-of select="@Comprobantes"/>
					<xsl:text>, descargados: </xsl:text>
					<xsl:value-of select="count(Comprobante)"/>
					<xsl:if test="Comprobante[@Tipo='complemento'][not(FacturaRelacionada) or FacturaRelacionada[@Estatus!='Aplicado']]">
						<xsl:text> — Incidencias en complementos: </xsl:text>
						<xsl:value-of select="count(Comprobante[@Tipo='complemento'][not(FacturaRelacionada) or FacturaRelacionada[@Estatus!='Aplicado']])"/>
					</xsl:if>
				</summary>
				<div style="&card; padding:6px 10px 7px 10px;">
					<table cellpadding="0" cellspacing="0" style="width:100%; font-size:9px; font-family:Verdana, Arial, sans-serif; color:#333;">
						<tr>
							<td style="width:34%; padding-right:10px; vertical-align:top;">
								<strong style="color:#555;">Solicitud</strong>
								<br/>
								<span style="font-family:Consolas, monospace; font-size:8.5px; color:#222;">
									<xsl:value-of select="@SolicitudId"/>
								</span>
							</td>

							<td style="width:33%; padding:0 10px; border-left:1px solid #D7DAD7; vertical-align:top;">
								<strong style="color:#555;">Última actualización</strong>
								<br/>
								<xsl:value-of select="@UltimaActualizacion"/>
							</td>

							<td style="width:33%; padding-left:10px; border-left:1px solid #D7DAD7; vertical-align:top;">
								<strong style="color:#555;">Dirección</strong>
								<br/>
								<xsl:value-of select="@Direccion"/>
							</td>
						</tr>
					</table>

					<xsl:if test="count(Comprobante) &gt; 0">
						<table cellpadding="0" cellspacing="2" style="width:100%; font-size:10px; font-family:Verdana, Arial, sans-serif; margin-top: .5rem;">
							<tr>
								<th style="&header;">Fecha</th>
								<th style="&header;">Tipo</th>
								<th style="&header;">UUID</th>
								<th style="&header;">Emisor</th>
								<th style="&header;">Receptor</th>
								<th style="&header;">Total</th>
								<th style="&header;">StatusSAT</th>
								<th style="&header;">Estatus</th>
							</tr>
							<xsl:for-each select="Comprobante">
								<xsl:sort select="@Fecha"/>
								<tr>
									<td style="&celda; &nowrap;">
										<xsl:value-of select="@Fecha"/>
									</td>
									<td style="&celda;">
										<xsl:value-of select="@Tipo"/>
									</td>
									<td style="&celda;">
										<xsl:value-of select="@UUID"/>
									</td>
									<td style="&celda;">
										<xsl:value-of select="@Emisor"/>
									</td>
									<td style="&celda;">
										<xsl:value-of select="@Receptor"/>
									</td>
									<td style="&celda; text-align:right;">
										<xsl:call-template name="money">
											<xsl:with-param name="value" select="@Total"/>
										</xsl:call-template>
									</td>
									<td style="&celda;">
										<xsl:value-of select="@StatusSAT"/>
									</td>
									<td>
										<xsl:attribute name="style">
											<xsl:text>&celdaRight; font-weight:bold; text-align:center; </xsl:text>
											<xsl:call-template name="styleEstatusFactura">
												<xsl:with-param name="estatus" select="@Estatus"/>
											</xsl:call-template>
										</xsl:attribute>
										<xsl:value-of select="@Estatus"/>
									</td>
								</tr>
								<xsl:if test="FacturaRelacionada">
									<tr>
										<td style="&celda; background-color:#FAFAFA;" colspan="8">
											<table cellpadding="0" cellspacing="2" style="width:100%; font-size:10px; font-family:Verdana, Arial, sans-serif;">
												<tr>
													<th style="&header;">Factura relacionada</th>
													<th style="&header;">Serie/Folio</th>
													<th style="&header;">Fecha pago</th>
													<th style="&header;">Imp. pagado</th>
													<th style="&header;">Saldo anterior</th>
													<th style="&header;">Saldo insoluto</th>
													<th style="&header;">StatusSAT</th>
													<th style="&header;">Estatus</th>
												</tr>
												<xsl:for-each select="FacturaRelacionada">
													<tr>
														<td style="&celda;">
															<xsl:value-of select="@UUID"/>
														</td>
														<td style="&celda;">
															<xsl:value-of select="@Serie"/>
															<xsl:if test="@Serie and @Folio">
																<xsl:text> / </xsl:text>
															</xsl:if>
															<xsl:value-of select="@Folio"/>
														</td>
														<td style="&celda; &nowrap;">
															<xsl:value-of select="@FechaPago"/>
														</td>
														<td style="&celda; text-align:right;">
															<xsl:call-template name="money">
																<xsl:with-param name="value" select="@ImpPagado"/>
															</xsl:call-template>
														</td>
														<td style="&celda; text-align:right;">
															<xsl:call-template name="money">
																<xsl:with-param name="value" select="@ImpSaldoAnt"/>
															</xsl:call-template>
														</td>
														<td style="&celda; text-align:right;">
															<xsl:call-template name="money">
																<xsl:with-param name="value" select="@ImpSaldoInsoluto"/>
															</xsl:call-template>
														</td>
														<td style="&celda;">
															<xsl:value-of select="@FacturaStatusSAT"/>
														</td>
														<td>
															<xsl:attribute name="style">
																<xsl:text>&celdaRight; font-weight:bold; text-align:center; </xsl:text>
																<xsl:call-template name="styleEstatusFactura">
																	<xsl:with-param name="estatus" select="@Estatus"/>
																</xsl:call-template>
															</xsl:attribute>
															<xsl:value-of select="@Estatus"/>
														</td>
													</tr>
												</xsl:for-each>
											</table>
										</td>
									</tr>
								</xsl:if>
							</xsl:for-each>
						</table>
					</xsl:if>
				</div>
			</details>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="money">
		<xsl:param name="value"/>
		<xsl:choose>
			<xsl:when test="string($value) != ''">
				<xsl:value-of select="format-number(number($value), '$#,##0.00', 'money')"/>
			</xsl:when>
			<xsl:otherwise>-</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="styleEstatusSolicitud">
		<xsl:param name="estatus"/>
		<xsl:choose>
			<xsl:when test="$estatus='Descargado' or $estatus='Terminada' or $estatus='Terminado'">background-color:#7EA84A; color:#FFFFFF;</xsl:when>
			<xsl:when test="$estatus='Error'">background-color:#B00B11; color:#FFFFFF;</xsl:when>
			<xsl:otherwise>background-color:#FFCC00; color:#263238;</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="styleEstatusFactura">
		<xsl:param name="estatus"/>
		<xsl:choose>
			<xsl:when test="$estatus='Aplicado'">background-color:#7EA84A; color:#FFFFFF;</xsl:when>
			<xsl:when test="$estatus='Cancelado' or $estatus='No encontrado' or $estatus='Descargado sin aplicar'">background-color:#B00B11; color:#FFFFFF;</xsl:when>
			<xsl:otherwise>background-color:#FFCC00; color:#263238;</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
