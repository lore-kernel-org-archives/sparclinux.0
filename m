From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Date: Tue, 27 Oct 2020 01:10:11 +0000
Subject: Re: [PATCH 2/4] PM: hibernate: improve robustness of mapping pages in the direct map
Message-Id: <3568e23fb551ae4b8d583c3e6bfdbed505e460e9.camel@intel.com>
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
PiBUaGUgaW50ZW50aW9uIG9mIHRoaXMgc2VyaWVzIGlzIHRvIGRpc2FsbG93IHVzYWdlIG9mDQo+
IF9fa2VybmVsX21hcF9wYWdlcygpIHdoZW4gREVCVUdfUEFHRUFMTE9DPW4uIEknbGwgdXBkYXRl
IHRoaXMgcGF0Y2gNCj4gdG8NCj4gYmV0dGVyIGhhbmRsZSBwb3NzaWJsZSBlcnJvcnMsIGJ1dCBJ
IHN0aWxsIHdhbnQgdG8ga2VlcCBXQVJOIGluIHRoZQ0KPiBjYWxsZXIuDQoNClNvcnJ5LCBJIG1p
c3NlZCB0aGlzIHNuaXBwZXQgYXQgdGhlIGJvdHRvbSwgdGhhdCB5b3VyIGludGVudGlvbiB3YXMg
dG8NCmFjdHVhbGx5IGhhbmRsZSBlcnJvcnMgc29tZWhvdyBpbiB0aGUgaGliZXJuYXRlIGNvZGUu
IFBsZWFzZSBpZ25vcmUgbXkNCm90aGVyIGNvbW1lbnQgdGhhdCBhc3N1bWVkIHlvdSB3YW50ZWQg
dG8ganVzdCBhZGQgYSB3YXJuLg0K
