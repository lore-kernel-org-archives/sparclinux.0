Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE23C433EF
	for <sparclinux@archiver.kernel.org>; Wed,  8 Sep 2021 14:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D61616115C
	for <sparclinux@archiver.kernel.org>; Wed,  8 Sep 2021 14:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349196AbhIHOtG (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 8 Sep 2021 10:49:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:33854 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349323AbhIHOtF (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 8 Sep 2021 10:49:05 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-277-j23YFEquPCCa7B74ZTSy3w-1; Wed, 08 Sep 2021 15:47:55 +0100
X-MC-Unique: j23YFEquPCCa7B74ZTSy3w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Wed, 8 Sep 2021 15:47:53 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Wed, 8 Sep 2021 15:47:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        Martin Sebor <msebor@gcc.gnu.org>
Subject: RE: [PATCH] Enable '-Werror' by default for all kernel builds
Thread-Topic: [PATCH] Enable '-Werror' by default for all kernel builds
Thread-Index: AQHXpJbq9AUK4jat3k+ozp/ju21D7quaNSJg
Date:   Wed, 8 Sep 2021 14:47:52 +0000
Message-ID: <401c9db63f764389bec7faaf41deb92f@AcuMS.aculab.com>
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <c3790fb9-b83f-9596-18a1-21ace987c850@roeck-us.net>
 <CAHk-=wi4NW3NC0xWykkw=6LnjQD6D_rtRtxY9g8gQAJXtQMi8A@mail.gmail.com>
 <20210906234921.GA1394069@roeck-us.net>
 <20210908042838.GA2585993@roeck-us.net>
 <YThAgIhKPQZq5UZn@zeniv-ca.linux.org.uk>
 <f4817c3d-c051-4030-e9ca-ea8b3f846119@roeck-us.net>
 <CAMuHMdWhzL+aWosce71Xm-7dKsgXFyL42tQ2gV2HyEZp5r0N7A@mail.gmail.com>
 <CAK8P3a3yJHvJaFHUh2+5GPm2n_g9gSfX2rFbrSLzDt6yC4eDog@mail.gmail.com>
In-Reply-To: <CAK8P3a3yJHvJaFHUh2+5GPm2n_g9gSfX2rFbrSLzDt6yC4eDog@mail.gmail.com>
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

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAwOCBTZXB0ZW1iZXIgMjAyMSAxMDo1MA0KLi4u
DQo+ID4gPiBJIGRvbid0IGtub3cgdGhlIGhhcmR3YXJlLCBzbyBJIGNhbiBub3QgYW5zd2VyIHRo
ZSBpb3JlbWFwKCkgcXVlc3Rpb24uDQo+ID4NCj4gPiBZZXMgaXQgc2hvdWxkLiAgQnV0IHRoaXMg
ZHJpdmVyIGRhdGVzIGJhY2sgdG8gMi4xLjExMCwgd2hlbiBvbmx5DQo+ID4gaGFsZiBvZiB0aGUg
YXJjaGl0ZWN0dXJlcyBhbHJlYWR5IGhhZCBpb3JlbWFwKCkuDQo+IA0KPiBIb3cgZG9lcyAgbXZt
ZTE2eCBldmVuIGNyZWF0ZSB0aGUgbWFwcGluZz8gSXMgdGhpcyBhIHZpcnR1YWwgYWRkcmVzcw0K
PiB0aGF0IGlzIGhhcmR3aXJlZCB0byB0aGUgYnVzIG9yIGRvIHlvdSBoYXZlIGEgc3RhdGljIG1h
cHBpbmcgc29tZXdoZXJlPw0KPiBJIHNlZSB0d28gb3RoZXIgZHJpdmVycyBhY2Nlc3NpbmcgdGhl
IG52cmFtIGhlcmUNCj4gDQo+IGFyY2gvbTY4ay9tdm1lMTZ4L2NvbmZpZy5jOnN0YXRpYyBNSzQ4
VDA4cHRyX3Qgdm9sYXRpbGUgcnRjID0gKE1LNDhUMDhwdHJfdClNVk1FX1JUQ19CQVNFOw0KPiBh
cmNoL202OGsvbXZtZTE2eC9ydGMuYzogICAgICAgIHZvbGF0aWxlIE1LNDhUMDhwdHJfdCBydGMg
PSAoTUs0OFQwOHB0cl90KU1WTUVfUlRDX0JBU0U7DQo+IA0KPiBUaGUgc2FtZSB0cmljayBzaG91
bGQgd29yayBoZXJlLCBqdXN0IGNyZWF0ZSBhIGxvY2FsIHZhcmlhYmxlIHdpdGggYQ0KPiB2b2xh
dGlsZSBwb2ludGVyIGFuZCByZWFkIGZyb20gdGhhdC4NCg0KT3IgZGVmaW5lIGEgQyAnZXh0ZXJu
JyBmb3IgdGhlIGFjdHVhbCBkYXRhIGFuZCBnZXQgdGhlIGxpbmtlciBzY3JpcHQNCnRvIGFzc2ln
biBhIGZpeGVkIHZhbHVlIHRvIHRoZSBzeW1ib2wuDQooQWx0aG91Z2ggdGhhdCBkb2VzIHBvbGx1
dGUgdGhlIGdsb2JhbCBuYW1lc3BhY2UuKQ0KDQpBbiBhbHRlcm5hdGl2ZSBpcyB0byB1c2UgYW4g
YXNtIHN0YXRlbWVudCBzbyB0aGUgY29tcGlsZXINCmNhbm5vdCB0cmFjayB0aGUgYWN0dWFsIHZh
bHVlLg0KU29tZXRoaW5nIGxpa2U6DQoNCiNkZWZpbmUgbGF1bmRlcih4KSBhc20gdm9sYXRpbGUo
ICIiIDogIityIiAoeCkpDQoNCglNSzQ4VDA4cHRyX3QgcnRjID0gKHZvaWQgKilNVk1FX1JUQ19C
QVNFOw0KCWxhdW5kZXIocnRjKTsNCg0KVGhhdCBhbHNvIHdvcmtzIGEgYml0IGxpa2UgUkVBRF9P
TkNFKCkgZXhjZXB0IHRoYXQgaXMgd29ya3MNCm9uIGEgdmFsdWUgdGhhdCBpcyAoaG9wZWZ1bGx5
KSBhbHJlYWR5IGluIGEgcmVnaXN0ZXIgcmF0aGVyDQp0aGF0IGR1cmluZyB0aGUgcmVhZCBmcm9t
IG1lbW9yeS4NClVzZWZ1bCB3aGVuIHRoZSBjb21waWxlcidzICd2YWx1ZSB0cmFja2luZycgcGVz
c2ltaXNlcyBjb2RlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRl
LCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpS
ZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

