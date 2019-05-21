From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Date: Tue, 21 May 2019 01:20:33 +0000
Subject: Re: [PATCH v2] vmalloc: Fix issues with flush flag
Message-Id: <a43f9224e6b245ade4b587a018c8a21815091f0f.camel@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <c6020a01e81d08342e1a2b3ae7e03d55858480ba.camel@intel.com>
	 <20190520.154855.2207738976381931092.davem@davemloft.net>
	 <3e7e674c1fe094cd8dbe0c8933db18be1a37d76d.camel@intel.com>
	 <20190520.203320.621504228022195532.davem@davemloft.net>
In-Reply-To: <20190520.203320.621504228022195532.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "davem@davemloft.net" <davem@davemloft.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mroos@linux.ee" <mroos@linux.ee>, "mingo@redhat.com" <mingo@redhat.com>, "namit@vmware.com" <namit@vmware.com>, "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Hansen, Dave" <dave.hansen@intel.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>

T24gTW9uLCAyMDE5LTA1LTIwIGF0IDIwOjMzIC0wNDAwLCBEYXZpZCBNaWxsZXIgd3JvdGU6DQo+
IEZyb206ICJFZGdlY29tYmUsIFJpY2sgUCIgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0K
PiBEYXRlOiBUdWUsIDIxIE1heSAyMDE5IDAwOjIwOjEzICswMDAwDQo+IA0KPiA+IFRoaXMgYmVo
YXZpb3Igc2hvdWxkbid0IGhhcHBlbiB1bnRpbCBtb2R1bGVzIG9yIEJQRiBhcmUgYmVpbmcNCj4g
PiBmcmVlZC4NCj4gDQo+IFRoZW4gdGhhdCB3b3VsZCBydWxlIG91dCBteSB0aGVvcnkuDQo+IA0K
PiBUaGUgb25seSB0aGluZyBsZWZ0IGlzIHdoZXRoZXIgdGhlIHBlcm1pc3Npb25zIGFyZSBhY3R1
YWxseSBzZXQNCj4gcHJvcGVybHkuICBJZiB0aGV5IGFyZW4ndCB3ZSdsbCB0YWtlIGFuIGV4Y2Vw
dGlvbiB3aGVuIHRoZSBCUEYNCj4gcHJvZ3JhbQ0KPiBpcyBydW4gYW5kIEknbSBub3QgJTEwMCBz
dXJlIHRoYXQga2VybmVsIGV4ZWN1dGUgcGVybWlzc2lvbg0KPiB2aW9sYXRpb25zDQo+IGFyZSB0
b3RhbGx5IGhhbmRsZWQgY2xlYW5seS4NClBlcm1pc3Npb25zIHNob3VsZG4ndCBiZSBhZmZlY3Rl
ZCB3aXRoIHRoaXMgZXhjZXB0IG9uIGZyZWUuIEJ1dCByZWFkaW5nDQp0aGUgY29kZSBpdCBsb29r
ZWQgbGlrZSBzcGFyYyBoYWQgYWxsIFBBR0VfS0VSTkVMIGFzIGV4ZWN1dGFibGUgYW5kIG5vDQpz
ZXRfbWVtb3J5XygpIGltcGxlbWVudGF0aW9ucy4gSXMgdGhlcmUgc29tZSBwbGFjZXMgd2hlcmUg
cGVybWlzc2lvbnMNCmFyZSBiZWluZyBzZXQ/DQoNClNob3VsZCBpdCBoYW5kbGUgZXhlY3V0aW5n
IGFuIHVubWFwcGVkIHBhZ2UgZ3JhY2VmdWxseT8gQmVjYXVzZSB0aGlzDQpjaGFuZ2UgaXMgY2F1
c2luZyB0aGF0IHRvIGhhcHBlbiBtdWNoIGVhcmxpZXIuIElmIHNvbWV0aGluZyB3YXMgcmVseWlu
Zw0Kb24gYSBjYWNoZWQgdHJhbnNsYXRpb24gdG8gZXhlY3V0ZSBzb21ldGhpbmcgaXQgY291bGQg
ZmluZCB0aGUgbWFwcGluZw0KZGlzYXBwZWFyLg0KDQoNCg0KDQoNCg0KDQoNCg0K
