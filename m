From: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 16 Jul 2020 08:07:37 +0000
Subject: RE: [RFC PATCH 00/35] Move all PCIBIOS* definitions into arch/x86
Message-Id: <5a7574c0efc1475a89f84c6393e598d6@AcuMS.aculab.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200715221230.GA563957@bjorn-Precision-5520>
 <5d4b3a716f85017c17c52a85915fba9e19509e81.camel@kernel.crashing.org>
In-Reply-To: <5d4b3a716f85017c17c52a85915fba9e19509e81.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, sparclinux <sparclinux@vger.kernel.org>, Toan Le <toan@os.amperecomputing.com>, Christoph Hellwig <hch@lst.de>, Marek Vasut <marek.vasut+renesas@gmail.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sagi Grimberg <sagi@grimberg.me>, Kevin Hilman <khilman@baylibre.com>, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>, Greg Ungerer <gerg@linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Jakub Kicinski <kuba@kernel.org>, Matt Turner <mattst88@gmail.com>, "linux-kernel-mentees@lists.linuxfoundation.org" <linux-kernel-mentees@lists.linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Ray Jui <rjui@broadcom.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Jens Axboe <axboe@fb.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Keith Busch <kbusch@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>, Juergen Gross <jgross@suse.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Scott Branden <sbranden@broadcom.com>, Jingoo Han <jingoohan1@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, "Saheed O.
 Bolarinwa" <refactormyself@gmail.com>, 'Oliver O'Halloran' <oohall@gmail.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, "David S. Miller" <davem@davemloft.net>, Heiner Kallweit <hkallweit1@gmail.com>

RnJvbTogQmVuamFtaW4gSGVycmVuc2NobWlkdA0KPiBTZW50OiAxNSBKdWx5IDIwMjAgMjM6NDkN
Cj4gT24gV2VkLCAyMDIwLTA3LTE1IGF0IDE3OjEyIC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3Rl
Og0KPiA+ID4gSSd2ZSAncGxheWVkJyB3aXRoIFBDSWUgZXJyb3IgaGFuZGxpbmcgLSB3aXRob3V0
IG11Y2ggc3VjY2Vzcy4NCj4gPiA+IFdoYXQgbWlnaHQgYmUgdXNlZnVsIGlzIGZvciBhIGRyaXZl
ciB0aGF0IGhhcyBqdXN0IHJlYWQgfjB1IHRvDQo+ID4gPiBiZSBhYmxlIHRvIGFzayAnaGFzIHRo
ZXJlIGJlZW4gYW4gZXJyb3Igc2lnbmFsbGVkIGZvciB0aGlzIGRldmljZT8nLg0KPiA+DQo+ID4g
SW4gbWFueSBjYXNlcyBhIGRyaXZlciB3aWxsIGtub3cgdGhhdCB+MCBpcyBub3QgYSB2YWxpZCB2
YWx1ZSBmb3IgdGhlDQo+ID4gcmVnaXN0ZXIgaXQncyByZWFkaW5nLiAgQnV0IGlmIH4wICpjb3Vs
ZCogYmUgdmFsaWQsIGFuIGludGVyZmFjZSBsaWtlDQo+ID4geW91IHN1Z2dlc3QgY291bGQgYmUg
dXNlZnVsLiAgSSBkb24ndCB0aGluayB3ZSBoYXZlIGFueXRoaW5nIGxpa2UgdGhhdA0KPiA+IHRv
ZGF5LCBidXQgbWF5YmUgd2UgY291bGQuICBJdCB3b3VsZCBjZXJ0YWlubHkgYmUgbmljZSBpZiB0
aGUgUENJIGNvcmUNCj4gPiBub3RpY2VkLCBsb2dnZWQsIGFuZCBjbGVhcmVkIGVycm9ycy4gIFdl
IGhhdmUgc29tZSBvZiB0aGF0IGZvciBBRVIsDQo+ID4gYnV0IHRoYXQncyBhbiBvcHRpb25hbCBm
ZWF0dXJlLCBhbmQgc3VwcG9ydCBmb3IgdGhlIGVycm9yIGJpdHMgaW4gdGhlDQo+ID4gZ2FyZGVu
LXZhcmlldHkgUENJX1NUQVRVUyByZWdpc3RlciBpcyBwcmV0dHkgaGFwaGF6YXJkLiAgQXMgeW91
IG5vdGUNCj4gPiBiZWxvdywgdGhpcyBzb3J0IG9mIFNFUlIvUEVSUiByZXBvcnRpbmcgaXMgZnJl
cXVlbnRseSBoYXJkLXdpcmVkIGluDQo+ID4gd2F5cyB0aGF0IHRha2VzIGl0IG91dCBvZiBvdXIg
cHVydmlldy4NCj4gDQo+IFdlIGRvIGhhdmUgcGNpX2NoYW5uZWxfc3RhdGUgKHZpYSBwY2lfY2hh
bm5lbF9vZmZsaW5lKCkpIHdoaWNoIGNvdmVycw0KPiB0aGUgY2FzZXMgd2hlcmUgdGhlIHVuZGVy
bHlpbmcgZXJyb3IgaGFuZGxpbmcgKHN1Y2ggYXMgRUVIIG9yIHVucGx1ZykNCj4gcmVzdWx0cyBp
biB0aGUgZGV2aWNlIGJlaW5nIG9mZmxpbmVkIHRob3VnaCB0aGlzIHRlbmQgdG8gYmUNCj4gYXN5
bmNocm9ub3VzIHNvIGl0IG1pZ2h0IHRha2UgYSBmZXcgfjAncyBiZWZvcmUgeW91IGdldCBpdC4N
Cg0KT24gb25lIG9mIG15IHN5c3RlbXMgSSBkb24ndCB0aGluayB0aGUgZXJyb3IgVExQIGZyb20g
dGhlIHRhcmdldA0KbWFkZSBpdHMgd2F5IHBhc3QgdGhlIGZpcnN0IGJyaWRnZSAtIEkgY291bGQg
c2VlIHRoZSBlcnJvciBpbiBpdCdzDQpzdGF0dXMgcmVnaXN0ZXJzLg0KQnV0IEkgY291bGRuJ3Qg
ZmluZCBhbnkgb2YgdGhlIEFFUiBzdGF0dXMgcmVnaXN0ZXJzIGluIHRoZSByb290IGJyaWRnZS4N
ClNvIEkgdGhpbmsgeW91J2QgbmVlZCBhIHNvZnR3YXJlIHBvbGwgb2YgdGhlIGJyaWRnZSByZWdp
c3RlcnMgdG8NCmZpbmQgb3V0IChhbmQgY2xlYXIpIHRoZSBlcnJvci4NCg0KVGhlIE5NSSBvbiB0
aGUgZGVsbCBzeXN0ZW0gKHdoaWNoIGlzIHN1cHBvc2VkIHRvIG1lZXQgc29tZSBzcGVjaWFsDQpO
RUJTPyBzZXJ2ZXIgcmVxdWlyZW1lbnRzKSBpcyBqdXN0IHN0dXBpZC4NClRvbyBsYXRlIHRvIGJl
IHN5bmNocm9ub3VzIGFuZCBpbXBvc3NpYmxlIGZvciB0aGUgT1MgdG8gaGFuZGxlLg0KDQoJRGF2
aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50
IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTcz
ODYgKFdhbGVzKQ0K
