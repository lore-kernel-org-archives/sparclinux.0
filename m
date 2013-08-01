From: Timur Tabi <timur@tabi.org>
Date: Thu, 01 Aug 2013 00:13:02 +0000
Subject: Re: [PATCH 2/2] Convert PowerPC macro spin_event_timeout() to architecture independent macro
Message-Id: <51F9A80E.5010307@tabi.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1375187900-17582-1-git-send-email-B44344@freescale.com>
 <1375187900-17582-3-git-send-email-B44344@freescale.com>
 <20130731071630.GI8868@codeaurora.org>
 <CAOZdJXVvNBR-qf7LXNOHZVstH_Rebxwn-wAkSaBS53Wn55mYCw@mail.gmail.com>
 <51F9A5FE.8030608@codeaurora.org>
In-Reply-To: <51F9A5FE.8030608@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 07/31/2013 07:04 PM, Stephen Boyd wrote:
> If it yields why are we using udelay? Why not usleep_range()? It would
> be useful to have a variant that worked in interrupt context and it
> looked like that was almost possible.

I've never heard of usleep_range() before, so I don't know if it
applies.  Apparently, udelay() includes its own call to cpu_relax().  Is
it possible that cpu_relax() is a "lightweight" yield, compared to sleeping?

FYI, you might want to look at the code reviews for spin_event_timeout()
on the linuxppc-dev mailing list, back in March 2009.

-- 
-- 
Timur Tabi
