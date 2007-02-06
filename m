From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 06 Feb 2007 19:41:31 +0000
Subject: Re: [Bugme-new] [Bug 7948] New: Regular floppy driver on Sparc32
Message-Id: <20070206114131.dc651a90.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 6 Feb 2007 07:43:48 -0800
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?idy48
> 
>            Summary: Regular floppy driver on Sparc32 (SS20)
>     Kernel Version: 2.6.20
>             Status: NEW
>           Severity: normal
>              Owner: drivers_other@kernel-bugs.osdl.org
>          Submitter: mt1@systella.fr
> 
> 
> Most recent kernel where this bug did *NOT* occur:
> Distribution: debian/testing
> Hardware Environment: SparcSTATION 20 SMP
> Software Environment:
> Problem Description: kernel hangs on boot
> 
> Steps to reproduce:
> Buid a 2.6.20 kernel with sparc floppy support. Boot stops after floppy
> initialization (FDC is...). The last kernel that boots with floppy support is
> the 2.9.19.1. It is imposible to build module for this driver because link
> stage of kernel build hangs with "floppy hardint error".
> 
