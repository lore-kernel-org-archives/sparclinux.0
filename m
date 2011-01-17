From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Mon, 17 Jan 2011 10:22:41 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <1295259761.32152.20.camel@duncow>
List-Id: <sparclinux.vger.kernel.org>
References: <4D302B2F.7030108@oldelvet.org.uk>
	 <4D3074FE.3030707@oldelvet.org.uk>
	 <20110115.211722.39173519.davem@davemloft.net>
	 <20110116.220755.179947617.davem@davemloft.net>
In-Reply-To: <20110116.220755.179947617.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: richm@oldelvet.org.uk, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, fweisbec@gmail.com, mingo@redhat.com, Jesper.Nilsson@axis.com, jeffm@suse.com

On Sun, 2011-01-16 at 22:07 -0800, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Sat, 15 Jan 2011 21:17:22 -0800 (PST)

> > I think the problem we have here is that the _ftrace_events section is
> > not aligned sufficiently.  That ".align 4" mnemonic is a good indication
> > of this.  It should at least "8" on sparc64.
> 
I noticed another potentially 64 bit unfriendly alignment on struct
tracepoint in include/linux/tracepoint.h. I don't think that the
alignment of 32 breaks anything but it does leave a 24 byte hole. I
don't know enough about tracing to know if that is necessary.

struct tracepoint {
        const char *name;               /* Tracepoint name */
        int state;                      /* State. */
        void (*regfunc)(void);
        void (*unregfunc)(void);
        struct tracepoint_func *funcs;
}  __attribute__((aligned(32)));        /*
                                         * Aligned on 32 bytes because it is
                                         * globally visible and gcc happily
                                         * align these on the structure size.
                                         * Keep in sync with vmlinux.lds.h.
                                         */

Note I spotted this when looking at some residual sparc64 relocation
issues when _ftrace_events alignment is changed to 8. I'll follow those
issues up in a separate email when I get time later today.

Regards

Richard


