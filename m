From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Sun, 21 Mar 2004 17:53:11 +0000
Subject: Re: srmmu_nocache_calcsize with low memory
Message-Id: <20040321175311.GA16003@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040321155052.GA10374@spike>
In-Reply-To: <20040321155052.GA10374@spike>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Mar 21, 2004 at 04:50:52PM +0100, Stefan Holst wrote:

>  /* P3 XXX The 4x overuse: corroborated by /proc/meminfo. */
> 	// if (srmmu_nocache_npages < 256) srmmu_nocache_npages = 256;
> 	if (srmmu_nocache_npages < SRMMU_MIN_NOCACHE_PAGES)
> 		srmmu_nocache_npages = SRMMU_MIN_NOCACHE_PAGES;
> 
> i didn't really understand the comment - what is the matter with that?

At one time 2.6 used 4 times as much nocache memory as 2.4 did.  It
also had fragmentation problems and appeared to leak nocache until it
finally ran out.  I believe I fixed most of this a few releases ago
with the srmmu changes and the fix to fault handling (to copy the
entire pmd instead of only one entry, which would cause more and more
pmds to be allocated).  I no longer see more than about 1.1MB of
nocache used even when building glibc on a 512MB system.
Fragmentation probably still is an issue.

Therefore this comment can probably be removed; I'm just waiting to
see if anyone still reports problems.

> after deactivating this minimum enforcement, my 4mb-system doesn't work
> either; the calculated value (16) seems to be much too low. i did some
> testing and found, that the system starts fine from a value around 27:

27 would seem to be a reasonable finding for the minimum needed to
boot.  The actual number you'll need depends mostly on the number of
processes you run and how large they are.

> srmmu_nocache_calcsize should be fixed for low memory. but how? any
> suggestions?

Perhaps you should just lower the minimum to 128 pages.  This stuff's
mostly guesswork and observation anyway.  I really don't think 27 is
enough unless you only want to run init and don't want it to do
anything (ie a box that just sets up netfilter and then essentially
has no userland).

-- 
Keith M Wesolowski
