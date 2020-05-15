From: David Laight <David.Laight@ACULAB.COM>
Date: Fri, 15 May 2020 15:59:58 +0000
Subject: RE: [PATCH v2] Implement close-on-fork
Message-Id: <480b831115724107ab5a0cab9d7caafc@AcuMS.aculab.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200515152321.9280-1-nate.karstens@garmin.com>
 <CANn89iKr_9MyRpdB4pcHm08ccH_M42etDnrOzpVKUYfhSKvxQw@mail.gmail.com>
In-Reply-To: <CANn89iKr_9MyRpdB4pcHm08ccH_M42etDnrOzpVKUYfhSKvxQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Eric Dumazet' <edumazet@google.com>, Nate Karstens <nate.karstens@garmin.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger>

RnJvbTogRXJpYyBEdW1hemV0DQo+IFNlbnQ6IDE1IE1heSAyMDIwIDE2OjMxDQouLi4NCj4gRmFz
dCBwYXRoIGluIGJpZyBhbmQgcGVyZm9ybWFuY2Ugc2Vuc2l0aXZlIGFwcGxpY2F0aW9ucyBpcyBu
b3QgZm9yaygpDQo+IGFuZC9vciBleGVjKCkuDQo+IA0KPiBUaGlzIGlzIG9wZW4oKS9jbG9zZSgp
IGFuZCBvdGhlcnMgKHNvY2tldCgpLCBhY2NlcHQoKSwgLi4uKQ0KPiANCj4gV2UgZG8gbm90IHdh
bnQgdGhlbSB0byBhY2Nlc3MgZXh0cmEgY2FjaGUgbGluZXMgZm9yIHRoaXMgbmV3IGZlYXR1cmUu
DQo+IA0KPiBTb3JyeSwgSSB3aWxsIHNheSBubyB0byB0aGVzZSBwYXRjaGVzIGluIHRoZWlyIGN1
cnJlbnQgZm9ybS4NCg0KSXMgaXQgd29ydGggY29tcGxldGVseSByZW1vdmluZyB0aGUgYml0bWFw
cyBhbmQganVzdCByZW1lbWJlcmluZw0KdGhlIGxvd2VzdCBmZCB0aGF0IGhhcyBoYWQgZWFjaCBi
aXQgc2V0IChkb24ndCB3b3JyeSBhYm91dCBjbGVhcnMpLg0KDQpUaGVuIGxldmVyYWdlIHRoZSBj
bG9zZV9hbGwoKSBjb2RlIHRoYXQgY2xvc2VzIGFsbCBmZCBhYm92ZQ0KYSBzcGVjaWZpZWQgbnVt
YmVyIHRvIGNsb3NlIG9ubHkgdGhvc2Ugd2l0aCB0aGUgJ2Nsb3NlIG9uIGV4ZWMnDQpvciAnY2xv
c2Ugb24gZm9yaycgZmxhZyBzZXQuDQoNCkFmdGVyIGFsbCBhbiBhcHBsaWNhdGlvbiBpcyBjdXJy
ZW50bHkgdmVyeSBsaWtlbHkgdG8gaGF2ZSBzZXQNCidjbG9zZSBvbiBleGVjJyBvbiBhbGwgb3Bl
biBmZCBhYm92ZSAyLg0KDQpTbyB0aGUgbnVtYmVyIG9mIGZkIHRoYXQgZG9uJ3QgbmVlZCBjbG9z
aW5nIGlzIHNtYWxsLg0KDQpUaGlzIHB1dHMgYWxsIHRoZSBleHBlbnNpdmUgY29kZSBpbiB0aGUg
YWxyZWFkeSBzbG93IGZvcmsvZXhlYw0KcGF0aHMuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVk
IEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5l
cywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo
