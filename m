From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Mon, 30 Apr 2007 21:36:27 +0000
Subject: Re: vm changes from linux-2.6.14 to linux-2.6.15
Message-Id: <Pine.LNX.4.61.0704302159140.3178@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0704291345480.690@mtfhpc.demon.co.uk>
	<1177852457.4390.26.camel@localhost.localdomain>
In-Reply-To: <1177852457.4390.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrea Arcangeli <andrea@suse.de>, wli@holomorphy.com, akpm@osdl.org
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org

Hi all,

I have tracked down a failure to successfully load/run the init task on my 
Sparcstation 1 clone (SS1) and Sparcstation 2 (SS2), sparc32 sun4c 
systems, to a patch:

   commit 1a44e149084d772a1bcf4cdbdde8a013a8a1cfde.
   [PATCH] .text page fault SMP scalability optimization

Removing this patch fixes the issue and allows me to use kernels later 
than v2.5.14. (tested using linux-2.6.20.9).

Given the comment provided by the git bisect, backing out this patch will 
probably have undesirable conseqnences for other platforms (especially 
powerpc64) so, if an architecture independent solution is not available, 
some/all of the code in handle_pte_fault() in mm/memory.c will need be to 
made architecture dependent.

I am not sufficiently familear with the how the SS1/SS2 mmu works and how 
the linux memory management system works to understand why this patch 
prevents my sun4c SS1/SS2 systems from working.

Advice and help on the approch to take and any code changes regarding this 
issue would be most welcome.

Regards
 	Mark Fortescue.

On Sun, 29 Apr 2007, Tom "spot" Callaway wrote:

> On Sun, 2007-04-29 at 14:02 +0100, Mark Fortescue wrote:
>> Hi,
>>
>> Does any one have or know of a good reference that would help me in
>> identifing the cause of a CPU soft lockup that apears to be related to
>> changes in the vertual memory handling between these two versions of the
>> kernel?
>
> Have you tried git bisecting between the two kernels to find the
> specific patch that breaks?
>
> ~spot
>
>
