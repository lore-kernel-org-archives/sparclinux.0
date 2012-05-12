From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 18:45:28 +0000
Subject: Re: [PATCH [0/5] sparc32 patches
Message-Id: <20120512.144528.1392584036362259484.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120512180225.GA30372@merkur.ravnborg.org>
In-Reply-To: <20120512180225.GA30372@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 12 May 2012 20:02:25 +0200

> Random collection of clean-up patches.
> 
> o fix build failue due to warning in floppy.
> o cleanup in floppy glue to please my eyes
> o more btfix drops - and things became much simpler by this
> o drop some unused stuff from the header files
> 
> I considered dropping some sun4c definitions in asi.h -
> but thouth it was better to keep the list complete.
> 
> 	Sam
> 
> Sam Ravnborg (5):
>       sparc32: fix warning in floopy glue
>       sparc32: code cleanup in floppy glue
>       sparc32: drop btfixup for switch_mm
>       sparc32: drop btfixup for check_pgt_cache
>       sparc32: drop unused type/extern

All applied, thanks Sam.
