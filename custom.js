xo.spaces["expanded"] = "http://panax.io/state/expanded";
xo.spaces["visible"] = "http://panax.io/state/visible";
xo.spaces["hidden"] = "http://panax.io/state/hidden";
xo.listener.on('xover-initialized', function ({ progress_renders }) {
	if ('#loading' in xover.manifest.sources) {
		progress_renders.concat(xover.sources['#loading'].render());
	}
})

xover.listener.on('xover-initialized', function () {
	window.setInterval(function () {
		xover.session.checkStatus();
	}, 900000);
})

xo.listener.on('change::model/*/*/@state:checked[.="true"]', function ({ element, stylesheet, srcElement, value, old }) {
	let id = element.getAttributeNode("id") || element.getAttributeNode("mes")
	if (!(srcElement instanceof SVGElement)) {
		if (value) {
			element.select(`../${element.nodeName}[not(@${id.nodeName}="${id}")]/@state:checked`).remove()
		}
	}
})

xo.listener.on(['append::dialog[open]'], function () {
	this.close()
	this.showModal()
})

xo.listener.on([`beforeTransform::model[*/@filter:*]`, `beforeTransform?stylesheet.href=auxiliar_cuentas.xslt`], function () {
	for (let attr of this.select(`//@filter:*`)) {
		this.select(`//movimientos/row[not(@xsi:type="mock")][${attr.value.split("|").map(value => `@${attr.localName}!="${value}"`).join(" and ")}]`).forEach(el => el.remove())
	}
})

xo.listener.on("fetch::xo:response", function () {
	let new_node = this.selectFirst('xo:response//model');
	new_node instanceof Element && this.documentElement.replaceWith(new_node)
})

xo.listener.on('beforeRender::html:dialog', function ({ element }) {
	if ([...document.querySelectorAll('dialog')].find(dialog => dialog.isEqualNode(element))) {
		event.preventDefault()
	}
})

xo.listener.skipSelector(".dropdown-menu.show")

mostrarGrafica = function () {
	let chart = document.getElementById('myChart');
	let offcanvas = chart.closest('.offcanvas');
	offcanvas && bootstrap.Offcanvas.getOrCreateInstance(offcanvas).show()
}

createCommand = function (params = {}) {
	return Object.entries(params).filter(entry => entry[0][0] != '^').map(([field, value], ix) => field == 'command' ? `EXEC ${value} ` : `${(ix > 1 ? ', ' : '') + field}='${value}'`).join('')
}

xo.listener.on('mutate::html', function ({ mutations }) {
	if (mutations.size > 10) {
		mutations.clear();
	}
})

xover.listener.on(`beforeFetch?request`, function ({ request, settings }) {
	let session_id = request.headers.get("x-session-id") || xo.session[`${request.url.host}:id`];
	session_id && request.headers.set("x-session-id", session_id);
	let rebuild = xo.session.rebuild;
	rebuild && request.headers.set("x-rebuild", rebuild);
})

xo.listener.on(["fetch?href=^server/::*", "fetch?host=^server.panax.io::*", "fetch?host=*.ngrok*"], function ({ response, document, url }) {
	if (!(document && document.nodeType === Node.DOCUMENT_NODE)) return;
	for (let stylesheet of document.stylesheets || []) {
		let href = stylesheet.href;
		if (!href) continue;
		stylesheet.href = href.replace(/^([^/.])/, '/$1')
	}
	// backwards compatibility
	for (let control of document.select(`//*[not(@navbar:control)]/@navbar:filter`)) {
		control.parentNode.removeAttribute("navbar:position")
		control.remove()
	}
	for (let row of document.select(`//row[@state:page]`)) {
		let url = document.url.clone();
		url.searchParams.set("@page_index", row.getAttributeNodeNS("http://panax.io/state", "page"));
		url.fetch().then(document => {
			row.replaceWith(...document.select(`//${row.parentNode.nodeName}/*`))
		})
	}
})

xo.listener.on('xover-initializing', function ({ progress_renders }) {
	if ('#loading' in xover.manifest.sources) {
		progress_renders.concat(xover.sources['#loading'].render());
	}
})

xover.listener.on('Response:reject?status=401&bodyType=html', function ({ }) {
	return { "message": "" };
})

async function updateTunnel() {
	try {
		let gist = xover.manifest.session.gist;
		if (!gist) return;
		await fetch(gist)
			.then(res => res.text())
			.then(gist => {
				gist = xover.json.tryParse(gist);
				xover.session.server = gist["tunnel"] || gist;
			})
		if (!xover.session.server) xover.session.server = prompt("Proporcione la dirección del túnel")
	} catch (e) {
		console.error(e)
	}
}

