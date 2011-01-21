From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Fri, 21 Jan 2011 19:15:56 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <20110121191556.GB13198@Krystal>
List-Id: <sparclinux.vger.kernel.org>
References: <20110119221327.GA23544@Krystal> <20110119.142137.184823805.davem@davemloft.net> <20110119223339.GD23544@Krystal> <20110119.164107.135521108.davem@davemloft.net> <20110121000421.GA5014@Krystal> <4D39CB0C.8070308@oldelvet.org.uk> <20110121185259.GA13198@Krystal>
In-Reply-To: <20110121185259.GA13198@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Mortimer <richm@oldelvet.org.uk>
Cc: David Miller <davem@davemloft.net>, rostedt@goodmis.org, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@redhat.com

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> * Richard Mortimer (richm@oldelvet.org.uk) wrote:
[...]
> > I'm also getting a lot of Kernel unaligned access errors from the  
> > kernel. I don't know if they are related to this or not and this is the  
> > first time that I personally have got 2.6.37 to boot on sparc64. The  
> > messages that I am getting seem to be repeats of
> >
> > [ 4376.807811] Kernel unaligned access at TPC[456e94]  
> > try_to_wake_up+0x58/0xec
> > [ 4376.807908] Kernel unaligned access at TPC[75541c] schedule+0x454/0x660
> > [ 4376.808044] Kernel unaligned access at TPC[75541c] schedule+0x454/0x660
> > [ 4376.808871] Kernel unaligned access at TPC[456e94]  
> > try_to_wake_up+0x58/0xec
> > [ 4376.808965] Kernel unaligned access at TPC[75541c] schedule+0x454/0x660
> > [ 4381.813354] log_unaligned: 337 callbacks suppressed
> >
> > I have to go out now but will be around later/over the weekend.

OK, I pinpointed it to my use of the "packed" attribute. So within the
structure:

struct test {
        const char *a;
        int b;
        void *c;
        void *d;
        void *e;
} __attribute__((packed, aligned(8)));

(on sparc64)

It provides the following offsets:

0 8 12 20 28

which is clearly wrong in terms of inner alignment: it removes the padding
between b and c. I am really tempted to just remove the "packed" attribute from
there: our goal is really to make sure the 8-byte accesses are all aligned after
all. So theoretically gcc could decide to align all struct test arrays and
pointers on an alignment larger than 8 if we just specify the aligned(8) type
attribute (because the type attribute is just a minimum floor alignment value),
but the only reason I would see for gcc to align these on larger alignment would
be that the structures would contain a field that requires such largish
alignment (which I doubt we have in the kernel).

I'll prepare updated patches shortly.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
