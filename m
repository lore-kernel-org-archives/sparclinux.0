From: "David S. Miller" <davem@redhat.com>
Date: Tue, 16 Mar 2004 20:58:29 +0000
Subject: Re: REAL_PTRS_PER_PMD and TIF_32BIT
Message-Id: <20040316125829.392df009.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <87llm08qho.fsf@uga.edu>
In-Reply-To: <87llm08qho.fsf@uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 16 Mar 2004 15:51:47 -0500
Ed L Cashin <ecashin@uga.edu> wrote:

> Hi.  As  far as I can tell,  PTRS_PER_PMD will evaluate to  512 when a
> 32-bit binary in userland makes a system call or has a page fault,
> since TIF_32BIT will be set in the thread flags.
> 
> I suppose that means that for every second-level page table associated
> with a 32-bit binary's process, there are (2048 - 512) unused
> pmd entries.  Is that correct?

Yes, on sparc64, this is what effectively happens.  We only need one
PMD to map the page tables for a 32-bit process on sparc64.
