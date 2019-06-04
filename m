From: "Koenig, Christian" <Christian.Koenig@amd.com>
Date: Tue, 04 Jun 2019 11:46:39 +0000
Subject: Re: [PATCH] uaccess: add noop untagged_addr definition
Message-Id: <d74b1621-70a2-94a0-e24b-dae32adc457d@amd.com>
List-Id: <sparclinux.vger.kernel.org>
References: <8ab5cd1813b0890f8780018e9784838456ace49e.1559648669.git.andreyknvl@google.com>
In-Reply-To: <8ab5cd1813b0890f8780018e9784838456ace49e.1559648669.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrey Konovalov <andreyknvl@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kostya Serebryany <kcc@google.com>, Khalid Aziz <khalid.aziz@oracle.com>, "Kuehling, 
 Felix" <Felix.Kuehling@amd.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Alex Williamson <alex.williamson@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yishai Hadas <yishaih@mellanox.com>, Lee Smith <Lee.Smith@arm.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Andrew Morton <akpm@linux-foundation.org>, enh <enh@google.com>, Robin Murphy <robin.murphy@arm.com>, Jens Wiklander <jens.wiklander@linaro.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

QW0gMDQuMDYuMTkgdW0gMTM6NDQgc2NocmllYiBBbmRyZXkgS29ub3ZhbG92Og0KPiBBcmNoaXRl
Y3R1cmVzIHRoYXQgc3VwcG9ydCBtZW1vcnkgdGFnZ2luZyBoYXZlIGEgbmVlZCB0byBwZXJmb3Jt
IHVudGFnZ2luZw0KPiAoc3RyaXBwaW5nIHRoZSB0YWcpIGluIHZhcmlvdXMgcGFydHMgb2YgdGhl
IGtlcm5lbC4gVGhpcyBwYXRjaCBhZGRzIGFuDQo+IHVudGFnZ2VkX2FkZHIoKSBtYWNybywgd2hp
Y2ggaXMgZGVmaW5lZCBhcyBub29wIGZvciBhcmNoaXRlY3R1cmVzIHRoYXQgZG8NCj4gbm90IHN1
cHBvcnQgbWVtb3J5IHRhZ2dpbmcuIFRoZSBvbmNvbWluZyBwYXRjaCBzZXJpZXMgd2lsbCBkZWZp
bmUgaXQgYXQNCj4gbGVhc3QgZm9yIHNwYXJjNjQgYW5kIGFybTY0Lg0KPg0KPiBBY2tlZC1ieTog
Q2F0YWxpbiBNYXJpbmFzIDxjYXRhbGluLm1hcmluYXNAYXJtLmNvbT4NCj4gUmV2aWV3ZWQtYnk6
IEtoYWxpZCBBeml6IDxraGFsaWQuYXppekBvcmFjbGUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBB
bmRyZXkgS29ub3ZhbG92IDxhbmRyZXlrbnZsQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgIGluY2x1
ZGUvbGludXgvbW0uaCB8IDQgKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KykNCj4NCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW0uaCBiL2luY2x1ZGUvbGludXgv
bW0uaA0KPiBpbmRleCAwZTg4MzRhYzMyYjcuLjk0OWQ0M2U5YzBiNiAxMDA2NDQNCj4gLS0tIGEv
aW5jbHVkZS9saW51eC9tbS5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvbW0uaA0KPiBAQCAtOTks
NiArOTksMTAgQEAgZXh0ZXJuIGludCBtbWFwX3JuZF9jb21wYXRfYml0cyBfX3JlYWRfbW9zdGx5
Ow0KPiAgICNpbmNsdWRlIDxhc20vcGd0YWJsZS5oPg0KPiAgICNpbmNsdWRlIDxhc20vcHJvY2Vz
c29yLmg+DQo+ICAgDQo+ICsjaWZuZGVmIHVudGFnZ2VkX2FkZHINCj4gKyNkZWZpbmUgdW50YWdn
ZWRfYWRkcihhZGRyKSAoYWRkcikNCj4gKyNlbmRpZg0KPiArDQoNCk1heWJlIGFkZCBhIGNvbW1l
bnQgd2hhdCB0YWdnaW5nIGFjdHVhbGx5IGlzPyBDYXVzZSB0aGF0IGlzIG5vdCByZWFsbHkgDQpv
YnZpb3VzIGZyb20gdGhlIGNvbnRleHQuDQoNCkNocmlzdGlhbi4NCg0KPiAgICNpZm5kZWYgX19w
YV9zeW1ib2wNCj4gICAjZGVmaW5lIF9fcGFfc3ltYm9sKHgpICBfX3BhKFJFTE9DX0hJREUoKHVu
c2lnbmVkIGxvbmcpKHgpLCAwKSkNCj4gICAjZW5kaWYNCg0K
