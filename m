From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Date: Mon, 26 Oct 2020 18:57:32 +0000
Subject: Re: [PATCH 2/4] PM: hibernate: improve robustness of mapping pages in the direct map
Message-Id: <a28d8248057e7dc01716764da9edfd666722ff62.camel@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201025101555.3057-1-rppt@kernel.org>
 <20201025101555.3057-3-rppt@kernel.org>
 <f20900a403bea9eb3f0814128e5ea46f6580f5a5.camel@intel.com>
 <20201026091554.GB1154158@kernel.org>
In-Reply-To: <20201026091554.GB1154158@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "rppt@kernel.org" <rppt@kernel.org>
Cc: "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "david@redhat.com" <david@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "paulus@samba.org" <paulus@samba.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "hpa@zytor.com" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "cl@linux.com" <cl@linux.com>, "will@kernel.org" <will@kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "mingo@redhat.com" <mingo@redhat.com>, "rientjes@google.com" <rientjes@google.com>, "Brown,
 Len" <len.brown@intel.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "bp@alien8.de" <bp@alien8.de>, "luto@kernel.org" <luto@kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "kirill@shutemov.name" <kirill@shutemov.name>, "tglx@linutronix.de" <tglx@linutronix.de>, "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "penberg@kernel.org" <penberg@kernel.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "davem@davemloft.net" <davem@davemloft.net>

T24gTW9uLCAyMDIwLTEwLTI2IGF0IDExOjE1ICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBPbiBNb24sIE9jdCAyNiwgMjAyMCBhdCAxMjozODozMkFNICswMDAwLCBFZGdlY29tYmUsIFJp
Y2sgUCB3cm90ZToNCj4gPiBPbiBTdW4sIDIwMjAtMTAtMjUgYXQgMTI6MTUgKzAyMDAsIE1pa2Ug
UmFwb3BvcnQgd3JvdGU6DQo+ID4gPiBGcm9tOiBNaWtlIFJhcG9wb3J0IDxycHB0QGxpbnV4Lmli
bS5jb20+DQo+ID4gPiANCj4gPiA+IFdoZW4gREVCVUdfUEFHRUFMTE9DIG9yIEFSQ0hfSEFTX1NF
VF9ESVJFQ1RfTUFQIGlzIGVuYWJsZWQgYSBwYWdlDQo+ID4gPiBtYXkNCj4gPiA+IGJlDQo+ID4g
PiBub3QgcHJlc2VudCBpbiB0aGUgZGlyZWN0IG1hcCBhbmQgaGFzIHRvIGJlIGV4cGxpY2l0bHkg
bWFwcGVkDQo+ID4gPiBiZWZvcmUNCj4gPiA+IGl0DQo+ID4gPiBjb3VsZCBiZSBjb3BpZWQuDQo+
ID4gPiANCj4gPiA+IE9uIGFybTY0IGl0IGlzIHBvc3NpYmxlIHRoYXQgYSBwYWdlIHdvdWxkIGJl
IHJlbW92ZWQgZnJvbSB0aGUNCj4gPiA+IGRpcmVjdA0KPiA+ID4gbWFwDQo+ID4gPiB1c2luZyBz
ZXRfZGlyZWN0X21hcF9pbnZhbGlkX25vZmx1c2goKSBidXQgX19rZXJuZWxfbWFwX3BhZ2VzKCkN
Cj4gPiA+IHdpbGwNCj4gPiA+IHJlZnVzZQ0KPiA+ID4gdG8gbWFwIHRoaXMgcGFnZSBiYWNrIGlm
IERFQlVHX1BBR0VBTExPQyBpcyBkaXNhYmxlZC4NCj4gPiANCj4gPiBJdCBsb29rcyB0byBtZSB0
aGF0IGFybTY0IF9fa2VybmVsX21hcF9wYWdlcygpIHdpbGwgc3RpbGwgYXR0ZW1wdA0KPiA+IHRv
DQo+ID4gbWFwIGl0IGlmIHJvZGF0YV9mdWxsIGlzIHRydWUsIGhvdyBkb2VzIHRoaXMgaGFwcGVu
Pw0KPiANCj4gVW5sZXNzIEkgbWlzcmVhZCB0aGUgY29kZSwgYXJtNjQgcmVxdWlyZXMgYm90aCBy
b2RhdGFfZnVsbCBhbmQNCj4gZGVidWdfcGFnZWFsbG9jX2VuYWJsZWQoKSB0byBiZSB0cnVlIGZv
ciBfX2tlcm5lbF9tYXBfcGFnZXMoKSB0byBkbw0KPiBhbnl0aGluZy4NCj4gQnV0IHJvZGF0YV9m
dWxsIGNvbmRpdGlvbiBhcHBsaWVzIHRvIHNldF9kaXJlY3RfbWFwXypfbm9mbHVzaCgpIGFzDQo+
IHdlbGwsDQo+IHNvIHdpdGggIXJvZGF0YV9mdWxsIHRoZSBsaW5lYXIgbWFwIHdvbid0IGJlIGV2
ZXIgY2hhbmdlZC4NCg0KSG1tLCBsb29rcyB0byBtZSB0aGF0IF9fa2VybmVsX21hcF9wYWdlcygp
IHdpbGwgb25seSBza2lwIGl0IGlmIGJvdGgNCmRlYnVnIHBhZ2VhbGxvYyBhbmQgcm9kYXRhX2Z1
bGwgYXJlIGZhbHNlLg0KDQpCdXQgbm93IEknbSB3b25kZXJpbmcgaWYgbWF5YmUgd2UgY291bGQg
c2ltcGxpZnkgdGhpbmdzIGJ5IGp1c3QgbW92aW5nDQp0aGUgaGliZXJuYXRlIHVubWFwcGVkIHBh
Z2UgbG9naWMgb2ZmIG9mIHRoZSBkaXJlY3QgbWFwLiBPbiB4ODYsDQp0ZXh0X3Bva2UoKSB1c2Vk
IHRvIHVzZSB0aGlzIHJlc2VydmVkIGZpeG1hcCBwdGUgdGhpbmcgdGhhdCBpdCBjb3VsZA0KcmVs
eSBvbiB0byByZW1hcCBtZW1vcnkgd2l0aC4gSWYgaGliZXJuYXRlIGhhZCBzb21lIHNlcGFyYXRl
IHB0ZSBmb3INCnJlbWFwcGluZyBsaWtlIHRoYXQsIHRoZW4gd2UgY291bGQgbm90IGhhdmUgYW55
IGRpcmVjdCBtYXAgcmVzdHJpY3Rpb25zDQpjYXVzZWQgYnkgaXQva2VybmVsX21hcF9wYWdlcygp
LCBhbmQgaXQgd291bGRuJ3QgaGF2ZSB0byB3b3JyeSBhYm91dA0KcmVseWluZyBvbiBhbnl0aGlu
ZyBlbHNlLg0K
