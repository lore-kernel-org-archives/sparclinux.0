From: William Lee Irwin III <wli@holomorphy.com>
Date: Sun, 19 Dec 2004 16:55:08 +0000
Subject: Re: [PATCH] Fix for structure declaration error
Message-Id: <20041219165508.GS771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20041219160643.GN32704@artsapartment.org>
In-Reply-To: <20041219160643.GN32704@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Dec 19, 2004 at 10:06:43AM -0600, Art Haas wrote:
> I tried building an SMP kernel for my SS20 last night using the CVS
> version of GCC. The build failed with this error:
> arch/sparc/kernel/time.c:57: error: static declaration of 'mstk48t08_regs' follows non-static declaration
> include/asm/mostek.h:131: error: previous declaration of 'mstk48t08_regs' was here
> The patch below fixed this problem. The SMP kernel itself ultimately did
> not link due to other problems, but as SMP on 32-bit Sparc is still broken,
> I couldn't try and run what I'd built. Building of an SMP kernel was
> just something to try and see if all the files would even compile, as
> was not the case several months ago. BTW, the link error was:
> kernel/built-in.o(.spinlock.text+0x4): In function '_write_trylock':
> ksysfs.c: undefined reference to '_raw_write_trylock'.

I'm aware of this and have pending code for it. I'll send in this
change with the rest of the pending patches. Hopefully I can get them
out today.


-- wli
