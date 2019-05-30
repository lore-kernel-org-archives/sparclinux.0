From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Date: Thu, 30 May 2019 03:55:11 +0000
Subject: Re: [PATCH] vmalloc: Don't use flush flag when no exec perm
Message-Id: <89d6dee949e4418f0cca4cc6c4c9b526c1a5c497.camel@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190529055104.6822-1-rick.p.edgecombe@intel.com>
In-Reply-To: <20190529055104.6822-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "davem@davemloft.net" <davem@davemloft.net>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "daniel@iogearbox.net" <daniel@iogearbox.net>, "jeyu@kernel.org" <jeyu@kernel.org>, "ast@kernel.org" <ast@kernel.org>, "ard.biesheuvel@arm.com" <ard.biesheuvel@arm.com>, "mroos@linux.ee" <mroos@linux.ee>, "will.deacon@arm.com" <will.deacon@arm.com>, "namit@vmware.com" <namit@vmware.com>, "luto@kernel.org" <luto@kernel.org>, "Hansen, Dave" <dave.hansen@intel.com>

T24gVHVlLCAyMDE5LTA1LTI4IGF0IDIyOjUxIC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gVGhlIGFkZGl0aW9uIG9mIFZNX0ZMVVNIX1JFU0VUX1BFUk1TIGZvciBCUEYgSklUIGFsbG9j
YXRpb25zIHdhcw0KPiBiaXNlY3RlZCB0byBwcmV2ZW50IGJvb3Qgb24gYW4gVWx0cmFTcGFyYyBJ
SUkgbWFjaGluZS4gSXQgd2FzIGZvdW5kDQo+IHRoYXQNCj4gc29tZXRpbWUgc2hvcnRseSBhZnRl
ciB0aGUgVExCIGZsdXNoIHRoaXMgZmxhZyBkb2VzIG9uIHZmcmVlIG9mIHRoZQ0KPiBCUEYNCj4g
cHJvZ3JhbSwgdGhlIG1hY2hpbmUgaHVuZy4gRnVydGhlciBpbnZlc3RpZ2F0aW9uIHNob3dlZCB0
aGF0IGJlZm9yZQ0KPiBhbnkgb2YNCj4gdGhlIGNoYW5nZXMgZm9yIHRoaXMgZmxhZyB3ZXJlIGlu
dHJvZHVjZWQsIHdpdGgNCj4gQ09ORklHX0RFQlVHX1BBR0VBTExPQw0KPiBjb25maWd1cmVkICh3
aGljaCBkb2VzIGEgc2ltaWxhciBUTEIgZmx1c2ggb2YgdGhlIHZtYWxsb2MgcmFuZ2Ugb24NCj4g
ZXZlcnkgdmZyZWUpLCB0aGlzIG1hY2hpbmUgYWxzbyBodW5nIHNob3J0bHkgYWZ0ZXIgdGhlIGZp
cnN0IHZtYWxsb2MNCj4gdW5tYXAvZnJlZS4NCj4gDQo+IFNvIHRoZSBldmlkZW5jZSBwb2ludHMg
dG8gdGhlcmUgYmVpbmcgc29tZSBleGlzdGluZyBpc3N1ZSB3aXRoIHRoZQ0KPiB2bWFsbG9jIFRM
QiBmbHVzaGVzLCBidXQgaXQncyBzdGlsbCB1bmtub3duIGV4YWN0bHkgd2h5IHRoZXNlIGhhbmdz
DQo+IGFyZQ0KPiBoYXBwZW5pbmcgb24gc3BhcmMuIEl0IGlzIGFsc28gdW5rbm93biB3aGVuIHNv
bWVvbmUgd2l0aCB0aGlzDQo+IGhhcmR3YXJlDQo+IGNvdWxkIHJlc29sdmUgdGhpcywgYW5kIGlu
IHRoZSBtZWFudGltZSB1c2luZyB0aGlzIGZsYWcgb24gaXQgdHVybnMgYQ0KPiBsdXJraW5nIGJl
aGF2aW9yIGludG8gc29tZXRoaW5nIHRoYXQgcHJldmVudHMgYm9vdC4NCg0KVGhlIHNwYXJjIFRM
QiBmbHVzaCBpc3N1ZSBoYXMgYmVlbiBiaXNlY3RlZCBhbmQgaXMgYmVpbmcgd29ya2VkIG9uIG5v
dywNCnNvIGhvcGVmdWxseSB3ZSB3b24ndCBuZWVkIHRoaXMgcGF0Y2g6DQpodHRwczovL21hcmMu
aW5mby8/bD1saW51eC1zcGFyYyZtPTE1NTkxNTY5NDMwNDExOCZ3PTINCg=
