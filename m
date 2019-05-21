From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Date: Tue, 21 May 2019 00:20:13 +0000
Subject: Re: [PATCH v2] vmalloc: Fix issues with flush flag
Message-Id: <3e7e674c1fe094cd8dbe0c8933db18be1a37d76d.camel@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190520200703.15997-1-rick.p.edgecombe@intel.com>
	 <90f8a4e1-aa71-0c10-1a91-495ba0cb329b@linux.ee>
	 <c6020a01e81d08342e1a2b3ae7e03d55858480ba.camel@intel.com>
	 <20190520.154855.2207738976381931092.davem@davemloft.net>
In-Reply-To: <20190520.154855.2207738976381931092.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "davem@davemloft.net" <davem@davemloft.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mroos@linux.ee" <mroos@linux.ee>, "mingo@redhat.com" <mingo@redhat.com>, "namit@vmware.com" <namit@vmware.com>, "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Hansen, Dave" <dave.hansen@intel.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>

T24gTW9uLCAyMDE5LTA1LTIwIGF0IDE1OjQ4IC0wNzAwLCBEYXZpZCBNaWxsZXIgd3JvdGU6DQo+
IEZyb206ICJFZGdlY29tYmUsIFJpY2sgUCIgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0K
PiBEYXRlOiBNb24sIDIwIE1heSAyMDE5IDIyOjE3OjQ5ICswMDAwDQo+IA0KPiA+IFRoYW5rcyBm
b3IgdGVzdGluZy4gU28gSSBndWVzcyB0aGF0IHN1Z2dlc3RzIGl0J3MgdGhlIFRMQiBmbHVzaA0K
PiA+IGNhdXNpbmcNCj4gPiB0aGUgcHJvYmxlbSBvbiBzcGFyYyBhbmQgbm90IGFueSBsYXp5IHB1
cmdlIGRlYWRsb2NrLiBJIGhhZCBzZW50DQo+ID4gTWVlbGlzDQo+ID4gYW5vdGhlciB0ZXN0IHBh
dGNoIHRoYXQganVzdCBmbHVzaGVkIHRoZSBlbnRpcmUgMCB0byBVTE9OR19NQVgNCj4gPiByYW5n
ZSB0bw0KPiA+IHRyeSB0byBhbHdheXMgdGhlIGdldCB0aGUgImZsdXNoIGFsbCIgbG9naWMgYW5k
IGFwcHJlbnRseSBpdCBkaWRuJ3QNCj4gPiBib290IG1vc3RseSBlaXRoZXIuIEl0IGFsc28gc2hv
d2VkIHRoYXQgaXQncyBub3QgZ2V0dGluZyBzdHVjaw0KPiA+IGFueXdoZXJlDQo+ID4gaW4gdGhl
IHZtX3JlbW92ZV9hbGlhcygpIGZ1bmN0aW9uLiBTb21ldGhpbmcganVzdCBoYW5ncyBsYXRlci4N
Cj4gDQo+IEkgd29uZGVyIGlmIGFuIGFkZHJlc3MgaXMgbWFraW5nIGl0IHRvIHRoZSBUTEIgZmx1
c2ggcm91dGluZXMgd2hpY2gNCj4gaXMNCj4gbm90IHBhZ2UgYWxpZ25lZC4NCkkgdGhpbmsgdm1h
bGxvYyBzaG91bGQgZm9yY2UgUEFHRV9TSVpFIGFsaWdubWVudCwgYnV0IHdpbGwgZG91YmxlIGNo
ZWNrDQpub3RoaW5nIGdvdCBzY3Jld2VkIHVwLg0KDQo+IE9yIGEgVExCIGZsdXNoIGlzIGJlaW5n
IGRvbmUgYmVmb3JlIHRoZSBjYWxsc2l0ZXMNCj4gYXJlIHBhdGNoZWQgcHJvcGVybHkgZm9yIHRo
ZSBnaXZlbiBjcHUgdHlwZS4NCkFueSBpZGVhIGhvdyBJIGNvdWxkIGxvZyB3aGVuIHRoaXMgaXMg
ZG9uZT8gSXQgbG9va3MgbGlrZSBpdCdzIGRvbmUNCnJlYWxseSBlYXJseSBpbiBib290IGFzc2Vt
Ymx5LiBUaGlzIGJlaGF2aW9yIHNob3VsZG4ndCBoYXBwZW4gdW50aWwNCm1vZHVsZXMgb3IgQlBG
IGFyZSBiZWluZyBmcmVlZC4NCg=
