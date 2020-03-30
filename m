From: Michal Hocko <mhocko@kernel.org>
Date: Mon, 30 Mar 2020 07:44:26 +0000
Subject: Re: [PATCH v3 0/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by default for NUMA
Message-Id: <20200330074426.GB14243@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
 <20200329001924.GS3039@MiWiFi-R3L-srv>
In-Reply-To: <20200329001924.GS3039@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Baoquan He <bhe@redhat.com>
Cc: mmorana@amperecomputing.com, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Hoan Tran <Hoan@os.amperecomputing.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Pavel Tatashin <pavel.tatashin@microsoft.com>, lho@amperecomputing.com, Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will.deacon@arm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Sun 29-03-20 08:19:24, Baoquan He wrote:
> On 03/28/20 at 11:31am, Hoan Tran wrote:
> > In NUMA layout which nodes have memory ranges that span across other nodes,
> > the mm driver can detect the memory node id incorrectly.
> > 
> > For example, with layout below
> > Node 0 address: 0000 xxxx 0000 xxxx
> > Node 1 address: xxxx 1111 xxxx 1111
> 
> Sorry, I read this example several times, but still don't get what it
> means. Can it be given with real hex number address as an exmaple? I
> mean just using the memory layout you have seen from some systems. The
> change looks interesting though.

Does this make it more clear?
           physical address range and its node associaion
         [0 0 0 0 1 1 1 1 0 0 0 0 1 1 1 1 0 0 0 0 1 1 1 1]
-- 
Michal Hocko
SUSE Labs
