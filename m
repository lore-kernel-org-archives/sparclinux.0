From: David Laight <David.Laight@ACULAB.COM>
Date: Wed, 22 Apr 2020 16:55:58 +0000
Subject: RE: [PATCH 1/4] fs: Implement close-on-fork
Message-Id: <337320db094d4426a621858fa0f6d7fd@AcuMS.aculab.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200420071548.62112-1-nate.karstens@garmin.com>
 <20200420071548.62112-2-nate.karstens@garmin.com>
 <fa6c5c9c7c434f878c94a7c984cd43ba@garmin.com>
 <20200422154356.GU5820@bombadil.infradead.org>
 <6ed7bd08892b4311b70636658321904f@garmin.com>
 <97f05204-a27c-7cc8-429a-edcf6eebaa11@petrovitsch.priv.at>
In-Reply-To: <97f05204-a27c-7cc8-429a-edcf6eebaa11@petrovitsch.priv.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Bernd Petrovitsch' <bernd@petrovitsch.priv.at>, "Karstens, Nate" <Nate.Karstens@garmin.com>, Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>"netdev@vger.kernel.org" <ne>

RnJvbTogQmVybmQgUGV0cm92aXRzY2gNCj4gU2VudDogMjIgQXByaWwgMjAyMCAxNzozMg0KLi4u
DQo+IEFwYXJ0IGZyb20gdGhhdCwgc3lzdGVtKCkgaXMgYSBQSVRBIGV2ZW4gb24NCj4gc2luZ2xl
L25vbi10aHJlYWRlZCBhcHBzLg0KDQpOb3Qgb25seSB0aGF0LCBpdCBpcyBibG9vZHkgZGFuZ2Vy
b3VzIGJlY2F1c2UgKHR5cGljYWxseSkNCnNoZWxsIGlzIGRvaW5nIHBvc3Qgc3Vic3RpdHV0aW9u
IHN5bnRheCBhbmFseXNpcy4NCg0KSWYgeW91IG5lZWQgdG8gcnVuIGFuIGV4dGVybmFsIHByb2Nl
c3MgeW91IG5lZWQgdG8gZ2VuZXJhdGUNCmFuIGFydltdIGFycmF5IGNvbnRhaW5pbmcgdGhlIHBh
cmFtZXRlcnMuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo
