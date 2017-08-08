From: David Laight <David.Laight@ACULAB.COM>
Date: Tue, 08 Aug 2017 13:15:55 +0000
Subject: RE: [v6 11/15] arm64/kasan: explicitly zero kasan shadow memory
Message-Id: <063D6719AE5E284EB5DD2968C1650D6DD004DA79@AcuExch.aculab.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-12-git-send-email-pasha.tatashin@oracle.com>
 <20170808090743.GA12887@arm.com>
 <f8b2b9ed-abf0-0c16-faa2-98b66dcbed78@oracle.com>
In-Reply-To: <f8b2b9ed-abf0-0c16-faa2-98b66dcbed78@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

RnJvbTogUGFzaGEgVGF0YXNoaW4NCj4gU2VudDogMDggQXVndXN0IDIwMTcgMTI6NDkNCj4gVGhh
bmsgeW91IGZvciBsb29raW5nIGF0IHRoaXMgY2hhbmdlLiBXaGF0IHlvdSBkZXNjcmliZWQgd2Fz
IGluIG15DQo+IHByZXZpb3VzIGl0ZXJhdGlvbnMgb2YgdGhpcyBwcm9qZWN0Lg0KPiANCj4gU2Vl
IGZvciBleGFtcGxlIGhlcmU6IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE3LzUvNS8zNjkNCj4g
DQo+IEkgd2FzIGFza2VkIHRvIHJlbW92ZSB0aGF0IGZsYWcsIGFuZCBvbmx5IHplcm8gbWVtb3J5
IGluIHBsYWNlIHdoZW4NCj4gbmVlZGVkLiBPdmVyYWxsIHRoZSBjdXJyZW50IGFwcHJvYWNoIGlz
IGJldHRlciBldmVyeXdoZXJlIGVsc2UgaW4gdGhlDQo+IGtlcm5lbCwgYnV0IGl0IGFkZHMgYSBs
aXR0bGUgZXh0cmEgY29kZSB0byBrYXNhbiBpbml0aWFsaXphdGlvbi4NCg0KUGVyaGFwcyB5b3Ug
Y291bGQgI2RlZmluZSB0aGUgZnVuY3Rpb24gcHJvdG90eXBlKHM/KSBzbyB0aGF0IHRoZSBmbGFn
cw0KYXJlIG5vdCBwYXNzZWQgdW5sZXNzIGl0IGlzIGEga2FzYW4gYnVpbGQ/DQoNCglEYXZpZA0K
DQo