From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Date: Thu, 29 Oct 2020 23:19:45 +0000
Subject: Re: [PATCH 0/4] arch, mm: improve robustness of direct map manipulation
Message-Id: <b519c0cec8ad8e67d7a43251e45e49d17d5cfbef.camel@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201025101555.3057-1-rppt@kernel.org>
 <ae82f905a0092adb7e0f0ac206335c1883b3170f.camel@intel.com>
 <20201026090526.GA1154158@kernel.org>
 <a0212b073b3b2f62c3dbf1bf398f03fa402997be.camel@intel.com>
 <20201027083816.GG1154158@kernel.org>
 <20201028112011.GB27927@willie-the-truck>
 <20201028113059.GG1428094@kernel.org>
 <9e77d0a939eda3029d6ae89bd14d7f1465b0559d.camel@intel.com>
 <20201029081225.GK1428094@kernel.org>
In-Reply-To: <20201029081225.GK1428094@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "will@kernel.org" <will@kernel.org>, "rppt@kernel.org" <rppt@kernel.org>
Cc: "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "david@redhat.com" <david@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "paulus@samba.org" <paulus@samba.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "hpa@zytor.com" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "cl@linux.com" <cl@linux.com>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "mingo@redhat.com" <mingo@redhat.com>, "rientjes@google.com" <rientjes@google.com>, "Brown,
 Len" <len.brown@intel.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "bp@alien8.de" <bp@alien8.de>, "luto@kernel.org" <luto@kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "kirill@shutemov.name" <kirill@shutemov.name>, "tglx@linutronix.de" <tglx@linutronix.de>, "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "penberg@kernel.org" <penberg@kernel.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "davem@davemloft.net" <davem@davemloft.net>

T24gVGh1LCAyMDIwLTEwLTI5IGF0IDEwOjEyICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBUaGlzIHNlcmllcyBnb2FsIHdhcyBwcmltYXJpbHkgdG8gc2VwYXJhdGUgZGVwZW5kaW5jaWVz
IGFuZCBtYWtlIGl0DQo+IGNsZWFyZXIgd2hhdCBERUJVR19QQUdFQUxMT0MgYW5kIHdoYXQgU0VU
X0RJUkVDVF9NQVAgYXJlLiBBcyBpdA0KPiB0dXJuZWQNCj4gb3V0LCB0aGVyZSBpcyBhbHNvIHNv
bWUgbGFjayBvZiBjb25zaXN0ZW5jeSBiZXR3ZWVuIGFyY2hpdGVjdHVyZXMNCj4gdGhhdA0KPiBp
bXBsZW1lbnQgZWl0aGVyIG9mIHRoaXMgc28gSSB0cmllZCB0byBpbXByb3ZlIHRoaXMgYXMgd2Vs
bC4NCj4gDQo+IEhvbmVzdGx5LCBJIGRvbid0IGtub3cgaWYgYSB0aHJlYWQgY2FuIGJlIHBhdXNl
ZCBhdCB0aGUgdGltZQ0KPiBfX3Z1bm1hcCgpDQo+IGxlZnQgaW52YWxpZCBwYWdlcywgYnV0IGl0
IGNvdWxkLCB0aGVyZSBpcyBhbiBpc3N1ZSBvbiBhcm02NCB3aXRoDQo+IERFQlVHX1BBR0VBTExP
Qz1uIGFuZCB0aGlzIHNldCBmaXhlcyBpdC4NCg0KQWgsIG9rLiBTbyBmcm9tIHRoaXMgYW5kIHRo
ZSBvdGhlciB0aHJlYWQsIHRoaXMgaXMgYWJvdXQgdGhlIGxvZ2ljIGluDQphcm0ncyBjcGEgZm9y
IHdoZW4gaXQgd2lsbCB0cnkgdGhlIHVuL21hcCBvcGVyYXRpb25zLiBJIHRoaW5rIHRoZSBsb2dp
Yw0KYWN0dWFsbHkgd29ya3MgY3VycmVudGx5LiBBbmQgdGhpcyBzZXJpZXMgaW50cm9kdWNlcyBh
IHByb2JsZW0gb24gQVJNDQpzaW1pbGFyIHRvIHRoZSBvbmUgeW91IGFyZSBzYXlpbmcgcHJlZXhp
c3RzLiBJIHB1dCB0aGUgZGV0YWlscyBpbiB0aGUNCm90aGVyIHRocmVhZC4NCg0K