Object.defineProperty(xover.session, 'login', {
	value: async function (username, password, ...args) {
		if ('login' in xover.server) {
			try {
				username = username instanceof HTMLElement ? username.value : username;
				password = password instanceof HTMLElement ? password.value : password;
				xover.session.user_login = username;
				xover.session.status = 'authorizing';
				let authorization = `Basic ${btoa(username + ':' + password)}`;
				await xover.server.login(...args, new Headers({ authorization }), (return_value, request) => { xover.session[`${request.url.host}:id`] = return_value.id });
				xover.session.status = 'authorized';
				xover.session.id_token = authorization;
				if (xover.site.seed === '#login') {
					window.location = '#'
				} else {
					xover.stores.active.render();
				}
			} catch (e) {
				xover.session.status = 'unauthorized';
				return Promise.reject(e);
			}
		} else {
			xover.session.status = 'authorized';
			window.dispatchEvent(new xover.listener.Event('login', {}, this));
			return false;
		}
	}, writable: true, configurable: true
})

function filterSelection() {
	for (let selection of this.select(`//@state:selected`).filter(attr => attr.value)) {
		let node = selection.parentNode;
		let attr = node.getAttributeNS("http://widgets.panaxbi.com/navbar", "text") || 'desc'
		let rows = node.select(`row[not(@id="${selection.value}")]`)
		rows.remove();
	}
}

function filterTarget({ stylesheet }) {
	let target = stylesheet.target;
	if (!(target || {}).nodeType === Node.ELEMENT_NODE) return false;
	if (target.matches("main")) return true
}
xo.listener.on(`beforeTransform?filterTarget::*[descendant-or-self::*[@navbar:*][@state:selected]]`, filterSelection)

xo.listener.on(`fetch::#reporte_interapas`, function ({ document }) {
	document.select(`//@adeudo_actual[starts-with(.,"$")]`).forEach(attr => attr.value = attr.value.replace(/[\$,]/g, ''))
})

async function sync_url({ document, value }) {
	let url = document.url;
	if (!url) return;
	for (let field of [...document.querySelectorAll(`form fieldset > [name]`)]) {
		let field_name = field.scope.closest('*').localName;
		if (!field.value || field.closest(`.mutually-exclusive`) && field.matches(`[type=hidden]`)) {
			url.searchParams.delete(`@${field_name}`)
		} else {
			url.searchParams.set(`@${field_name}`, field.value)
		}
	}
	if (instanceOf.call(this, Attr)) {
		let param_name = this.parentNode.nodeName;
		if (url.searchParams.has(`@${param_name}`) && !value || value) {
			url.searchParams.set(`@${param_name}`, value || null);
			document.fetch()
		}
	}
}
xover.listener.on([`change::*[@navbar:*]/@state:selected`], sync_url)

xover.listener.on(`change::contratos/@state:selected`, function () {
	event.stopImmediatePropagation()
})

xo.listener.on('render', function ({ document }) {
	for (let img of document.querySelectorAll('img')) {
		img.src = img.src.replace('http://habi.panax.io/', '')
	}
})

xo.listener.on(['beforeFetch::?FROM=^Interapas.#server:request'], async function ({ request }) {
	let trackers = request.trackers;
	for (let tracker of trackers) {
		tracker.remove()
	}
	trackers.clear();
	trackers.add(document.body.appendChild(document.createElement("px-loader")));
})
async function new_revision() {
	let document = await xover.sources["#reporte_interapas"].ready;
	let archivo = document.single(`//archivo/@state:selected`);
	if (!archivo) return Promise.reject("Por favor seleccione el archivo que quiere generar revisión");
	let payload = document.select(`//contratos`);
	try {
		let result = await xover.server.crearRevision(new URLSearchParams(`@archivo=${archivo}`), new File([payload], "@xml", { type: "text/xml" }), (result, response) => response);
		let revision_id = result.headers.get("x-revision-id");
		document.source.url.parameters["@revision"] = revision_id;
		document.fetch();
		return Promise.resolve(result)
	} catch (e) {
		return Promise.reject(`No se pudo generar la revisión, intente más tarde o repórtelo con el administrador.`);
	}
}
/*xo.listener.on(`change::revision/@state:selected[.="[new]"]`, new_revision)*/