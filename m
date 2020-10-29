From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Date: Thu, 29 Oct 2020 23:19:18 +0000
Subject: Re: [PATCH 2/4] PM: hibernate: improve robustness of mapping pages in the direct map
Message-Id: <604554805defb03d158c09aba4b5cced3416a7fb.camel@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201025101555.3057-1-rppt@kernel.org>
 <20201025101555.3057-3-rppt@kernel.org>
 <3b4b2b3559bd3dc68adcddf99415bae57152cb6b.camel@intel.com>
 <20201029075416.GJ1428094@kernel.org>
In-Reply-To: <20201029075416.GJ1428094@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "rppt@kernel.org" <rppt@kernel.org>
Cc: "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "david@redhat.com" <david@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "paulus@samba.org" <paulus@samba.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "hpa@zytor.com" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "cl@linux.com" <cl@linux.com>, "will@kernel.org" <will@kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "mingo@redhat.com" <mingo@redhat.com>, "rientjes@google.com" <rientjes@google.com>, "Brown,
 Len" <len.brown@intel.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "bp@alien8.de" <bp@alien8.de>, "luto@kernel.org" <luto@kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "kirill@shutemov.name" <kirill@shutemov.name>, "tglx@linutronix.de" <tglx@linutronix.de>, "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "penberg@kernel.org" <penberg@kernel.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "davem@davemloft.net" <davem@davemloft.net>

T24gVGh1LCAyMDIwLTEwLTI5IGF0IDA5OjU0ICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBfX2tlcm5lbF9tYXBfcGFnZXMoKSBvbiBhcm02NCB3aWxsIGFsc28gYmFpbCBvdXQgaWYgcm9k
YXRhX2Z1bGwgaXMNCj4gZmFsc2U6DQo+IHZvaWQgX19rZXJuZWxfbWFwX3BhZ2VzKHN0cnVjdCBw
YWdlICpwYWdlLCBpbnQgbnVtcGFnZXMsIGludCBlbmFibGUpDQo+IHsNCj4gICAgICAgICBpZiAo
IWRlYnVnX3BhZ2VhbGxvY19lbmFibGVkKCkgJiYgIXJvZGF0YV9mdWxsKQ0KPiAgICAgICAgICAg
ICAgICAgcmV0dXJuOw0KPiANCj4gICAgICAgICBzZXRfbWVtb3J5X3ZhbGlkKCh1bnNpZ25lZCBs
b25nKXBhZ2VfYWRkcmVzcyhwYWdlKSwgbnVtcGFnZXMsDQo+IGVuYWJsZSk7DQo+IH0NCj4gDQo+
IFNvIHVzaW5nIHNldF9kaXJlY3RfbWFwKCkgdG8gbWFwIGJhY2sgcGFnZXMgcmVtb3ZlZCBmcm9t
IHRoZSBkaXJlY3QNCj4gbWFwDQo+IHdpdGggX19rZXJuZWxfbWFwX3BhZ2VzKCkgc2VlbXMgc2Fm
ZSB0byBtZS4NCg0KSGVoLCBvbmUgb2YgdXMgbXVzdCBoYXZlIHNvbWUgc2ltcGxlIGJvb2xlYW4g
ZXJyb3IgaW4gb3VyIGhlYWQuIEkgaG9wZQ0KaXRzIG5vdCBtZSEgOikgSSdsbCB0cnkgb24gbW9y
ZSB0aW1lLg0KDQpfX2tlcm5lbF9tYXBfcGFnZXMoKSB3aWxsIGJhaWwgb3V0IGlmIHJvZGF0YV9m
dWxsIGlzIGZhbHNlICoqQU5EKioNCmRlYnVnIHBhZ2UgYWxsb2MgaXMgb2ZmLiBTbyBpdCB3aWxs
IG9ubHkgYmFpbCB1bmRlciBjb25kaXRpb25zIHdoZXJlDQp0aGVyZSBjb3VsZCBiZSBub3RoaW5n
IHVubWFwcGVkIG9uIHRoZSBkaXJlY3QgbWFwLg0KDQpFcXVpdmFsZW50IGxvZ2ljIHdvdWxkIGJl
Og0KCWlmICghKGRlYnVnX3BhZ2VhbGxvY19lbmFibGVkKCkgfHwgcm9kYXRhX2Z1bGwpKQ0KCQly
ZXR1cm47DQoNCk9yOg0KCWlmIChkZWJ1Z19wYWdlYWxsb2NfZW5hYmxlZCgpIHx8IHJvZGF0YV9m
dWxsKQ0KCQlzZXRfbWVtb3J5X3ZhbGlkKGJsYWgpDQoNClNvIGlmIGVpdGhlciBpcyBvbiwgdGhl
IGV4aXN0aW5nIGNvZGUgd2lsbCB0cnkgdG8gcmUtbWFwLiBCdXQgdGhlDQpzZXRfZGlyZWN0X21h
cF8oKSdzIHdpbGwgb25seSB3b3JrIGlmIHJvZGF0YV9mdWxsIGlzIG9uLiBTbyBzd2l0Y2hpbmcN
CmhpYmVybmF0ZSB0byBzZXRfZGlyZWN0X21hcCgpIHdpbGwgY2F1c2UgdGhlIHJlbWFwIHRvIGJl
IG1pc3NlZCBmb3IgdGhlDQpkZWJ1ZyBwYWdlIGFsbG9jIGNhc2UsIHdpdGggIXJvZGF0YV9mdWxs
Lg0KDQpJdCBhbHNvIGJyZWFrcyBub3JtYWwgZGVidWcgcGFnZSBhbGxvYyB1c2FnZSB3aXRoICFy
b2RhdGFfZnVsbCBmb3INCnNpbWlsYXIgcmVhc29ucyBhZnRlciBwYXRjaCAzLiBUaGUgcGFnZXMg
d291bGQgbmV2ZXIgZ2V0IHVubWFwcGVkLg0KDQoNCg=
