From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 21 Jan 2005 22:27:38 +0000
Subject: Re: Sparc32 long long division patch
Message-Id: <20050121142738.34b3cb84.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <41D1D929.8090004@wp.pl>
In-Reply-To: <41D1D929.8090004@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 28 Dec 2004 23:07:37 +0100
Krzysztof Helt <krzysztof.h1@wp.pl> wrote:

> I discovered a bug in multiply/division trap code for sun4m CPUs. This
> bug comes from not quite correct register declaration for inline
> assembly.

Good catch Krzysztof.  I've applied your patch to both 2.4.x and 2.6.x

I think it's still not %100 accurate, and could be cleaned up even
further.  The only reason this code is the way it is, is so that
we can generate calls to the library functions with "." prefixes in
the symbol name which are hard to generate using normal C function
calls.

So the idea I have is to just make stubs with C callable names that
just jump to the real routines.  So we'd have something like this:

1) A set of assembler stubs, such as:

		.globl	sparc_udiv, sparc_sdiv, sparc_umul, sparc_smul
	sparc_udiv:
		ba	.udiv
		 nop
	sparc_sdiv:
		ba	.sdiv
		 nop
	sparc_umul:
		ba	.umul
		 nop
	sparc_smul:
		ba	.mul
		 nop

   Place this somewhere like arch/sparc/lib/muldiv_stubs.S and then
   create a header file include/asm-sparc/muldiv.h that contains the
   necessary extern declaractions for these functions.

2) Make muldiv.c call these stubs.

Then we don't need any of this fancy inline assembler.
