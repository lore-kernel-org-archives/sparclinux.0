From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Tue, 08 Jan 2013 06:58:07 +0000
Subject: Re: [PATCH 1/2] cpuhotplug/nohz: Remove offline cpus from nohz-idle state
Message-Id: <50EBC2F9.70303@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1357268318-7993-1-git-send-email-vatsa@codeaurora.org>
 <20130105103627.GU2631@n2100.arm.linux.org.uk>
In-Reply-To: <20130105103627.GU2631@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 01/05/2013 04:06 PM, Russell King - ARM Linux wrote:
> On Thu, Jan 03, 2013 at 06:58:38PM -0800, Srivatsa Vaddagiri wrote:
>> I also think that the
>> wait_for_completion() based wait in ARM's __cpu_die() can be replaced with a
>> busy-loop based one, as the wait there in general should be terminated within
>> few cycles.
> 
> Why open-code this stuff when we have infrastructure already in the kernel
> for waiting for stuff to happen?  I chose to use the standard infrastructure
> because its better tested, and avoids having to think about whether we need
> CPU barriers and such like to ensure that updates are seen in a timely
> manner.
> 
> My stance on a lot of this idle/cpu dying code is that much of it can
> probably be cleaned up and merged into a single common implementation -
> in which case the use of standard infrastructure for things like waiting
> for other CPUs do stuff is even more justified.

On similar lines, Nikunj (in CC) and I had posted a patchset sometime ago to
consolidate some of the CPU hotplug related code in the various architectures
into a common standard implementation [1].

However, we ended up hitting a problem with Xen, because its existing code
was unlike the other arch/ pieces [2]. At that time, we decided that we will
first make the CPU online and offline paths symmetric in the generic code and
then provide a common implementation of the duplicated bits in arch/, for the
new CPU hotplug model [3].

I guess we should probably revisit it sometime, consolidating the code in
incremental steps if not all at a time...

--
[1]. http://lwn.net/Articles/500185/
[2]. http://thread.gmane.org/gmane.linux.kernel.cross-arch/14342/focus430
[3]. http://thread.gmane.org/gmane.linux.kernel.cross-arch/14342/focus567

Regards,
Srivatsa S. Bhat

