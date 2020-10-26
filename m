From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Date: Mon, 26 Oct 2020 00:54:01 +0000
Subject: Re: [PATCH 4/4] arch, mm: make kernel_page_present() always available
Message-Id: <979889bf987fdc7268a973fe7398198bfad1644f.camel@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201025101555.3057-1-rppt@kernel.org>
 <20201025101555.3057-5-rppt@kernel.org>
In-Reply-To: <20201025101555.3057-5-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "rppt@kernel.org" <rppt@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "david@redhat.com" <david@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "paulus@samba.org" <paulus@samba.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "hpa@zytor.com" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "cl@linux.com" <cl@linux.com>, "will@kernel.org" <will@kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "mingo@redhat.com" <mingo@redhat.com>, "rientjes@google.com" <rientjes@google.com>, "Brown,
 Len" <len.brown@intel.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "bp@alien8.de" <bp@alien8.de>, "luto@kernel.org" <luto@kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "kirill@shutemov.name" <kirill@shutemov.name>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "penberg@kernel.org" <penberg@kernel.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "davem@davemloft.net" <davem@davemloft.net>

T24gU3VuLCAyMDIwLTEwLTI1IGF0IDEyOjE1ICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBpbmRleCA3ZjI0OGZjNDUzMTcuLjE2Zjg3OGMyNjY2NyAxMDA2NDQNCj4gLS0tIGEvYXJjaC94
ODYvbW0vcGF0L3NldF9tZW1vcnkuYw0KPiArKysgYi9hcmNoL3g4Ni9tbS9wYXQvc2V0X21lbW9y
eS5jDQo+IEBAIC0yMjI4LDcgKzIyMjgsNiBAQCB2b2lkIF9fa2VybmVsX21hcF9wYWdlcyhzdHJ1
Y3QgcGFnZSAqcGFnZSwgaW50DQo+IG51bXBhZ2VzLCBpbnQgZW5hYmxlKQ0KPiAgfQ0KPiAgI2Vu
ZGlmIC8qIENPTkZJR19ERUJVR19QQUdFQUxMT0MgKi8NCj4gIA0KPiAtI2lmZGVmIENPTkZJR19I
SUJFUk5BVElPTg0KPiAgYm9vbCBrZXJuZWxfcGFnZV9wcmVzZW50KHN0cnVjdCBwYWdlICpwYWdl
KQ0KPiAgew0KPiAgICAgICAgIHVuc2lnbmVkIGludCBsZXZlbDsNCj4gQEAgLTIyNDAsNyArMjIz
OSw2IEBAIGJvb2wga2VybmVsX3BhZ2VfcHJlc2VudChzdHJ1Y3QgcGFnZSAqcGFnZSkNCj4gICAg
ICAgICBwdGUgPSBsb29rdXBfYWRkcmVzcygodW5zaWduZWQgbG9uZylwYWdlX2FkZHJlc3MocGFn
ZSksDQo+ICZsZXZlbCk7DQo+ICAgICAgICAgcmV0dXJuIChwdGVfdmFsKCpwdGUpICYgX1BBR0Vf
UFJFU0VOVCk7DQo+ICB9DQo+IC0jZW5kaWYgLyogQ09ORklHX0hJQkVSTkFUSU9OICovDQoNClRo
aXMgaXMgb25seSB1c2VkIGJ5IGhpYmVybmF0ZSB0b2RheSByaWdodD8gTWFrZXMgc2Vuc2UgdGhh
dCBpdCBzaG91bGQNCnJldHVybiBhIGNvcnJlY3QgYW5zd2VyIGlmIHNvbWVvbmUgc3RhcnRzIHRv
IHVzZSBpdCB3aXRob3V0IGxvb2tpbmcgdG9vDQpjbG9zZWx5IGF0IHRoZSBoZWFkZXIuIEJ1dCBj
b3VsZCB3ZSBqdXN0IHJlbW92ZSB0aGUgZGVmYXVsdCBzdGF0aWMNCmlubGluZSByZXR1cm4gdHJ1
ZSBpbXBsZW1lbnRhdGlvbiBhbmQgbGV0IHRoZSBsaW5rZXIgZmFpbCBpZiBzb21lb25lDQpzdGFy
dHMgdG8gdXNlIGl0IG91dHNpZGUgaGliZXJuYXRlPyBUaGVuIHdlIGNvdWxkIGxlYXZlIGl0IGNv
bXBpbGVkIG91dA0KdW50aWwgdGhlbi4NCg0KQWxzbyBpdCBsb29rcyBsaWtlIHJpc2N2IGRvZXMg
bm90IGhhdmUgQVJDSF9ISUJFUk5BVElPTl9QT1NTSUJMRSBzbyB0aGUNCm5ldyBmdW5jdGlvbiBh
ZGRlZCBoZXJlIGNvdWxkbid0IGJlIHVzZWQgeWV0LiBZb3UgY291bGQgYWxzbyBqdXN0IGxldA0K
dGhlIGxpbmtlciBjYXRjaCBpdCBpZiByaXNjdiBldmVyIGVuYWJsZXMgaGliZXJuYXRlPw0K
