From: Ben Collins <bcollins@debian.org>
Date: Wed, 25 May 2005 23:37:42 +0000
Subject: Re: NR_CPUS and kernel 2.4.30 for sparc64
Message-Id: <20050525233742.GA13980@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4294E414.80003@wp.pl>
In-Reply-To: <4294E414.80003@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

That's not the issue. You have to remember that this cpu count is not "the
number of cpu's supported", it's the range of cpu id's supported.

For example, in my e3000, the cpu's are numbers 0,1,6,7,8,9

So I have to set the number of cpu's to atleast 10 so that all six my of
cpu's work.

My suggestion is to set the number of cpu's to 32, always. Changing it
really doesn't give any sort of performance increase or make anything any
simpler. Might use a bit more memory, but the length of the arrays
searched for cpu's will always be just the length of the number of cpu's
you have active (and the extra memory used is negligible anyway).

On Wed, May 25, 2005 at 10:46:12PM +0200, Krzysztof Helt wrote:
> I built a kernel 2.4.30 with SMP and number of cpus set to 2, but This 
> kernel actevated only one cpu. A quick look at the smp.c file 
> (arch/sparc64/kernel/smp.c) revealed a root of this:
> 
> In the smp_boot_cpus() function there are lines:
> 
> 	for (i = 0; i < NR_CPUS; i++) {
> 		if (i = boot_cpu_id)
> 			continue;
> 
> 		if ((cpucount + 1) = max_cpus)
> 			goto ignorecpu;
>            ...
> 
> The first condition eliminates the first cpu from the list of found ones 
> (I assume the first is a boot cpu). The second condition eliminates the 
> last cpu. So on dual smp machine if the first cpu (number 0) is the boot 
> cpu and NR_CPUS is set to 2 no other cpu is found.
> 
> I think the second condition and goto should be removed, but please 
> advice in case I do not understand something with SMP initialization.
> 
> Regards,
> Krzysztof Helt
> 
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
