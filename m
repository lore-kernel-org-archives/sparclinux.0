From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Date: Mon, 26 Oct 2020 01:13:52 +0000
Subject: Re: [PATCH 0/4] arch, mm: improve robustness of direct map manipulation
Message-Id: <ae82f905a0092adb7e0f0ac206335c1883b3170f.camel@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201025101555.3057-1-rppt@kernel.org>
In-Reply-To: <20201025101555.3057-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "rppt@kernel.org" <rppt@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "david@redhat.com" <david@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "paulus@samba.org" <paulus@samba.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "hpa@zytor.com" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "cl@linux.com" <cl@linux.com>, "will@kernel.org" <will@kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "mingo@redhat.com" <mingo@redhat.com>, "rientjes@google.com" <rientjes@google.com>, "Brown,
 Len" <len.brown@intel.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "bp@alien8.de" <bp@alien8.de>, "luto@kernel.org" <luto@kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "kirill@shutemov.name" <kirill@shutemov.name>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "penberg@kernel.org" <penberg@kernel.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "davem@davemloft.net" <davem@davemloft.net>

T24gU3VuLCAyMDIwLTEwLTI1IGF0IDEyOjE1ICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBJbmRlZWQsIGZvciBhcmNoaXRlY3R1cmVzIHRoYXQgZGVmaW5lIENPTkZJR19BUkNIX0hBU19T
RVRfRElSRUNUX01BUA0KPiBpdCBpcw0KPiBwb3NzaWJsZSB0aGF0IF9fa2VybmVsX21hcF9wYWdl
cygpIHdvdWxkIGZhaWwsIGJ1dCBzaW5jZSB0aGlzDQo+IGZ1bmN0aW9uIGlzDQo+IHZvaWQsIHRo
ZSBmYWlsdXJlIHdpbGwgZ28gdW5ub3RpY2VkLg0KDQpDb3VsZCB5b3UgZWxhYm9yYXRlIG9uIGhv
dyB0aGlzIGNvdWxkIGhhcHBlbj8gRG8geW91IG1lYW4gZHVyaW5nDQpydW50aW1lIHRvZGF5IG9y
IGlmIHNvbWV0aGluZyBuZXcgd2FzIGludHJvZHVjZWQ/DQoNCg=
