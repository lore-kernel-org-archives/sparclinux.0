From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 06 Nov 2012 22:38:19 +0000
Subject: Re: [PATCH 07/16] mm: fix cache coloring on x86_64 architecture
Message-Id: <20121106143819.4309031c.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1352155633-8648-1-git-send-email-walken@google.com>
 <1352155633-8648-8-git-send-email-walken@google.com>
In-Reply-To: <1352155633-8648-8-git-send-email-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon,  5 Nov 2012 14:47:04 -0800
Michel Lespinasse <walken@google.com> wrote:

> Fix the x86-64 cache alignment code to take pgoff into account.
> Use the x86 and MIPS cache alignment code as the basis for a generic
> cache alignment function.
> 
> The old x86 code will always align the mmap to aliasing boundaries,
> even if the program mmaps the file with a non-zero pgoff.
> 
> If program A mmaps the file with pgoff 0, and program B mmaps the
> file with pgoff 1. The old code would align the mmaps, resulting in
> misaligned pages:
> 
> A:  0123
> B:  123
> 
> After this patch, they are aligned so the pages line up:
> 
> A: 0123
> B:  123

We have a bit of a history of fiddling with coloring and finding that
the changes made at best no improvement.  Or at least, that's my
perhaps faulty memory of it.

This one needs pretty careful testing, please.
