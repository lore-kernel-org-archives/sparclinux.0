From: Vince Weaver <vince@deater.net>
Date: Fri, 26 Jan 2007 19:44:44 +0000
Subject: Re: kernel BUG at arch/sparc64/mm/fault.c:413!
Message-Id: <Pine.LNX.4.64.0701261443080.25004@pianoman.cluster.toy>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0701181328230.8124@pianoman.cluster.toy>
In-Reply-To: <Pine.LNX.4.64.0701181328230.8124@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


> Vince, I think I figured out what the bug is, can you test the
> following patch?  If we set %g5 with the fault address here, we have
> to set %g4 too.  This allows to correctly handle a DTLB-PROT trap for
> a window spill during trap entry for another top-level fault.  The
> non-Niagara DTLB-PROT code does this properly, it's just the sun4v
> side that had the bug.

Great news!  This fixes things.  The gcc snapshot has been compiling now 
for over an hour without a problem, wheras before the bug would appear 
within seconds.

Thanks for fixing this,

Vince
