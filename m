From: David Miller <davem@davemloft.net>
Date: Fri, 17 Aug 2007 06:47:09 +0000
Subject: Re: 'Illegal instruction' on taking a trap on UltrasparcIII
Message-Id: <20070816.234709.11626446.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070812102952.GA5008@droopy.oc.cox.net>
In-Reply-To: <20070812102952.GA5008@droopy.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 12 Aug 2007 11:29:53 +0100

> #if defined(sparc) || defined(__sparc__)
> static inline void
> flush_register_windows(void)
> {
>     asm
> #ifdef __GNUC__
>         volatile
> #endif
> # if defined(__sparc_v9__) || defined(__sparcv9) || 
> defined(__arch64__)
>         ("flushw")
> # elif defined(linux) || defined(__linux__)
>         ("ta  0x83")
> # else /* Solaris, OpenBSD, NetBSD, etc. */
>         ("ta  0x03")
> # endif /* trap always to flush register windows if we are on a Sparc 
> system */
>         ;
> }
> #  define FLUSH_REGISTER_WINDOWS flush_register_windows()

This code is buggy, it should use "ta 0x03" on Linux as well
as the BSD's and Solaris.

"ta 0x83" is a hypervisor trap on Niagara that loads a TLB
entry for supervisor code :-)
