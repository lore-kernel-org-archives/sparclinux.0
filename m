Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EFAC433EF
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 14:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B59D60EE3
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 14:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhINOSj (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 10:18:39 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:29826 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233309AbhINOSj (ORCPT
        <rfc822;sparclinux@vger.kernel.org>);
        Tue, 14 Sep 2021 10:18:39 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-226-psqTlCQSPzSokX6E0pG-_w-1; Tue, 14 Sep 2021 15:17:17 +0100
X-MC-Unique: psqTlCQSPzSokX6E0pG-_w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Tue, 14 Sep 2021 15:17:16 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Tue, 14 Sep 2021 15:17:16 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Guenter Roeck' <linux@roeck-us.net>,
        Sam Ravnborg <sam@ravnborg.org>
CC:     "David S . Miller" <davem@davemloft.net>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>
Subject: RE: [PATCH] sparc: mdesc: Fix compile error seen with gcc 11.x
Thread-Topic: [PATCH] sparc: mdesc: Fix compile error seen with gcc 11.x
Thread-Index: AQHXqNCRdjfpTL0To0ac+9sZuEahj6ujlB+Q
Date:   Tue, 14 Sep 2021 14:17:15 +0000
Message-ID: <2d8f45425f024fd9a3d91a4b4a1304cf@AcuMS.aculab.com>
References: <20210913163712.922188-1-linux@roeck-us.net>
 <YT+SPIAl0IdWOAn/@ravnborg.org>
 <d0a4b46a-2f0e-f6a2-1342-777e738d9525@roeck-us.net>
In-Reply-To: <d0a4b46a-2f0e-f6a2-1342-777e738d9525@roeck-us.net>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VlbnRlciBSb2VjayA8
Z3JvZWNrN0BnbWFpbC5jb20+IE9uIEJlaGFsZiBPZiBHdWVudGVyIFJvZWNrDQo+IFNlbnQ6IDEz
IFNlcHRlbWJlciAyMDIxIDE5OjUzDQo+IFRvOiBTYW0gUmF2bmJvcmcgPHNhbUByYXZuYm9yZy5v
cmc+DQo+IENjOiBEYXZpZCBTIC4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0Pjsgc3BhcmNs
aW51eEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IEFy
bmQgQmVyZ21hbm4gPGFybmRAa2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gc3Bh
cmM6IG1kZXNjOiBGaXggY29tcGlsZSBlcnJvciBzZWVuIHdpdGggZ2NjIDExLngNCj4gDQo+IE9u
IDkvMTMvMjEgMTE6MDIgQU0sIFNhbSBSYXZuYm9yZyB3cm90ZToNCj4gPiBIaSBHdWVudGVyLA0K
PiA+DQo+ID4gT24gTW9uLCBTZXAgMTMsIDIwMjEgYXQgMDk6Mzc6MTJBTSAtMDcwMCwgR3VlbnRl
ciBSb2VjayB3cm90ZToNCj4gPj4gc3BhcmM2NCBpbWFnZXMgZmFpbCB0byBjb21waWxlIHdpdGgg
Z2NjIDExLngsIHJlcG9ydGluZyB0aGUgZm9sbG93aW5nDQo+ID4+IGVycm9ycy4NCj4gPj4NCj4g
Pj4gYXJjaC9zcGFyYy9rZXJuZWwvbWRlc2MuYzo2NDc6MjI6IGVycm9yOg0KPiA+PiAJJ3N0cmNt
cCcgcmVhZGluZyAxIG9yIG1vcmUgYnl0ZXMgZnJvbSBhIHJlZ2lvbiBvZiBzaXplIDANCj4gPj4g
YXJjaC9zcGFyYy9rZXJuZWwvbWRlc2MuYzo2OTI6MjI6IGVycm9yOg0KPiA+PiAJJ3N0cmNtcCcg
cmVhZGluZyAxIG9yIG1vcmUgYnl0ZXMgZnJvbSBhIHJlZ2lvbiBvZiBzaXplIDANCj4gPj4gYXJj
aC9zcGFyYy9rZXJuZWwvbWRlc2MuYzo3MTk6MjE6DQo+ID4+IAllcnJvcjogJ3N0cmNtcCcgcmVh
ZGluZyAxIG9yIG1vcmUgYnl0ZXMgZnJvbSBhIHJlZ2lvbiBvZiBzaXplIDANCj4gPj4NCj4gPj4g
VGhlIHVuZGVybHlpbmcgcHJvYmxlbSBpcyB0aGF0IG5vZGVfYmxvY2soKSByZXR1cm5zIGEgcG9p
bnRlciBiZXlvbmQNCj4gPj4gdGhlIGVuZCBvZiBzdHJ1Y3QgbWRlc2NfaGRyLiBnY2MgMTEueCBk
ZXRlY3RzIHRoYXQgYW5kIHJlcG9ydHMgdGhlIGVycm9yLg0KPiA+PiBBZGRpbmcgYW4gYWRkaXRp
b25hbCB6ZXJvLWxlbmd0aCBmaWVsZCB0byBzdHJ1Y3QgbWRlc2NfaGRyIGFuZCBwb2ludGluZw0K
PiA+PiB0byB0aGF0IGZpZWxkIGZpeGVzIHRoZSBwcm9ibGVtLg0KPiA+Pg0KPiA+PiBDYzogQXJu
ZCBCZXJnbWFubiA8YXJuZEBrZXJuZWwub3JnPg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBHdWVudGVy
IFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+DQo+ID4+IC0tLQ0KPiA+PiBNeSBhcG9sb2dpZXMg
aWYgYSBzaW1pbGFyIHBhdGNoIHdhcyBzdWJtaXR0ZWQgYWxyZWFkeTsgSSB3YXMgdW5hYmxlIHRv
IGZpbmQgaXQuDQo+ID4+IEkgZGlkIGZpbmQgdGhlIGZvbGxvd2luZyBwYXRjaDoNCj4gPj4gICAg
ICBodHRwczovL2dpdC5idXN5Ym94Lm5ldC9idWlsZHJvb3QvY29tbWl0Lz9pZD02ZTExMDZiNGE5
YWVlMjVkMTU1NjMxMGQ1Y2QxY2I2ZGRlMmU2ZTNmDQo+ID4+IGJ1dCBJIGZhaWxlZCB0byBmaW5k
IGl0IGluIHBhdGNod29yayBvciBvbiBsb3JlLmtlcm5lbC5vcmcsIGFuZCBpdA0KPiA+PiBzZWVt
cyB0byBiZSBtb3JlIGV4cGVuc2l2ZSB0aGFuIHRoZSBzb2x1dGlvbiBzdWdnZXN0ZWQgaGVyZS4N
Cj4gPj4NCj4gPj4gICBhcmNoL3NwYXJjL2tlcm5lbC9tZGVzYy5jIHwgMyArKy0NCj4gPj4gICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+DQo+ID4+
IGRpZmYgLS1naXQgYS9hcmNoL3NwYXJjL2tlcm5lbC9tZGVzYy5jIGIvYXJjaC9zcGFyYy9rZXJu
ZWwvbWRlc2MuYw0KPiA+PiBpbmRleCA4ZTY0NWRkYWM1OGUuLmM2N2JkY2MyMzcyNyAxMDA2NDQN
Cj4gPj4gLS0tIGEvYXJjaC9zcGFyYy9rZXJuZWwvbWRlc2MuYw0KPiA+PiArKysgYi9hcmNoL3Nw
YXJjL2tlcm5lbC9tZGVzYy5jDQo+ID4+IEBAIC0zOSw2ICszOSw3IEBAIHN0cnVjdCBtZGVzY19o
ZHIgew0KPiA+PiAgIAl1MzIJbm9kZV9zejsgLyogbm9kZSBibG9jayBzaXplICovDQo+ID4+ICAg
CXUzMgluYW1lX3N6OyAvKiBuYW1lIGJsb2NrIHNpemUgKi8NCj4gPj4gICAJdTMyCWRhdGFfc3o7
IC8qIGRhdGEgYmxvY2sgc2l6ZSAqLw0KPiA+PiArCWNoYXIJZGF0YVswXTsNCj4gPj4gICB9IF9f
YXR0cmlidXRlX18oKGFsaWduZWQoMTYpKSk7DQo+ID4NCj4gPiBJIGRvIG5vdCB0aGluayB0aGlz
IHdpbGwgd29ya3MuDQo+ID4gU2VlIGZvbGxvd2luZyBjb21tZW50Og0KPiA+ICAgKiBtZGVzY19o
ZHIgYW5kIG1kZXNjX2VsZW0gZGVzY3JpYmUgdGhlIGxheW91dCBvZiB0aGUgZGF0YSBzdHJ1Y3R1
cmUNCj4gPiAgICogd2UgZ2V0IGZyb20gdGhlIEh5cGVydmlzb3IuDQo+ID4NCj4gPiBXaXRoIHRo
ZSBhYm92ZSBjaGFuZ2UgeW91IGluY3JlYXNlZCB0aGUgc2l6ZSBmcm9tIDE2IHRvIDMyIGJ5dGVz
LA0KPiA+IGFuZCBhbnkgY29kZSB1c2luZyBzaXplb2Yoc3RydWN0IG1kZXNjX2hkcikgd2lsbCBu
b3cgcG9pbnQgdG9vIGZhciBpbg0KPiA+IG1lbW9yeSBmb3IgdGhlIHNlY29uZCBhbmQgc3Vic2Vx
dWVudCBlbnRyaWVzLg0KPiA+DQo+ID4gSSBkaWQgbm90IHRha2UgYW55IGNsb3NlciBsb29rLCBi
dXQgdGhpcyB3YXMgZnJvbSBhIHF1aWNrIGFuYWx5c2lzLg0KPiA+DQo+IA0KPiBTb3JyeSwgSSBk
aWRuJ3QgcmVhbGl6ZSB0aGF0IGEgZmllbGQgb2Ygc2l6ZSAwIGluY3JlYXNlcyB0aGUgc3RydWN0
dXJlIHNpemUNCj4gb24gc3BhcmMuIEkgaGFkIGNoZWNrZWQgdGhlIHNpemUgb2YgdGhlIG9sZCBh
bmQgdGhlIG5ldyBzdHJ1Y3R1cmUgd2l0aCBnY2MNCj4gb24geDg2XzY0IGFuZCBkaWRuJ3Qgc2Vl
IGEgZmllbGQgc2l6ZSBpbmNyZWFzZS4NCg0KY2xhbmcgb3V0cHV0IGRvZXNuJ3QgY2hhbmdlOg0K
DQpodHRwczovL2dvZGJvbHQub3JnL3ovYlRlZXExOWoxDQoNCmdjYyBvdWdodCB0byBnZW5lcmF0
ZSB0aGUgc2FtZSBzaXplLg0KDQpJdCBvdWdodCB0byBiZSAnY2hhciBkYXRhW107JyB0aG91Z2gu
DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBO
bzogMTM5NzM4NiAoV2FsZXMpDQo=

