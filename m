From: "David S. Miller" <davem@redhat.com>
Date: Thu, 08 Apr 2004 18:45:26 +0000
Subject: Re: 2.6.5-mc2 switch_to() fix
Message-Id: <20040408114526.5fe0b9f0.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040408122517.GD688@holomorphy.com>
In-Reply-To: <20040408122517.GD688@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 8 Apr 2004 05:25:17 -0700
William Lee Irwin III <wli@holomorphy.com> wrote:

> This patch changes bne,pn to branch to a newly-introduced unconditional
> branch, which may accept larger relocations than the conditional branch.
> The branch delay slot of the converted conditional branch remains
> intact, preserving the semantics where mov %g5, %0 is done
> unconditionally. The annul bit is also set on the unconditional branch,
> which prevents the execution of any instruction that may occur in its
> branch delay slot from ever happening, rendering its position at the
> end of the assembly fragment safe.

This patch looks fine.  But I'm very curious what changed in the -mm
tree which moved the kernel/sched.o object so far away from the link
into the arch/sparc64/kernel/head.o object (which is where the
ret_from_syscall destination symbol is located).

Some Makefile or vmlinux.lds hacking has been taking place?  Actually,
doesn't Rusty's early setup stuff mess with things like that?
