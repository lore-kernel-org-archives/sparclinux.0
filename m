From: David Miller <davem@davemloft.net>
Date: Wed, 20 Mar 2013 18:42:16 +0000
Subject: Re: [PATCH] sparc64: Provide cmpxchg64()
Message-Id: <20130320.144216.594175674538206267.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1363790104-8140-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1363790104-8140-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: geert@linux-m68k.org
Cc: sparclinux@vger.kernel.org, linux-next@vger.kernel.org

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCkRhdGU6IFdl
ZCwgMjAgTWFyIDIwMTMgMTU6MzU6MDQgKzAxMDANCg0KPiBzcGFyYzY0IGFsbG1vZGNvbmZpZzoN
Cj4gDQo+IGRyaXZlcnMvYmxvY2svYmxvY2tjb25zb2xlLmM6IEluIGZ1bmN0aW9uIKFiY29uX2Fk
dmFuY2VfY29uc29sZV9ieXRlc6I6DQo+IGRyaXZlcnMvYmxvY2svYmxvY2tjb25zb2xlLmM6MTY0
OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24goWNtcHhjaGc2NKINCj4g
DQo+IE1hcCBjbXB4Y2hnNjQoKSB0byBjbXB4Y2hnNjRfbG9jYWwoKSAod2hpY2ggZXZlbnR1YWxs
eSBjYWxscw0KPiBfX2NtcHhjaGdfdTY0KCkpIHRvIGZpeCB0aGlzLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCg0KQXBwbGll
ZCB0byBzcGFyYy1uZXh0LCB0aGFua3MuDQo