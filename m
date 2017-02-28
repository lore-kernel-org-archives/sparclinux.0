From: David Miller <davem@davemloft.net>
Date: Tue, 28 Feb 2017 15:12:18 +0000
Subject: Re: [PATCH v1 1/3] sparc64: NG4 memset/memcpy 32 bits overflow
Message-Id: <20170228.101218.983689349992464602.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1488293746-965735-1-git-send-email-pasha.tatashin@oracle.com>
	<1488293746-965735-2-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1488293746-965735-2-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: pasha.tatashin@oracle.com
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org

From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 28 Feb 2017 09:55:44 -0500

> @@ -252,19 +248,16 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
>  #ifdef MEMCPY_DEBUG
>  	wr		%g0, 0x80, %asi
>  #endif
> -	srlx		%o2, 31, %g2
> -	cmp		%g2, 0
> -	tne		%XCC, 5
>  	PREAMBLE
>  	mov		%o0, %o3
>  	brz,pn		%o2, .Lexit


This limitation was placed here intentionally, because huge values
are %99 of the time bugs and unintentional.

You will see that every assembler optimized memcpy on sparc64 has
this bug trap, not just NG4.

This is a very useful way to find bugs and length {over,under}flows.
Please do not remove it.

If you have to do 4GB or larger copies, do it in pieces or similar.

Thank you.
