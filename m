From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Date: Wed, 28 Oct 2020 21:15:38 +0000
Subject: Re: [PATCH 2/4] PM: hibernate: improve robustness of mapping pages in the direct map
Message-Id: <3b4b2b3559bd3dc68adcddf99415bae57152cb6b.camel@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201025101555.3057-1-rppt@kernel.org>
 <20201025101555.3057-3-rppt@kernel.org>
In-Reply-To: <20201025101555.3057-3-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "rppt@kernel.org" <rppt@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "david@redhat.com" <david@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "paulus@samba.org" <paulus@samba.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "hpa@zytor.com" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "cl@linux.com" <cl@linux.com>, "will@kernel.org" <will@kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "mingo@redhat.com" <mingo@redhat.com>, "rientjes@google.com" <rientjes@google.com>, "Brown,
 Len" <len.brown@intel.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "bp@alien8.de" <bp@alien8.de>, "luto@kernel.org" <luto@kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "kirill@shutemov.name" <kirill@shutemov.name>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "penberg@kernel.org" <penberg@kernel.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "davem@davemloft.net" <davem@davemloft.net>

T24gU3VuLCAyMDIwLTEwLTI1IGF0IDEyOjE1ICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiArICAgICAgIGlmIChJU19FTkFCTEVEKENPTkZJR19BUkNIX0hBU19TRVRfRElSRUNUX01BUCkp
IHsNCj4gKyAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgYWRkciA9ICh1bnNpZ25lZA0KPiBs
b25nKXBhZ2VfYWRkcmVzcyhwYWdlKTsNCj4gKyAgICAgICAgICAgICAgIGludCByZXQ7DQo+ICsN
Cj4gKyAgICAgICAgICAgICAgIGlmIChlbmFibGUpDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IHJldCA9IHNldF9kaXJlY3RfbWFwX2RlZmF1bHRfbm9mbHVzaChwYWdlKTsNCj4gKyAgICAgICAg
ICAgICAgIGVsc2UNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gc2V0X2RpcmVjdF9t
YXBfaW52YWxpZF9ub2ZsdXNoKHBhZ2UpOw0KPiArDQo+ICsgICAgICAgICAgICAgICBpZiAoV0FS
Tl9PTihyZXQpKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm47DQo+ICsNCj4gKyAg
ICAgICAgICAgICAgIGZsdXNoX3RsYl9rZXJuZWxfcmFuZ2UoYWRkciwgYWRkciArIFBBR0VfU0la
RSk7DQo+ICsgICAgICAgfSBlbHNlIHsNCj4gKyAgICAgICAgICAgICAgIGRlYnVnX3BhZ2VhbGxv
Y19tYXBfcGFnZXMocGFnZSwgMSwgZW5hYmxlKTsNCj4gKyAgICAgICB9DQoNCkxvb2tpbmcgYXQg
dGhlIGFybSBzaWRlIGFnYWluLCBJIHRoaW5rIHRoaXMgbWlnaHQgYWN0dWFsbHkgaW50cm9kdWNl
IGENCnJlZ3Jlc3Npb24gZm9yIHRoZSBhcm0vaGliZXJuYXRlL0RFQlVHX1BBR0VBTExPQyBjb21i
by4NCg0KVW5saWtlIF9fa2VybmVsX21hcF9wYWdlcygpLCBpdCBsb29rcyBsaWtlIGFybSdzIGNw
YSB3aWxsIGFsd2F5cyBiYWlsDQppbiB0aGUgc2V0X2RpcmVjdF9tYXBfKCkgZnVuY3Rpb25zIGlm
IHJvZGF0YV9mdWxsIGlzIGZhbHNlLiBTbyBpZg0Kcm9kYXRhX2Z1bGwgd2FzIGRpc2FibGVkIGJ1
dCBkZWJ1ZyBwYWdlIGFsbG9jIGlzIG9uLCB0aGVuIHRoaXMgd291bGQNCm5vdyBza2lwIHJlbWFw
cGluZyB0aGUgcGFnZXMuIEkgZ3Vlc3MgdGhlIHNpZ25pZmljYW5jZSBkZXBlbmRzIG9uDQp3aGV0
aGVyIGhpYmVybmF0ZSBjb3VsZCBhY3R1YWxseSB0cnkgdG8gc2F2ZSBhbnkgREVCVUdfUEFHRUFM
TE9DDQp1bm1hcHBlZCBwYWdlcy4gTG9va3MgbGlrZSBpdCB0byBtZSB0aG91Z2guDQoNCg=
