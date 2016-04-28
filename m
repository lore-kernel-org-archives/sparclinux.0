From: David Miller <davem@davemloft.net>
Date: Thu, 28 Apr 2016 21:46:53 +0000
Subject: Re: [patch V3] lib: GCD: add binary GCD algorithm
Message-Id: <20160428.174653.607032263739732285.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
In-Reply-To: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "George Spelvin" <linux@horizon.com>
Date: 28 Apr 2016 17:21:26 -0400

> arch/sparc/lib/ffs.S is a custom implementation of __ffs, but it's a
> function call and 33 instructions/18 cycles long.  There are several
> similar custom implementations that I also considered "NO".

Read it again, it is patched if the cpu supports the necessary instructions
in which case it's a very short sequence.

The actual code used when the cpu support said instruction is simply:

	.section	.popc_6insn_patch, "ax"
	.word		ffs
	brz,pn	%o0, 98f
	 neg	%o0, %g1
	xnor	%o0, %g1, %o1
	popc	%o1, %o0
98:	retl
	 nop
	.word		__ffs
	neg	%o0, %g1
	xnor	%o0, %g1, %o1
	popc	%o1, %o0
	retl
	 sub	%o0, 1, %o0
	nop
	.previous
