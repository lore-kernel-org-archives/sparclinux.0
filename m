From: Nicholas Piggin <npiggin@gmail.com>
Date: Fri, 19 May 2017 22:53:57 +0000
Subject: Re: [RFC] arch hardlockup detector interfaces improvement
Message-Id: <20170520085357.245c62af@roar.ozlabs.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170518155026.23799-1-npiggin@gmail.com>
        <20170518163028.tf2llimuo4l4l5nv@redhat.com>
        <20170519090731.1e49cd0d@roar.ozlabs.ibm.com>
        <20170519131753.sccuu7mksjertzni@redhat.com>
        <20170520005306.13172dc7@roar.ozlabs.ibm.com>
        <20170519194345.gfwtuprrolk7sgwm@redhat.com>
In-Reply-To: <20170519194345.gfwtuprrolk7sgwm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Don Zickus <dzickus@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net, linux-am33-list@redhat.com, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, uobergfe@redhat.com

On Fri, 19 May 2017 15:43:45 -0400
Don Zickus <dzickus@redhat.com> wrote:

> On Sat, May 20, 2017 at 12:53:06AM +1000, Nicholas Piggin wrote:
> > > I am curious to know what IBM thinks there.  Currently the HARDLOCKUP
> > > detector sits on top of perf.  I get the impression, you are removing that
> > > dependency.  Is that a permanent thing or are you thinking of switching back
> > > and forth depending on if SOFTLOCKUP is enabled or not?  
> > 
> > We want to get away from perf permanently.
> > 
> > The PMU interrupts are not specially non-maskable from a hardware
> > POV, everything gets masked when you turn off interrupts in hardware.
> > powerpc arch code implements a software disable layer, and PMU
> > interrupts are differentiated there by being allowed to run even
> > under local_irq_disable();
> > 
> > We have a few issues with using perf for it. We disable it by
> > default because using it for that breaks another PMU feature.
> > 
> > But PMU interupts are not special, so it would be possible to e.g.,
> > take the timer interrupt before soft disable and have it touch the
> > watchdog if it fires while under local_irq_disable(). That give
> > exact same kind of pseudo-NMI as perf interrupts, without using PMU.
> > 
> > Further, we now want to introduce a local_pmu_disable() type of
> > interface that extends this soft disable layer to perf interrupts
> > as well for some cases. Once we start doing that, more code will
> > be exempt from the hardlockup watchdog, whereas a watchdog specific
> > hook from the timer interrupt would still cover it.  
> 
> Interesting.  Thanks for that info.
> 
> Do you think you can split the patch in half for me?  You are shuffling code
> around and making subtle changes in the shuffled code.  It is hard to double
> check everything.  Namely watchdog_nmi_reconfigure and watchdog_update_cpus
> suddenly appear.
> 
> The first patch would be straight code movement, the second the real
> changes.  I almost don't care if you throw in the LOCKUP->SOFTLOCKUP changes
> in the first patch either.
> 
> I am really interested in the subtle changes to make sure you covered the
> various race conditions that we have uncovered over the years.

Yes that makes sense, I'll do that.

> I also would like to see a sample of the watchdog_nmi_reconfigure() you had
> in mind.  Usually we hide all the nmi stuff underneath the watchdog
> functions.  But those are threaded, which is what you are trying to avoid,
> so the placement of the function makes sense but looks odd.

I'm just calling it after any sysctl changes or suspend/resume etc, and
the lockup detector I have basically just shuts down everything and
then re-starts with the new parameters (could be made much fancier but
I didn't see a need.

I will split out this patch and re-post to you with the powerpc patch in
the series that you can take a look at.

Thanks,
Nick
