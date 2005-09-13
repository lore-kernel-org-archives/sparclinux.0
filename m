From: Kaj-Michael Lang <milang@tal.org>
Date: Tue, 13 Sep 2005 19:28:06 +0000
Subject: Re: sparc32 kernel compilation problem with latest binutils
Message-Id: <Pine.LNX.4.61.0509132227250.29416@tori.tal.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0509100228130.10415@tori.tal.org>
In-Reply-To: <Pine.LNX.4.61.0509100228130.10415@tori.tal.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 10 Sep 2005, Kaj-Michael Lang wrote:

> I'm trying to compile 2.6.13, but it fails with:
>
>  CC      arch/sparc/kernel/sparc_ksyms.o
> {standard input}: Assembler messages:
> {standard input}:1737: Error: Local symbol `udiv' can't be equated to

Ah, 2.6.14-rc1 seems to have this fixed. Compiling now. Thanks.

-- 
Kaj-Michael Lang
