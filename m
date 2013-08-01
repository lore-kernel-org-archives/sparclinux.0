From: Timur Tabi <timur@tabi.org>
Date: Thu, 01 Aug 2013 00:20:29 +0000
Subject: Re: [PATCH 2/2] Convert PowerPC macro spin_event_timeout() to architecture independent macro
Message-Id: <51F9A9CD.1040804@tabi.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1375187900-17582-1-git-send-email-B44344@freescale.com>
 <1375187900-17582-3-git-send-email-B44344@freescale.com>
 <20130731071630.GI8868@codeaurora.org>
 <CAOZdJXVvNBR-qf7LXNOHZVstH_Rebxwn-wAkSaBS53Wn55mYCw@mail.gmail.com>
 <51F9A5FE.8030608@codeaurora.org> <51F9A80E.5010307@tabi.org>
 <51F9A8F1.9020704@codeaurora.org>
In-Reply-To: <51F9A8F1.9020704@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 07/31/2013 07:16 PM, Stephen Boyd wrote:
> cpu_relax() is usually just a compiler barrier or an instruction hint to
> the cpu that it should cool down because we're spinning in a tight loop.
> It certainly shouldn't be calling into the  scheduler.

Ah yes, I remember now.  So it does seem that if we can fix the problem
of non-incrementing 'jiffies', then this macro can be used in interrupts.

Of course, that assumes that spinning in interrupt context is a good
idea to begin with.  Maybe we shouldn't be encouraging it?

>> > FYI, you might want to look at the code reviews for spin_event_timeout()
>> > on the linuxppc-dev mailing list, back in March 2009.
>> >
> Sure. Any pointers? Otherwise I'll go digging around the archives.

https://lists.ozlabs.org/pipermail/linuxppc-dev/2009-March/thread.html

-- 
Timur Tabi
