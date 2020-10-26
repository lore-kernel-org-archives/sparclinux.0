From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Date: Mon, 26 Oct 2020 18:05:30 +0000
Subject: Re: [PATCH 0/4] arch, mm: improve robustness of direct map manipulation
Message-Id: <a0212b073b3b2f62c3dbf1bf398f03fa402997be.camel@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201025101555.3057-1-rppt@kernel.org>
 <ae82f905a0092adb7e0f0ac206335c1883b3170f.camel@intel.com>
 <20201026090526.GA1154158@kernel.org>
In-Reply-To: <20201026090526.GA1154158@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "rppt@kernel.org" <rppt@kernel.org>
Cc: "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "david@redhat.com" <david@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "paulus@samba.org" <paulus@samba.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "hpa@zytor.com" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "cl@linux.com" <cl@linux.com>, "will@kernel.org" <will@kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "mingo@redhat.com" <mingo@redhat.com>, "rientjes@google.com" <rientjes@google.com>, "Brown,
 Len" <len.brown@intel.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "bp@alien8.de" <bp@alien8.de>, "luto@kernel.org" <luto@kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "kirill@shutemov.name" <kirill@shutemov.name>, "tglx@linutronix.de" <tglx@linutronix.de>, "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "penberg@kernel.org" <penberg@kernel.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "davem@davemloft.net" <davem@davemloft.net>

