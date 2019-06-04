From: "Koenig, Christian" <Christian.Koenig@amd.com>
Date: Tue, 04 Jun 2019 11:49:52 +0000
Subject: Re: [PATCH] uaccess: add noop untagged_addr definition
Message-Id: <ff73058a-f57b-526b-af53-c0e30b7b1bc1@amd.com>
List-Id: <sparclinux.vger.kernel.org>
References: <8ab5cd1813b0890f8780018e9784838456ace49e.1559648669.git.andreyknvl@google.com>
 <d74b1621-70a2-94a0-e24b-dae32adc457d@amd.com>
 <CAAeHK+w0_9QdxCJXEf=6nMgZpsb8NyrAaMO010Hh86TW75jJvw@mail.gmail.com>
In-Reply-To: <CAAeHK+w0_9QdxCJXEf=6nMgZpsb8NyrAaMO010Hh86TW75jJvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Khalid Aziz <khalid.aziz@oracle.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "Kuehling, 
 Felix" <Felix.Kuehling@amd.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dmitry Vyukov <dvyukov@google.com>, Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Robin Murphy <robin.murphy@arm.com>, Alex Williamson <alex.williamson@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kostya Serebryany <kcc@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yishai Hadas <yishaih@mellanox.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lee Smith <Lee.Smith@arm.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Andrew Morton <akpm@linux-foundation.org>, enh <enh@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jens Wiklander <jens.wiklander@linaro.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

QW0gMDQuMDYuMTkgdW0gMTM6NDggc2NocmllYiBBbmRyZXkgS29ub3ZhbG92Og0KPiBPbiBUdWUs
IEp1biA0LCAyMDE5IGF0IDE6NDYgUE0gS29lbmlnLCBDaHJpc3RpYW4NCj4gPENocmlzdGlhbi5L
b2VuaWdAYW1kLmNvbT4gd3JvdGU6DQo+PiBBbSAwNC4wNi4xOSB1bSAxMzo0NCBzY2hyaWViIEFu
ZHJleSBLb25vdmFsb3Y6DQo+Pj4gQXJjaGl0ZWN0dXJlcyB0aGF0IHN1cHBvcnQgbWVtb3J5IHRh
Z2dpbmcgaGF2ZSBhIG5lZWQgdG8gcGVyZm9ybSB1bnRhZ2dpbmcNCj4+PiAoc3RyaXBwaW5nIHRo
ZSB0YWcpIGluIHZhcmlvdXMgcGFydHMgb2YgdGhlIGtlcm5lbC4gVGhpcyBwYXRjaCBhZGRzIGFu
DQo+Pj4gdW50YWdnZWRfYWRkcigpIG1hY3JvLCB3aGljaCBpcyBkZWZpbmVkIGFzIG5vb3AgZm9y
IGFyY2hpdGVjdHVyZXMgdGhhdCBkbw0KPj4+IG5vdCBzdXBwb3J0IG1lbW9yeSB0YWdnaW5nLiBU
aGUgb25jb21pbmcgcGF0Y2ggc2VyaWVzIHdpbGwgZGVmaW5lIGl0IGF0DQo+Pj4gbGVhc3QgZm9y
IHNwYXJjNjQgYW5kIGFybTY0Lg0KPj4+DQo+Pj4gQWNrZWQtYnk6IENhdGFsaW4gTWFyaW5hcyA8
Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+DQo+Pj4gUmV2aWV3ZWQtYnk6IEtoYWxpZCBBeml6IDxr
aGFsaWQuYXppekBvcmFjbGUuY29tPg0KPj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBLb25vdmFs
b3YgPGFuZHJleWtudmxAZ29vZ2xlLmNvbT4NCj4+PiAtLS0NCj4+PiAgICBpbmNsdWRlL2xpbnV4
L21tLmggfCA0ICsrKysNCj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+
Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tbS5oIGIvaW5jbHVkZS9saW51eC9t
bS5oDQo+Pj4gaW5kZXggMGU4ODM0YWMzMmI3Li45NDlkNDNlOWMwYjYgMTAwNjQ0DQo+Pj4gLS0t
IGEvaW5jbHVkZS9saW51eC9tbS5oDQo+Pj4gKysrIGIvaW5jbHVkZS9saW51eC9tbS5oDQo+Pj4g
QEAgLTk5LDYgKzk5LDEwIEBAIGV4dGVybiBpbnQgbW1hcF9ybmRfY29tcGF0X2JpdHMgX19yZWFk
X21vc3RseTsNCj4+PiAgICAjaW5jbHVkZSA8YXNtL3BndGFibGUuaD4NCj4+PiAgICAjaW5jbHVk
ZSA8YXNtL3Byb2Nlc3Nvci5oPg0KPj4+DQo+Pj4gKyNpZm5kZWYgdW50YWdnZWRfYWRkcg0KPj4+
ICsjZGVmaW5lIHVudGFnZ2VkX2FkZHIoYWRkcikgKGFkZHIpDQo+Pj4gKyNlbmRpZg0KPj4+ICsN
Cj4+IE1heWJlIGFkZCBhIGNvbW1lbnQgd2hhdCB0YWdnaW5nIGFjdHVhbGx5IGlzPyBDYXVzZSB0
aGF0IGlzIG5vdCByZWFsbHkNCj4+IG9idmlvdXMgZnJvbSB0aGUgY29udGV4dC4NCj4gSGksDQo+
DQo+IERvIHlvdSBtZWFuIGEgY29tbWVudCBpbiB0aGUgY29kZSBvciBhbiBleHBsYW5hdGlvbiBp
biB0aGUgcGF0Y2ggZGVzY3JpcHRpb24/DQoNClRoZSBjb2RlLCB0aGUgcGF0Y2ggZGVzY3JpcHRp
b24gYWN0dWFsbHkgc291bmRzIGdvb2QgdG8gbWUuDQoNCkNocmlzdGlhbi4NCg0KPg0KPiBUaGFu
a3MhDQo+DQo+PiBDaHJpc3RpYW4uDQo+Pg0KPj4+ICAgICNpZm5kZWYgX19wYV9zeW1ib2wNCj4+
PiAgICAjZGVmaW5lIF9fcGFfc3ltYm9sKHgpICBfX3BhKFJFTE9DX0hJREUoKHVuc2lnbmVkIGxv
bmcpKHgpLCAwKSkNCj4+PiAgICAjZW5kaWYNCg0K
