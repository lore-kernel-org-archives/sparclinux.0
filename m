From: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Date: Thu, 27 Jun 2019 11:17:58 +0000
Subject: Re: [PATCH 0/5] Enable CONFIG_NODES_SPAN_OTHER_NODES by default for NUMA
Message-Id: <20190627111755.GJ7133@okra.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1561501810-25163-1-git-send-email-Hoan@os.amperecomputing.com>
 <CAADWXX8wdEPNZ26SFJUfwrhQson3HPTrZ7D2jju3RhEeMuc+QQ@mail.gmail.com>
In-Reply-To: <CAADWXX8wdEPNZ26SFJUfwrhQson3HPTrZ7D2jju3RhEeMuc+QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Open Source Submission <patches@amperecomputing.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will.deacon@arm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Hoan Tran OS <hoan@os.amperecomputing.com>, Oscar Salvador <osalvador@suse.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "David S . Miller" <davem@davemloft.net>

On Jun 26 08:28, Linus Torvalds wrote:
> This is not a comment on the patch series itself, it is a comment on the emails.
> 
> Your email is mis-configured and ends up all being marked as spam for
> me, because you go through the wrong smtp server (or maybe your smtp
> server itself is miconfigured)
> 
> All your emails fail dmarc, because the "From" header is
> os.amperecomputing.com, but the DKIM signature is for
> amperemail.onmicrosoft.com.

It appears Microsoft enables DKIM by default, but does so using keys
advertised at *.onmicrosoft.com domains, and our IT folks didn't
initially notice this. We believe we've rectified the situation, so
please let us know if our emails (including this one) continue to be an
issue.

> End result: it wil all go into the spam box of anybody who checks DKIM.

Interestingly, *some* receiving mail servers (at least gmail.com) were
reporting DKIM/DMARC pass for emails sent directly from our domain
(though not those sent through a mailing list), which I believe allowed
our IT to falsely think they had everything configured correctly.

-Aaron
