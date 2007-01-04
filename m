From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Date: Thu, 04 Jan 2007 13:23:13 +0000
Subject: Re: 2.6.20-rc3: known unfixed regressions (v2)
Message-Id: <200701041323.l04DNDgs007854@laptop13.inf.utfsm.cl>
List-Id: <sparclinux.vger.kernel.org>
In-Reply-To: Message from Adrian Bunk <bunk@stusta.de> 
   of "Wed, 03 Jan 2007 21:59:45 BST." <20070103205945.GK20714@stusta.de> 
References: <20070103205945.GK20714@stusta.de>
In-Reply-To: <20070103205945.GK20714@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, davem@davemloft.net

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

I hope I cut it down sensibly...

[...]

> Subject    : SPARC64: Can't mount /
> References : http://lkml.org/lkml/2006/12/13/181
> Submitter  : Horst H. von Brand <vonbrand@inf.utfsm.cl>
> Status     : unknown

Works for me now with 2.6.20-rc3. Might have been some form of pilot error
(perhaps setting SCSI_TGT=m and/or SCSI_SCAN_ASYNC=y, I unset them for the
current trial run).

I see CONFIG_SCSI_SCAN_ASYNC introduced in
21db1882f79a1ad5977cae6766376a63f60ec414 ([SCSI] Add Kconfig option for
asynchronous SCSI scanning). If this is the cause, the override provided:

  scsi_mod.scan="sync"

seems not to work. Are the '"' necessary? How do you give them via silo,
which in its configuration file for strings with spaces uses:

  append="some string here"

How do you say '"'? The silo documentation is silent on this.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
