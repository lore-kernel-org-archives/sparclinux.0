From: Stephen Boyd <sboyd@codeaurora.org>
Date: Thu, 01 Aug 2013 00:04:14 +0000
Subject: Re: [PATCH 2/2] Convert PowerPC macro spin_event_timeout() to architecture independent macro
Message-Id: <51F9A5FE.8030608@codeaurora.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1375187900-17582-1-git-send-email-B44344@freescale.com>
 <1375187900-17582-3-git-send-email-B44344@freescale.com>
 <20130731071630.GI8868@codeaurora.org>
 <CAOZdJXVvNBR-qf7LXNOHZVstH_Rebxwn-wAkSaBS53Wn55mYCw@mail.gmail.com>
In-Reply-To: <CAOZdJXVvNBR-qf7LXNOHZVstH_Rebxwn-wAkSaBS53Wn55mYCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 07/31/13 16:44, Timur Tabi wrote:
> On Wed, Jul 31, 2013 at 2:16 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> What do you do here if jiffies aren't incrementing (i.e
>> interrupts are disabled). The time_before() check won't work
>> there and it would be nice if we were able to use this in such
>> situations. I think powerpc gets around this by reading the
>> hardware timer directly?
> I believe that jiffies is always a global variable.  It should behave
> the same on PowerPC as on other architectures.

Yes it's global but it doesn't increment while interrupts are off.

>
> The answer to your question is that you should not use
> spin_event_timeout() in interrupt context, because it yields.
>

If it yields why are we using udelay? Why not usleep_range()? It would
be useful to have a variant that worked in interrupt context and it
looked like that was almost possible.

BTW, couldn't we skip the first patch and just use usecs_to_jiffies()?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

