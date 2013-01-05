From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 05 Jan 2013 10:36:27 +0000
Subject: Re: [PATCH 1/2] cpuhotplug/nohz: Remove offline cpus from nohz-idle state
Message-Id: <20130105103627.GU2631@n2100.arm.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1357268318-7993-1-git-send-email-vatsa@codeaurora.org>
In-Reply-To: <1357268318-7993-1-git-send-email-vatsa@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Jan 03, 2013 at 06:58:38PM -0800, Srivatsa Vaddagiri wrote:
> I also think that the
> wait_for_completion() based wait in ARM's __cpu_die() can be replaced with a
> busy-loop based one, as the wait there in general should be terminated within
> few cycles.

Why open-code this stuff when we have infrastructure already in the kernel
for waiting for stuff to happen?  I chose to use the standard infrastructure
because its better tested, and avoids having to think about whether we need
CPU barriers and such like to ensure that updates are seen in a timely
manner.

My stance on a lot of this idle/cpu dying code is that much of it can
probably be cleaned up and merged into a single common implementation -
in which case the use of standard infrastructure for things like waiting
for other CPUs do stuff is even more justified.
