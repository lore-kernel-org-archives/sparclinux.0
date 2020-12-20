From: David Laight <David.Laight@ACULAB.COM>
Date: Sun, 20 Dec 2020 14:22:57 +0000
Subject: RE: [RFC PATCH 0/13] sparc32: sunset sun4m and sun4d
Message-Id: <1afa7f144a154d1597212f026a329cc8@AcuMS.aculab.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201218184347.2180772-1-sam@ravnborg.org>
 <20201219214054.GB3132151@ravnborg.org>
 <CADuzgbqBx7cajLg5-9+bqoUvHV4heoNjBH-cakU5YGV549Gdxg@mail.gmail.com>
 <CAGRGNgUxGY3wz5sDVJqO8hB=yw=-symr0tGXQeQ1ovqwb6-e9w@mail.gmail.com>
In-Reply-To: <CAGRGNgUxGY3wz5sDVJqO8hB=yw=-symr0tGXQeQ1ovqwb6-e9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Julian Calaby' <julian.calaby@gmail.com>, Romain Dolbeau <romain@dolbeau.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, David S Miller <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Arvind Sankar <nivedita@alum.mit.edu>, Christian Brauner <christian.brauner@ubuntu.com>, Denis Efremov <efremov@linux.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ira Weiny <ira.weiny@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@kernel.org>, Pekka Enberg <penberg@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>, LKML <linux-kernel@vger.kernel.org>, debian-sparc <debian-sparc@lists.debian.org>, "gentoo-sparc@lists.gentoo.org" <gentoo-sparc@lists.gentoo.org>, "info@temlib.org" <info@temlib.org>

RnJvbTogSnVsaWFuIENhbGFieQ0KPiBTZW50OiAyMCBEZWNlbWJlciAyMDIwIDA4OjU1DQo+IA0K
PiBPbiBTdW4sIERlYyAyMCwgMjAyMCBhdCA2OjQ2IFBNIFJvbWFpbiBEb2xiZWF1IDxyb21haW5A
ZG9sYmVhdS5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gTGUgc2FtLiAxOSBkw6ljLiAyMDIwIMOgIDIy
OjQxLCBTYW0gUmF2bmJvcmcgPHNhbUByYXZuYm9yZy5vcmc+IGEgw6ljcml0IDoNCj4gPiA+IEFu
b3RoZXIgc2FpZCB0aGF0IGl0IHdvdWxkIGJlIGEgc2hhbWUgdG8gc3Vuc2V0IHN1bjRtIGFuZCBz
dW40ZCBiZWNhdXNlDQo+ID4gPiB0aGVyZSBhcmUgc28gbWFueSBtYWNoaW5lcyBhcm91bmQsIGFu
ZCBuZXRic2QgaXMgYWxzbyBhY3RpdmUgb24gdGhlDQo+ID4gPiBzcGFyYzMyIGFyZWEuDQoNClRo
ZSBhZHZhbnRhZ2Ugb2YgbmV0YnNkIGlzIHRoYXQgdGhlIGJ1aWxkIGdpdmVzIHlvdSBhIGtlcm5l
bCBhbmQgdXNlcnNwYWNlDQpmcm9tIHRoZSBzYW1lIHNvdXJjZSB0cmVlIGFuZCBpdCBpcyBkZXNp
Z25lZCB0byBjcm9zcyBidWlsZC4NCkV2ZW4gdGhlIGNvbXBpbGVycyBnZXQgYnVpbHQgLSBzbyBh
bGwgeW91IG5lZWQgaXMgYSBuYXRpdmUgY29tcGlsZXINCnRoYXQgd2lsbCBjb21waWxlIHRoZSAo
cHJvYmFibHkgc2xpZ2h0bHkgb2xkZXIpIHZlcnNpb24gb2YgZ2NjLg0KVGhpcyB1c2VkIHRvIGJl
IHByb2JsZW1hdGljIGJlY2F1c2UgZ2NjIHNvdXJjZXMgdGVuZGVkIHRvIHVzZSBnY2Mtb25seQ0K
ZmVhdHVyZXMgKHdoaWNoIGhhdmUgYmVlbiBkZXByZWNhdGVkKS4NCg0KVGhlIHVzZXJzcGFjZSB3
aWxsIGFsc28gYmUgYSBsb3QgbGVzcyBibG9hdGVkIHRoYW4gYSB0eXBpY2FsIExpbnV4LA0KYnV0
IG1vcmUgY29tcGxldGUgdGhhbiB0aGUgJ2J1c3lib3gnIHRvb2xzIG9mdGVuIHVzZWQgb24gc21h
bGwvZW1iZWRkZWQNCkxpbnV4IHN5c3RlbXMuDQoNCj4gPiBZZXMsIHRob3NlIHdlcmUgcGxlbnRp
ZnVsIGJhY2sgaW4gdGhlIGRheSBhbmQgdGhlcmUncyBzdGlsbCBxdWl0ZSBhIGZldyBhcm91bmQu
DQo+IA0KPiBJIGhhdmUgdGhyZWU6IHR3byBTcGFyY1N0YXRpb24gMTBzIGFuZCBhIFNwYXJjU3Rh
dGlvbiBMWC4NCj4gDQo+IElmIEkgd2FudCB0byBydW4gdGhlbSwgYXNzdW1pbmcgdGhlIGhhcmR3
YXJlIHN0aWxsIHdvcmtzLCBJIG5lZWQgdG8NCj4gbmV0Ym9vdCB0aGVtIGFzIEkgY2Fubm90IGZp
bmQgd29ya2luZywgY29tcGF0aWJsZSBIRERzIGZvciB0aGVtIGFzDQo+IGV2ZXJ5dGhpbmcgaGFz
IHN3aXRjaGVkIHRvIFNBVEEgb3IgU0FTLg0KDQpJIHRyYXNoZWQgdGhlIFBTVSBvbiBteSBzdW4z
IHRyeWluZyB0byBnZXQgbmV0Ym9vdCB0byB3b3JrLg0KVGhlIG1haW4gcHJvYmxlbSBzZWVtZWQg
dG8gYmUgdGhhdCB0aGUgc3dpdGNoaW5nIGZldCB3YXNuJ3QNCmFjdHVhbGx5IHJhdGVkIGZvciAy
NDB2IGlucHV0ISAobmVlZHMgdG8gYmUgYSA0MDB2IGRldmljZSkuDQoNCkkgbmV2ZXIgZGlkIGdl
dCBhcm91bmQgdG8gY29ubmVjdGluZyBhbiBBVFggcHN1IHVwIHRvIHRoZSBjb25uZWN0b3IuDQoN
CglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwg
TW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzog
MTM5NzM4NiAoV2FsZXMpDQo
