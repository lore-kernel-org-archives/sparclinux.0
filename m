From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Mon, 14 Dec 2015 10:28:47 +0000
Subject: Re: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and make it configurable
Message-Id: <566E99DF.6050008@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <1449667265-17525-5-git-send-email-pmladek@suse.com>
 <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
 <20151211124159.GB3729@pathway.suse.cz>
 <20151211145725.b0e81bb4bb18fcd72ef5f557@linux-foundation.org>
 <20151211232113.GZ8644@n2100.arm.linux.org.uk>
In-Reply-To: <20151211232113.GZ8644@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 11/12/15 23:21, Russell King - ARM Linux wrote:
> As I explained when I did that work, the vast majority of ARM platforms
> are unable to trigger anything like a NMI - the FIQ is something that's
> generally a property of the secure monitor, and is not accessible to
> Linux.  However, there are platforms where it is accessible.
>
> The work to add the FIQ-based variant never happened (I've no idea what
> happened to that part, Daniel seems to have lost interest in working on
> it.)  So, what we have is the IRQ-based variant merged in mainline, which
> would be the fallback for the "FIQ not available" cases, and I carry a
> local hack in my tree which provides the FIQ-based version - but if it
> were to trigger, it takes out all interrupts (hence why I've not merged
> my hack.)
>
> I think the reason that the FIQ-based variant has never really happened
> is that hooking into the interrupt controller code to clear down the FIQ
> creates such a horrid layering violation, and also a locking mess that
> I suspect it's just been given up with.

I haven't quite given up; I'm still looking into this stuff. However 
you're certainly right that connecting the FIQ handler to the GIC code 
in an elegant way is tough.

I've been working in parallel on an arm64 implementation with the result 
that I'm now two lumps of code that are almost, but not quite, ready.

Right now I hope to share latest arm code fairly late in the this 
devcycle (for review rather than merge) followed up with a new version 
very early in v4.6. Even now I think the code needs a long soak in -next 
just in case there are any lurking regressions on particular platforms.

I don't expect anyone to base decisions on my aspirations above but 
would like to reassure Russell that I haven't given up on it.


Daniel.
