From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 15 Jul 2019 18:43:46 +0000
Subject: Re: [PATCH v2 3/5] x86: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
Message-Id: <alpine.DEB.2.21.1907152042110.1767@nanos.tec.linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1562887528-5896-1-git-send-email-Hoan@os.amperecomputing.com>
 <1562887528-5896-4-git-send-email-Hoan@os.amperecomputing.com>
In-Reply-To: <1562887528-5896-4-git-send-email-Hoan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hoan Tran OS <hoan@os.amperecomputing.com>
Cc: Michal Hocko <mhocko@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Open Source Submission <patches@amperecomputing.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will.deacon@arm.com>, Borislav Petkov <bp@alien8.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Oscar Salvador <osalvador@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "David S . Miller" <davem@davemloft.net>

On Thu, 11 Jul 2019, Hoan Tran OS wrote:

> Remove CONFIG_NODES_SPAN_OTHER_NODES as it's enabled
> by default with NUMA.

As I told you before this does not mention that the option is now enabled
even for x86(32bit) configurations which did not enable it before and does
not longer depend on X86_64_ACPI_NUMA.

And there is still no rationale why this makes sense.

Thanks,

	tglx
