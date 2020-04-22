From: David Laight <David.Laight@ACULAB.COM>
Date: Wed, 22 Apr 2020 08:35:23 +0000
Subject: RE: [PATCH 1/4] fs: Implement close-on-fork
Message-Id: <39a872f23b16405fb4e4683bf049beef@AcuMS.aculab.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200420071548.62112-1-nate.karstens@garmin.com>
 <20200420071548.62112-2-nate.karstens@garmin.com>
 <36dce9b4-a0bf-0015-f6bc-1006938545b1@gmail.com>
In-Reply-To: <36dce9b4-a0bf-0015-f6bc-1006938545b1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Eric Dumazet' <eric.dumazet@gmail.com>, Nate Karstens <nate.karstens@garmin.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>
Cc: Changli Gao <xiaosuo@gmail.com>

RnJvbTogRXJpYyBEdW1hemV0DQo+IFNlbnQ6IDIwIEFwcmlsIDIwMjAgMTE6MjYNCj4gT24gNC8y
MC8yMCAxMjoxNSBBTSwgTmF0ZSBLYXJzdGVucyB3cm90ZToNCj4gPiBUaGUgY2xvc2Utb24tZm9y
ayBmbGFnIGNhdXNlcyB0aGUgZmlsZSBkZXNjcmlwdG9yIHRvIGJlIGNsb3NlZA0KPiA+IGF0b21p
Y2FsbHkgaW4gdGhlIGNoaWxkIHByb2Nlc3MgYmVmb3JlIHRoZSBjaGlsZCBwcm9jZXNzIHJldHVy
bnMNCj4gPiBmcm9tIGZvcmsoKS4gSW1wbGVtZW50IHRoaXMgZmVhdHVyZSBhbmQgcHJvdmlkZSBh
IG1ldGhvZCB0bw0KPiA+IGdldC9zZXQgdGhlIGNsb3NlLW9uLWZvcmsgZmxhZyB1c2luZyBmY250
bCgyKS4NCj4gPg0KPiA+IFRoaXMgZnVuY3Rpb25hbGl0eSB3YXMgYXBwcm92ZWQgYnkgdGhlIEF1
c3RpbiBDb21tb24gU3RhbmRhcmRzDQo+ID4gUmV2aXNpb24gR3JvdXAgZm9yIGluY2x1c2lvbiBp
biB0aGUgbmV4dCByZXZpc2lvbiBvZiB0aGUgUE9TSVgNCj4gPiBzdGFuZGFyZCAoc2VlIGlzc3Vl
IDEzMTggaW4gdGhlIEF1c3RpbiBHcm91cCBEZWZlY3QgVHJhY2tlcikuDQo+IA0KPiBPaCB3ZWxs
Li4uIHlldCBhbm90aGVyIGZlYXR1cmUgc2xvd2luZyBkb3duIGEgY3JpdGljYWwgcGF0aC4NCi4u
Lg0KPiBJIHN1Z2dlc3Qgd2UgZ3JvdXAgdGhlIHR3byBiaXRzIG9mIGEgZmlsZSAoY2xvc2Vfb25f
ZXhlYywgY2xvc2Vfb25fZm9yaykgdG9nZXRoZXIsDQo+IHNvIHRoYXQgd2UgZG8gbm90IGhhdmUg
dG8gZGlydHkgdHdvIHNlcGFyYXRlIGNhY2hlIGxpbmVzLg0KPiANCj4gT3RoZXJ3aXNlIHdlIHdp
bGwgYWRkIHlldCBhbm90aGVyIGNhY2hlIGxpbmUgbWlzcyBhdCBldmVyeSBmaWxlIG9wZW5pbmcv
Y2xvc2luZyBmb3IgcHJvY2Vzc2VzDQo+IHdpdGggYmlnIGZpbGUgdGFibGVzLg0KDQpIb3cgYWJv
dXQgb25seSBhbGxvY2F0aW5nIHRoZSAnY2xvc2Ugb24gZm9yaycgYml0bWFwIHRoZSBmaXJzdCB0
aW1lDQphIHByb2Nlc3Mgc2V0cyBhIGJpdCBpbiBpdD8NCg0KT2ZmIGhhbmQgSSBjYW4ndCBpbWFn
aW5lIHRoZSB1c2UgY2FzZS4NCkkgdGhvdWdodCBwb3NpeCBhbHdheXMgc2hhcmVkIGZkIHRhYmxl
cyBhY3Jvc3MgZm9yaygpLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K
