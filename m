From: David Miller <davem@davemloft.net>
Date: Wed, 12 Oct 2011 22:09:45 +0000
Subject: Re: longjmp question
Message-Id: <20111012.180945.345697520182249079.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111007232209.GA11892@wooyd.org>
In-Reply-To: <20111007232209.GA11892@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Wed, 12 Oct 2011 22:22:51 +0100

> 0:
>         xor %fp, %g3, %o0
>         add %fp, 512, %o1
>         andncc %o0, 4095, %o0
>         bne LOC(thread)
>          cmp %o1, %g3
>         bl LOC(thread)
> 
> It looks like this code is *very* old (was added back in 1998, it 
> seems [0]), so I was not able to find any description for it. If you 
> don't mind explaining what's going on here, I would appreciate it.
> 
> [0] http://lwn.net/1998/1022/a/sparc-glibc-patch.html
> 
> Best regards,

This code is seeing if the current stack/frame pointers are on a
different "page" or very far from the stack/frame we are unwinding
into.

The thinking is that if the distance is very large, then the loop is
unlikely to be more efficient, or we are unwinding out-of or into
a different kind of stack (thread stack, process stack, signal stack,
etc.).
