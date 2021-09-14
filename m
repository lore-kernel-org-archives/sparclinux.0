Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76C4C433EF
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 15:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A238F6103B
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 15:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbhINPFM (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 11:05:12 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:49650 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233828AbhINPFL (ORCPT
        <rfc822;sparclinux@vger.kernel.org>);
        Tue, 14 Sep 2021 11:05:11 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-171-uOHCrCrONzey65a0rqo3sw-1; Tue, 14 Sep 2021 16:03:52 +0100
X-MC-Unique: uOHCrCrONzey65a0rqo3sw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Tue, 14 Sep 2021 16:03:51 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Tue, 14 Sep 2021 16:03:51 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sparc: mdesc: Fix compile error seen with gcc 11.x
Thread-Topic: [PATCH] sparc: mdesc: Fix compile error seen with gcc 11.x
Thread-Index: AQHXqNCRdjfpTL0To0ac+9sZuEahj6ujlB+QgAAK78OAAAFOoA==
Date:   Tue, 14 Sep 2021 15:03:51 +0000
Message-ID: <549b61046b134234bd4bffd85315f29a@AcuMS.aculab.com>
References: <20210913163712.922188-1-linux@roeck-us.net>
 <YT+SPIAl0IdWOAn/@ravnborg.org>
 <d0a4b46a-2f0e-f6a2-1342-777e738d9525@roeck-us.net>
 <2d8f45425f024fd9a3d91a4b4a1304cf@AcuMS.aculab.com>
 <3b069cde-6f15-1df1-fbed-e8d94d0ef173@roeck-us.net>
 <CAK8P3a1mrZHHfN0dK6nV3jpBmnYm+jG=M8j2u=1=ZPkLuf2DXQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1mrZHHfN0dK6nV3jpBmnYm+jG=M8j2u=1=ZPkLuf2DXQ@mail.gmail.com>
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

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAxNCBTZXB0ZW1iZXIgMjAyMSAxNTo1NA0KPiAN
Cj4gT24gVHVlLCBTZXAgMTQsIDIwMjEgYXQgNDoyNCBQTSBHdWVudGVyIFJvZWNrIDxsaW51eEBy
b2Vjay11cy5uZXQ+IHdyb3RlOg0KPiA+IE9uIDkvMTQvMjEgNzoxNyBBTSwgRGF2aWQgTGFpZ2h0
IHdyb3RlOg0KPiA+ID4+IFNvcnJ5LCBJIGRpZG4ndCByZWFsaXplIHRoYXQgYSBmaWVsZCBvZiBz
aXplIDAgaW5jcmVhc2VzIHRoZSBzdHJ1Y3R1cmUgc2l6ZQ0KPiA+ID4+IG9uIHNwYXJjLiBJIGhh
ZCBjaGVja2VkIHRoZSBzaXplIG9mIHRoZSBvbGQgYW5kIHRoZSBuZXcgc3RydWN0dXJlIHdpdGgg
Z2NjDQo+ID4gPj4gb24geDg2XzY0IGFuZCBkaWRuJ3Qgc2VlIGEgZmllbGQgc2l6ZSBpbmNyZWFz
ZS4NCj4gPiA+DQo+ID4gPiBjbGFuZyBvdXRwdXQgZG9lc24ndCBjaGFuZ2U6DQo+ID4gPg0KPiA+
ID4gaHR0cHM6Ly9nb2Rib2x0Lm9yZy96L2JUZWVxMTlqMQ0KPiA+ID4NCj4gPiA+IGdjYyBvdWdo
dCB0byBnZW5lcmF0ZSB0aGUgc2FtZSBzaXplLg0KPiA+ID4NCj4gPiA+IEl0IG91Z2h0IHRvIGJl
ICdjaGFyIGRhdGFbXTsnIHRob3VnaC4NCj4gPiA+DQo+ID4NCj4gPiBJIGFtIG5ldmVyIHN1cmUg
aWYgW10gb3IgWzBdIGlzICJjb3JyZWN0Ii4gQW55d2F5LCBpcyB0aGVyZSBhZ3JlZW1lbnQgdGhh
dCB0aGlzDQo+ID4gaXMgYW4gYWNjZXB0YWJsZSBzb2x1dGlvbiA/IEknbGwgYmUgaGFwcHkgdG8g
cmVzZW5kIGlmIHRoYXQgaXMgdGhlIGNhc2UuDQo+IA0KPiBZZXMsIGxvb2tzIGdvb2QgdG8gbWUs
IGluIHRoZSBbXSB2ZXJzaW9uLiBJIHRoaW5rIHRoZSBbMF0gdmVyc2lvbiBjYW4gYmUNCj4gaW50
ZXJwcmV0ZWQgYXMgYSB6ZXJvLWxlbmd0aCBhcnJheSB0aGF0IG1heSBub3QgYmUgYWNjZXNzZWQs
IHdoaWxlIHRoZQ0KPiBbXSBmbGV4aWJsZSBhcnJheSBzeW50YXggY2xlYXJseSBtZWFucyB0aGF0
IGV4dHJhIGRhdGEgZm9sbG93cywgYW5kIGl0J3MNCj4gcGFydCBvZiB0aGUgQyBzdGFuZGFyZCBu
b3csIHdoaWxlIFswXSBpcyBhIGdjYyBleHRlbnNpb24uDQoNCk1vcmUgcHJvYmxlbWF0aWMgaXMg
d2hlcmUgaXMgdGhlIGNvcnJlY3QgcGxhY2UgZm9yIHRoZSAnY2hhciBkYXRhW10nLg0KSXQgZm9s
bG93cyB0aGUgaGVhZGVyIHJhdGhlciB0aGFuIGJlaW5nIHBhcnQgb2YgaXQuDQoNClNvIHRoZToN
CglkYXRhID0gKHZvaWQgKikoaGRyICsgMSk7DQpjb25zdHJ1Y3QgKEkndmUgbG9zdCB0aGUgb3Jp
Z2luYWwgcGF0Y2gpIGlzIGFic29sdXRlbHkgZGVzY3JpcHRpdmUuDQoNCmdjYyBpcyBnZXR0aW5n
IHRvIGJlIGEgcmVhbCBQSVRBIGZvciBzeXN0ZW0gY29kaW5nLg0KDQpGb3IgdGhpcyBwYXJ0aWN1
bGFyIGNoZWNrICdzaXplIDAnIG91Z2h0IHRvIGJlICdzaXplIHVua25vd24nDQphbmQgYWx3YXlz
IHZhbGlkLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFt
bGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3Ry
YXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

