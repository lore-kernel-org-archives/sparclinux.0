From: Hoan Tran OS <hoan@os.amperecomputing.com>
Date: Tue, 25 Jun 2019 22:30:31 +0000
Subject: [PATCH 4/5] sparc: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
Message-Id: <1561501810-25163-5-git-send-email-Hoan@os.amperecomputing.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1561501810-25163-1-git-send-email-Hoan@os.amperecomputing.com>
In-Reply-To: <1561501810-25163-1-git-send-email-Hoan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Mike Rapoport <rppt@linux.ibm.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, "David S . Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Hoan Tran OS <hoan@os.amperecomputing.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Open Source Submission <patches@amperecomputing.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

VGhpcyBwYXRjaCByZW1vdmVzIENPTkZJR19OT0RFU19TUEFOX09USEVSX05PREVTIGFzIGl0J3MN
CmVuYWJsZWQgYnkgZGVmYXVsdCB3aXRoIE5VTUEuDQoNClNpZ25lZC1vZmYtYnk6IEhvYW4gVHJh
biA8SG9hbkBvcy5hbXBlcmVjb21wdXRpbmcuY29tPg0KLS0tDQogYXJjaC9zcGFyYy9LY29uZmln
IHwgOSAtLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgOSBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL2FyY2gvc3BhcmMvS2NvbmZpZyBiL2FyY2gvc3BhcmMvS2NvbmZpZw0KaW5kZXggMjZh
YjZmNS4uMTM0NDllYSAxMDA2NDQNCi0tLSBhL2FyY2gvc3BhcmMvS2NvbmZpZw0KKysrIGIvYXJj
aC9zcGFyYy9LY29uZmlnDQpAQCAtMjkxLDE1ICsyOTEsNiBAQCBjb25maWcgTk9ERVNfU0hJRlQN
CiAJICBTcGVjaWZ5IHRoZSBtYXhpbXVtIG51bWJlciBvZiBOVU1BIE5vZGVzIGF2YWlsYWJsZSBv
biB0aGUgdGFyZ2V0DQogCSAgc3lzdGVtLiAgSW5jcmVhc2VzIG1lbW9yeSByZXNlcnZlZCB0byBh
Y2NvbW1vZGF0ZSB2YXJpb3VzIHRhYmxlcy4NCiANCi0jIFNvbWUgTlVNQSBub2RlcyBoYXZlIG1l
bW9yeSByYW5nZXMgdGhhdCBzcGFuDQotIyBvdGhlciBub2Rlcy4gIEV2ZW4gdGhvdWdoIGEgcGZu
IGlzIHZhbGlkIGFuZA0KLSMgYmV0d2VlbiBhIG5vZGUncyBzdGFydCBhbmQgZW5kIHBmbnMsIGl0
IG1heSBub3QNCi0jIHJlc2lkZSBvbiB0aGF0IG5vZGUuICBTZWUgbWVtbWFwX2luaXRfem9uZSgp
DQotIyBmb3IgZGV0YWlscy4NCi1jb25maWcgTk9ERVNfU1BBTl9PVEhFUl9OT0RFUw0KLQlkZWZf
Ym9vbCB5DQotCWRlcGVuZHMgb24gTkVFRF9NVUxUSVBMRV9OT0RFUw0KLQ0KIGNvbmZpZyBBUkNI
X1NFTEVDVF9NRU1PUllfTU9ERUwNCiAJZGVmX2Jvb2wgeSBpZiBTUEFSQzY0DQogDQotLSANCjIu
Ny40DQoNCg=
