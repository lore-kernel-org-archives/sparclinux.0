From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Date: Fri, 05 Jan 2007 00:25:25 +0000
Subject: Re: 2.6.20-rc3: known unfixed regressions (v3)
Message-Id: <200701050025.l050PPWt007260@laptop13.inf.utfsm.cl>
List-Id: <sparclinux.vger.kernel.org>
In-Reply-To: Message from Adrian Bunk <bunk@stusta.de> 
   of "Thu, 04 Jan 2007 18:46:32 BST." <20070104174632.GC20714@stusta.de> 
References: <20070103205945.GK20714@stusta.de>
In-Reply-To: <20070103205945.GK20714@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
> This email lists some known regressions in 2.6.20-rc3 compared to 2.6.19
> that are not yet fixed in Linus' tree.
> 
> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you caused a breakage or I'm considering you in any other way possibly
> involved with one or more of these issues.
> 
> Due to the huge amount of recipients, please trim the Cc when answering.

[...]

> Subject    : SPARC64: Can't mount /  (CONFIG_SCSI_SCAN_ASYNC=y ?)
> References : http://lkml.org/lkml/2006/12/13/181
>              http://lkml.org/lkml/2007/01/04/75
> Submitter  : Horst H. von Brand <vonbrand@inf.utfsm.cl>
> Status     : unknown

Fixed in 2.6.20-rc3 (perhaps was due to SCSI_SCAN_ASYNC)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
