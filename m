From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 06 Mar 2019 19:30:30 +0000
Subject: Re: [PATCH v5 3/4] mm: Simplify MEMORY_ISOLATION && COMPACTION || CMA into CONTIG_ALLOC
Message-Id: <6a50153b-c68b-f96c-1840-df6b7dd2cc61@suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <20190306190005.7036-1-alex@ghiti.fr>
 <20190306190005.7036-4-alex@ghiti.fr>
In-Reply-To: <20190306190005.7036-4-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Ghiti <alex@ghiti.fr>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org

On 3/6/19 8:00 PM, Alexandre Ghiti wrote:
> This condition allows to define alloc_contig_range, so simplify
> it into a more accurate naming.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

(you could have sent this with my ack from v4 as there wasn't
significant change, just the one I suggested :)
