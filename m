From: Patrick Finnegan <pat@computer-refuge.org>
Date: Mon, 10 Oct 2005 15:09:07 +0000
Subject: Re: Yesterdays git does not boot on U5
Message-Id: <200510101009.07932.pat@computer-refuge.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0510101057330.28936@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0510101057330.28936@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Monday 10 October 2005 02:58, Meelis Roos wrote:
> Hi,
>
> did my daily git sparc64 kernel build on my Ultra 5 and this time it
> does not boot at all. SILO tells
> Allocated 8 Megs of memory at 0x40000000 for kernel
> Uncompressing image...
> Loaded kernel version 2.6.14
>
> Remapping the kernel... done.

If you add "-v" to the kernel parameters, does it say anything more?

Pat
-- 
Purdue University ITAP/RCS        ---  http://www.itap.purdue.edu/rcs/
The Computer Refuge               ---  http://computer-refuge.org