T24gTW9uLCAyMDIwLTEwLTI2IGF0IDExOjA1ICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBPbiBNb24sIE9jdCAyNiwgMjAyMCBhdCAwMToxMzo1MkFNICswMDAwLCBFZGdlY29tYmUsIFJp
Y2sgUCB3cm90ZToNCj4gPiBPbiBTdW4sIDIwMjAtMTAtMjUgYXQgMTI6MTUgKzAyMDAsIE1pa2Ug
UmFwb3BvcnQgd3JvdGU6DQo+ID4gPiBJbmRlZWQsIGZvciBhcmNoaXRlY3R1cmVzIHRoYXQgZGVm
aW5lDQo+ID4gPiBDT05GSUdfQVJDSF9IQVNfU0VUX0RJUkVDVF9NQVANCj4gPiA+IGl0IGlzDQo+
ID4gPiBwb3NzaWJsZSB0aGF0IF9fa2VybmVsX21hcF9wYWdlcygpIHdvdWxkIGZhaWwsIGJ1dCBz
aW5jZSB0aGlzDQo+ID4gPiBmdW5jdGlvbiBpcw0KPiA+ID4gdm9pZCwgdGhlIGZhaWx1cmUgd2ls
bCBnbyB1bm5vdGljZWQuDQo+ID4gDQo+ID4gQ291bGQgeW91IGVsYWJvcmF0ZSBvbiBob3cgdGhp
cyBjb3VsZCBoYXBwZW4/IERvIHlvdSBtZWFuIGR1cmluZw0KPiA+IHJ1bnRpbWUgdG9kYXkgb3Ig
aWYgc29tZXRoaW5nIG5ldyB3YXMgaW50cm9kdWNlZD8NCj4gDQo+IEEgZmFpbHVyZSBpbl9fa2Vy
bmVsX21hcF9wYWdlcygpIG1heSBoYXBwZW4gdG9kYXkuIEZvciBpbnN0YW5jZSwgb24NCj4geDg2
DQo+IGlmIHRoZSBrZXJuZWwgaXMgYnVpbHQgd2l0aCBERUJVR19QQUdFQUxMT0MuDQo+IA0KPiAg
ICAgICAgIF9fa2VybmVsX21hcF9wYWdlcyhwYWdlLCAxLCAwKTsNCj4gDQo+IHdpbGwgbmVlZCB0
byBzcGxpdCwgc2F5LCAyTSBwYWdlIGFuZCBkdXJpbmcgdGhlIHNwbGl0IGFuIGFsbG9jYXRpb24N
Cj4gb2YNCj4gcGFnZSB0YWJsZSBjb3VsZCBmYWlsLg0KDQpPbiB4ODYgYXQgbGVhc3QsIERFQlVH
X1BBR0VBTExPQyBleHBlY3RzIHRvIG5ldmVyIGhhdmUgdG8gYnJlYWsgYSBwYWdlDQpvbiB0aGUg
ZGlyZWN0IG1hcCBhbmQgZXZlbiBkaXNhYmxlcyBsb2NraW5nIGluIGNwYSBiZWNhdXNlIGl0IGFz
c3VtZXMNCnRoaXMuIElmIHRoaXMgaXMgaGFwcGVuaW5nIHNvbWVob3cgYW55d2F5IHRoZW4gd2Ug
c2hvdWxkIHByb2JhYmx5IGZpeA0KdGhhdC4gRXZlbiBpZiBpdCdzIGEgZGVidWcgZmVhdHVyZSwg
aXQgd2lsbCBub3QgYmUgYXMgdXNlZnVsIGlmIGl0IGlzDQpjYXVzaW5nIGl0cyBvd24gY3Jhc2hl
cy4NCg0KSSdtIHN0aWxsIHdvbmRlcmluZyBpZiB0aGVyZSBpcyBzb21ldGhpbmcgSSdtIG1pc3Np
bmcgaGVyZS4gSXQgc2VlbXMNCmxpa2UgeW91IGFyZSBzYXlpbmcgdGhlcmUgaXMgYSBidWcgaW4g
c29tZSBhcmNoJ3MsIHNvIGxldCdzIGFkZCBhIFdBUk4NCmluIGNyb3NzLWFyY2ggY29kZSB0byBs
b2cgaXQgYXMgaXQgY3Jhc2hlcy4gQSB3YXJuIGFuZCBtYWtpbmcgdGhpbmdzDQpjbGVhcmVyIHNl
ZW0gbGlrZSBnb29kIGlkZWFzLCBidXQgaWYgdGhlcmUgaXMgYSBidWcgd2Ugc2hvdWxkIGZpeCBp
dC4NClRoZSBjb2RlIGFyb3VuZCB0aGUgY2FsbGVycyBzdGlsbCBmdW5jdGlvbmFsbHkgYXNzdW1l
IHJlLW1hcHBpbmcgY2FuJ3QNCmZhaWwuDQoNCj4gQ3VycmVudGx5LCB0aGUgb25seSB1c2VyIG9m
IF9fa2VybmVsX21hcF9wYWdlcygpIG91dHNpZGUNCj4gREVCVUdfUEFHRUFMTE9DDQo+IGlzIGhp
YmVybmF0aW9uLCBidXQgSSB0aGluayBpdCB3b3VsZCBiZSBzYWZlciB0byBlbnRpcmVseSBwcmV2
ZW50DQo+IHVzYWdlDQo+IG9mIF9fa2VybmVsX21hcF9wYWdlcygpIHdoZW4gREVCVUdfUEFHRUFM
TE9DPW4uDQoNCkkgdG90YWxseSBhZ3JlZSBpdCdzIGVycm9yIHByb25lIEZXSVcuIE9uIHg4Niwg
bXkgbWVudGFsIG1vZGVsIG9mIGhvdw0KaXQgaXMgc3VwcG9zZWQgdG8gd29yayBpczogSWYgYSBw
YWdlIGlzIDRrIGFuZCBOUCBpdCBjYW5ub3QgZmFpbCB0byBiZQ0KcmVtYXBwZWQuIHNldF9kaXJl
Y3RfbWFwX2ludmFsaWRfbm9mbHVzaCgpIHNob3VsZCByZXN1bHQgaW4gNGsgTlANCnBhZ2VzLCBh
bmQgREVCVUdfUEFHRUFMTE9DIHNob3VsZCByZXN1bHQgaW4gYWxsIDRrIHBhZ2VzIG9uIHRoZSBk
aXJlY3QNCm1hcC4gQXJlIHlvdSBzZWVpbmcgdGhpcyB2aW9sYXRlZCBvciBkbyBJIGhhdmUgd3Jv
bmcgYXNzdW1wdGlvbnM/DQoNCkJleW9uZCB3aGF0ZXZlciB5b3UgYXJlIHNlZWluZywgZm9yIHRo
ZSBsYXR0ZXIgY2FzZSBvZiBuZXcgdGhpbmdzDQpnZXR0aW5nIGludHJvZHVjZWQgdG8gYW4gaW50
ZXJmYWNlIHdpdGggaGlkZGVuIGRlcGVuZGVuY2llcy4uLiBBbm90aGVyDQplZGdlIGNhc2UgY291
bGQgYmUgYSBuZXcgY2FsbGVyIHRvIHNldF9tZW1vcnlfbnAoKSBjb3VsZCByZXN1bHQgaW4NCmxh
cmdlIE5QIHBhZ2VzLiBOb25lIG9mIHRoZSBjYWxsZXJzIHRvZGF5IHNob3VsZCBjYXVzZSB0aGlz
IEFGQUlDVCwgYnV0DQppdCdzIG5vdCBncmVhdCB0byByZWx5IG9uIHRoZSBjYWxsZXJzIHRvIGtu
b3cgdGhlc2UgZGV0YWlscy4NCg0KDQo
