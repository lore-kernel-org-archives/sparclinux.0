From: William Lee Irwin III <wli@holomorphy.com>
Date: Wed, 25 Feb 2004 05:08:11 +0000
Subject: Re: oops in sched_init() on E3000
Message-Id: <20040225050811.GI693@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040222043448.GG703@holomorphy.com>
In-Reply-To: <20040222043448.GG703@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Feb 24, 2004 at 10:09:13PM -0500, Ben Collins wrote:
> I had a feeling this whole problem with the IRQ's was another
> smp_processor_id() issue.
> Dave, the first time that init_irqwork_curcpu() gets called from head.S
> for the boot cpu, smp_processor_id() is returning 0, so the __irq_work
> isn't getting setup properly. Hopefully this is the last issue with
> this.
> The attached patch fixes it. It's in my repo, so you can pull it along
> with the debug rwlock fix I sent you earlier.

This gets 2.6.x-bk-CURRENT booting and running with flying colors here.

Thanks!


-- wli
