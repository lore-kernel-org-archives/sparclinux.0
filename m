From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Date: Tue, 21 May 2019 01:59:54 +0000
Subject: Re: [PATCH v2] vmalloc: Fix issues with flush flag
Message-Id: <339ef85d984f329aa66f29fa80781624e6e4aecc.camel@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <3e7e674c1fe094cd8dbe0c8933db18be1a37d76d.camel@intel.com>
	 <20190520.203320.621504228022195532.davem@davemloft.net>
	 <a43f9224e6b245ade4b587a018c8a21815091f0f.camel@intel.com>
	 <20190520.184336.743103388474716249.davem@davemloft.net>
In-Reply-To: <20190520.184336.743103388474716249.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "davem@davemloft.net" <davem@davemloft.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mroos@linux.ee" <mroos@linux.ee>, "mingo@redhat.com" <mingo@redhat.com>, "namit@vmware.com" <namit@vmware.com>, "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Hansen, Dave" <dave.hansen@intel.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>

T24gTW9uLCAyMDE5LTA1LTIwIGF0IDE4OjQzIC0wNzAwLCBEYXZpZCBNaWxsZXIgd3JvdGU6DQo+
IEZyb206ICJFZGdlY29tYmUsIFJpY2sgUCIgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0K
PiBEYXRlOiBUdWUsIDIxIE1heSAyMDE5IDAxOjIwOjMzICswMDAwDQo+IA0KPiA+IFNob3VsZCBp
dCBoYW5kbGUgZXhlY3V0aW5nIGFuIHVubWFwcGVkIHBhZ2UgZ3JhY2VmdWxseT8gQmVjYXVzZQ0K
PiA+IHRoaXMNCj4gPiBjaGFuZ2UgaXMgY2F1c2luZyB0aGF0IHRvIGhhcHBlbiBtdWNoIGVhcmxp
ZXIuIElmIHNvbWV0aGluZyB3YXMNCj4gPiByZWx5aW5nDQo+ID4gb24gYSBjYWNoZWQgdHJhbnNs
YXRpb24gdG8gZXhlY3V0ZSBzb21ldGhpbmcgaXQgY291bGQgZmluZCB0aGUNCj4gPiBtYXBwaW5n
DQo+ID4gZGlzYXBwZWFyLg0KPiANCj4gRG9lcyB0aGlzIHdvcmsgYnkgbm90IG1hcHBpbmcgYW55
IGtlcm5lbCBtYXBwaW5ncyBhdCB0aGUgYmVnaW5uaW5nLA0KPiBhbmQgdGhlbiBmaWxsaW5nIGlu
IHRoZSBCUEYgbWFwcGluZ3MgaW4gcmVzcG9uc2UgdG8gZmF1bHRzPw0KTm8sIG5vdGhpbmcgdG9v
IGZhbmN5LiBJdCBqdXN0IGZsdXNoZXMgdGhlIHZtIG1hcHBpbmcgaW1tZWRpYXRseSBpbg0KdmZy
ZWUgZm9yIGV4ZWN1dGUgKGFuZCBSTykgbWFwcGluZ3MuIFRoZSBvbmx5IHRoaW5nIHRoYXQgaGFw
cGVucyBhcm91bmQNCmFsbG9jYXRpb24gdGltZSBpcyBzZXR0aW5nIG9mIGEgbmV3IGZsYWcgdG8g
dGVsbCB2bWFsbG9jIHRvIGRvIHRoZQ0KZmx1c2guDQoNClRoZSBwcm9ibGVtIGJlZm9yZSB3YXMg
dGhhdCB0aGUgcGFnZXMgd291bGQgYmUgZnJlZWQgYmVmb3JlIHRoZSBleGVjdXRlDQptYXBwaW5n
IHdhcyBmbHVzaGVkLiBTbyB0aGVuIHdoZW4gdGhlIHBhZ2VzIGdvdCByZWN5Y2xlZCwgcmFuZG9t
LA0Kc29tZXRpbWVzIGNvbWluZyBmcm9tIHVzZXJzcGFjZSwgZGF0YSB3b3VsZCBiZSBtYXBwZWQg
YXMgZXhlY3V0YWJsZSBpbg0KdGhlIGtlcm5lbCBieSB0aGUgdW4tZmx1c2hlZCB0bGIgZW50cmll
cy4NCg0KDQo
