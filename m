From: "David S. Miller" <davem@redhat.com>
Date: Tue, 16 Mar 2004 21:08:53 +0000
Subject: Re: REAL_PTRS_PER_PMD and TIF_32BIT
Message-Id: <20040316130853.2ce57f91.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <87llm08qho.fsf@uga.edu>
In-Reply-To: <87llm08qho.fsf@uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 16 Mar 2004 16:03:23 -0500
Ed L Cashin <ecashin@uga.edu> wrote:

> I notice that in the kernel "pmd" is used to mean both the second
> level page table, consisting of 2048 four-byte entries, and also as
> shorthand for one of those entries.  Did you intentionally use
> all-caps for "PMD" to distinguish it from a second-level page table
> entry?

It's just sylistic for C code that CPP macros are capitalized,
that's all.
