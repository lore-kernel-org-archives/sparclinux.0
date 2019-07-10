From: Hoan Tran OS <hoan@os.amperecomputing.com>
Date: Wed, 10 Jul 2019 06:14:23 +0000
Subject: Re: [PATCH 3/5] x86: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
Message-Id: <50032a84-9453-8ab3-8d42-5bd8c1504640@os.amperecomputing.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1561501810-25163-1-git-send-email-Hoan@os.amperecomputing.com>
 <1561501810-25163-4-git-send-email-Hoan@os.amperecomputing.com>
 <alpine.DEB.2.21.1906260032250.32342@nanos.tec.linutronix.de>
 <1c5bc3a8-0c6f-dce3-95a2-8aec765408a2@os.amperecomputing.com>
 <alpine.DEB.2.21.1907100755010.1758@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907100755010.1758@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Michal Hocko <mhocko@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Open Source Submission <patches@amperecomputing.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will.deacon@arm.com>, Borislav Petkov <bp@alien8.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Oscar Salvador <osalvador@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "David S . Miller" <davem@davemloft.net>

SGkgVGhvbWFzLA0KDQoNCk9uIDcvMTAvMTkgMTI6NTggUE0sIFRob21hcyBHbGVpeG5lciB3cm90
ZToNCj4gSG9hbiwNCj4gDQo+IE9uIFdlZCwgMTAgSnVsIDIwMTksIEhvYW4gVHJhbiBPUyB3cm90
ZToNCj4+IE9uIDYvMjUvMTkgMzo0NSBQTSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPj4+IE9u
IFR1ZSwgMjUgSnVuIDIwMTksIEhvYW4gVHJhbiBPUyB3cm90ZToNCj4+Pj4gQEAgLTE1NjcsMTUg
KzE1NjcsNiBAQCBjb25maWcgWDg2XzY0X0FDUElfTlVNQQ0KPj4+PiAgICAJLS0taGVscC0tLQ0K
Pj4+PiAgICAJICBFbmFibGUgQUNQSSBTUkFUIGJhc2VkIG5vZGUgdG9wb2xvZ3kgZGV0ZWN0aW9u
Lg0KPj4+PiAgICANCj4+Pj4gLSMgU29tZSBOVU1BIG5vZGVzIGhhdmUgbWVtb3J5IHJhbmdlcyB0
aGF0IHNwYW4NCj4+Pj4gLSMgb3RoZXIgbm9kZXMuICBFdmVuIHRob3VnaCBhIHBmbiBpcyB2YWxp
ZCBhbmQNCj4+Pj4gLSMgYmV0d2VlbiBhIG5vZGUncyBzdGFydCBhbmQgZW5kIHBmbnMsIGl0IG1h
eSBub3QNCj4+Pj4gLSMgcmVzaWRlIG9uIHRoYXQgbm9kZS4gIFNlZSBtZW1tYXBfaW5pdF96b25l
KCkNCj4+Pj4gLSMgZm9yIGRldGFpbHMuDQo+Pj4+IC1jb25maWcgTk9ERVNfU1BBTl9PVEhFUl9O
T0RFUw0KPj4+PiAtCWRlZl9ib29sIHkNCj4+Pj4gLQlkZXBlbmRzIG9uIFg4Nl82NF9BQ1BJX05V
TUENCj4+Pg0KPj4+IHRoZSBjaGFuZ2Vsb2cgZG9lcyBub3QgbWVudGlvbiB0aGF0IHRoaXMgbGlm
dHMgdGhlIGRlcGVuZGVuY3kgb24NCj4+PiBYODZfNjRfQUNQSV9OVU1BIGFuZCB0aGVyZWZvcmUg
ZW5hYmxlcyB0aGF0IGZ1bmN0aW9uYWxpdHkgZm9yIGFueXRoaW5nDQo+Pj4gd2hpY2ggaGFzIE5V
TUEgZW5hYmxlZCBpbmNsdWRpbmcgMzJiaXQuDQo+Pj4NCj4+DQo+PiBJIHRoaW5rIHRoaXMgY29u
ZmlnIGlzIHVzZWQgZm9yIGEgTlVNQSBsYXlvdXQgd2hpY2ggTlVNQSBub2RlcyBhZGRyZXNzZXMN
Cj4+IGFyZSBzcGFubmVkIHRvIG90aGVyIG5vZGVzLiBJIHRoaW5rIDMyYml0IE5VTUEgYWxzbyBo
YXZlIHRoZSBzYW1lIGlzc3VlDQo+PiB3aXRoIHRoYXQgbGF5b3V0LiBQbGVhc2UgY29ycmVjdCBt
ZSBpZiBJJ20gd3JvbmcuDQo+IA0KPiBJJ20gbm90IHNheWluZyB5b3UncmUgd3JvbmcsIGJ1dCBp
dCdzIHlvdXIgZHV0eSB0byBwcm92aWRlIHRoZSBhbmFseXNpcyB3aHkNCj4gdGhpcyBpcyBjb3Jy
ZWN0IGZvciBldmVyeXRoaW5nIHdoaWNoIGhhcyBOVU1BIGVuYWJsZWQuDQo+IA0KPj4+IFRoZSBj
b3JlIG1tIGNoYW5nZSBnaXZlcyBubyBoZWxwZnVsIGluZm9ybWF0aW9uIGVpdGhlci4gWW91IGp1
c3QgY29waWVkIHRoZQ0KPj4+IGFib3ZlIGNvbW1lbnQgdGV4dCBmcm9tIHNvbWUgcmFuZG9tIEtj
b25maWcuDQo+Pg0KPj4gWWVzLCBhcyBpdCdzIGEgY29ycmVjdCBjb21tZW50IGFuZCBpcyB1c2Vk
IGF0IG11bHRpcGxlIHBsYWNlcy4NCj4gDQo+IFdlbGwgaXQgbWF5YmUgY29ycmVjdCBpbiB0ZXJt
cyBvZiBleHBsYWluaW5nIHdoYXQgdGhpcyBpcyBhYm91dCwgaXQgc3RpbGwNCj4gZG9lcyBub3Qg
ZXhwbGFpbiB3aHkgdGhpcyBpcyBuZWVkZWQgYnkgZGVmYXVsdCBvbiBldmVyeXRoaW5nIHdoaWNo
IGhhcyBOVU1BDQo+IGVuYWJsZWQuDQoNCkxldCBtZSBzZW5kIGFub3RoZXIgcGF0Y2ggd2l0aCB0
aGUgZGV0YWlsIGV4cGxhbmF0aW9uLg0KDQpUaGFua3MNCkhvYW4NCg0KPiANCj4gVGhhbmtzLA0K
PiANCj4gCXRnbHgNCj4gDQo
