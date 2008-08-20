From: Meelis Roos <mroos@linux.ee>
Date: Wed, 20 Aug 2008 10:45:13 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <Pine.SOC.4.64.0808201334400.2111@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I got back to this bug now that I had some time.

> > > Should I redo the bisect without restricting to drivers/usb/host?
> > 
> > That would be a good idea.  After all, we have no proof that the lockup 
> > was caused by a change to the USB code.
> 
> Hmph. Complete now but I may have bisected for another bug since most 
> "bad" bisects hung before even showing any USB-related messages - during 
> udev startup with no messages or just after libata startup with no 
> further messages.
> 
> The new results are not promising either - this time it finished with
> [62be1f71677c53d5e51223807a06ac9052f49b0f] [GFS2] fix assertion in log_refund()
> 
> So maybe a timing or layout triggered bug somewhere instead? :(

I reran the full git bisect using gcc-4.2 instead of 4.3 that had became 
default in Debian. This time the bisect gave the following commit as 
culprit:

6e9fc6bd5db34a6580e1917bd0fea4b0754c7de8 is first bad commit
commit 6e9fc6bd5db34a6580e1917bd0fea4b0754c7de8
Author: Daniel Mack <daniel@caiaq.de>
Date:   Mon Apr 14 15:40:31 2008 +0200

    [ALSA] snd_usb_caiaq: make high sample rates work with A8DJ

Seems to be another irrelevant one, so not gcc-4.2 <-> gcc-4.3 
difference (and most of the hangs were again before usb messaged and 
after libata messages).

Tried 2.6.27-rc3 + yesterdays git that works on my Ultra5, still hangs 
in USB startup on V100.

Then I tried the suggestion to instrument ohci_hub_status_data() with 
printks around spin_lock_irqsave() and return. Tried this with git HEAD 
and this time ohci_hub_status_data seemed to be not reached at all, so 
it hangs in USB code in slightly different place than in the original 
trace.

By the way, David - Sysrq-T and Sysrq-P do not seem to work in latest 
git form me for some reason, from serial console. So no new trace.

Will check the kernel debugging options with working U5 config to look 
for any suspicios diffences there.

What should I do next - probably go back to the original revision and 
instrument ohci_hub_status_data() there?

-- 
Meelis Roos (mroos@linux.ee)
