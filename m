From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Date: Fri, 11 May 2018 12:44:23 +0000
Subject: Re: [PATCH 03/20] arc: use generic dma_noncoherent_ops
Message-Id: <1526042662.19036.31.camel@synopsys.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180511075945.16548-1-hch@lst.de>
	<20180511075945.16548-4-hch@lst.de>
In-Reply-To: <20180511075945.16548-4-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>
Cc: "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org" <linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org>, "monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org" <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, "linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org" <linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org>, "linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org" <linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org>, "openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org" <openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org>, "green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

SGkgQ2hyaXN0b3BoLA0KDQpPbiBGcmksIDIwMTgtMDUtMTEgYXQgMDk6NTkgKzAyMDAsIENocmlz
dG9waCBIZWxsd2lnIHdyb3RlOg0KPiBTd2l0Y2ggdG8gdGhlIGdlbmVyaWMgbm9uY29oZXJlbnQg
ZGlyZWN0IG1hcHBpbmcgaW1wbGVtZW50YXRpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJp
c3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gLS0tDQo+ICBhcmNoL2FyYy9LY29uZmlnICAg
ICAgICAgICAgICAgICAgIHwgICA0ICsNCj4gIGFyY2gvYXJjL2luY2x1ZGUvYXNtL0tidWlsZCAg
ICAgICAgfCAgIDEgKw0KPiAgYXJjaC9hcmMvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaCB8ICAy
MSAtLS0tLQ0KPiAgYXJjaC9hcmMvbW0vZG1hLmMgICAgICAgICAgICAgICAgICB8IDE0MSArKyst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRp
b25zKCspLCAxNDggZGVsZXRpb25zKC0pDQo+ICBkZWxldGUgbW9kZSAxMDA2NDQgYXJjaC9hcmMv
aW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaA0KDQpTb3JyeSBJIGRpZG4ndCB0cnkgeW91ciBwcm9w
b3NlZCBmaXggZWFybGllciAtIHdhcyBhd2F5IGZvciBhIGNvdXBsZSBvZiBkYXlzLg0KDQpCdXQg
dGhhdCBuZXdlciB2ZXJzaW9uIHdpdGggZml4ZWQgbGliL2RtYS1ub25jb2hlcmVudC5jIHN0aWxs
IGRvZXNuJ3Qgd29yayBvbiBBUkMuDQoNClVTQiBFQ0hJIGNvbnRyb2xsZXIgZmFpbHMgbGlrZSB0
aGF0Og0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KdXNiIDEtMTogbmV3IGhpZ2gtc3BlZWQgVVNCIGRldmljZSBudW1iZXIgMiB1c2luZyBlaGNp
LXBsYXRmb3JtDQp1c2IgMS0xOiBjYW4ndCBzZXQgY29uZmlnICMxLCBlcnJvciAtMzINCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KQWdhaW4g
d2l0aCBlbnRpcmUgc2VyaWVzIHJldmVydGVkIFVTQiBzdGFydHMgdG8gd29yay4NCkxldCdzIHdh
aXQgZm9yIG90aGVyIGFyY2hlcyBwcmV2aW91c2x5IGFmZmVjdGVkIHRvIHVwZGF0ZSBvbiB0aGVp
ciBzdGF0dXMuDQoNCi1BbGV4ZXk