From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Wed, 19 Jan 2011 15:10:04 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <20110119151004.GA11022@Krystal>
List-Id: <sparclinux.vger.kernel.org>
References: <20110118201323.GA14930@Krystal> <1295382144.12215.123.camel@gandalf.stny.rr.com> <20110119050844.GA8776@Krystal> <20110118.211639.68142725.davem@davemloft.net>
In-Reply-To: <20110118.211639.68142725.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: rostedt@goodmis.org, richm@oldelvet.org.uk, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@redhat.com

* David Miller (davem@davemloft.net) wrote:
> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date: Wed, 19 Jan 2011 00:08:45 -0500
> 
> > The following works fine for me now. Comments are welcome.
> 
> Thanks for doing this work Mathieu.
> 
> > - No aligned() type attribute nor variable attribute. I get a crash on x86_64
> >   (NULL pointer exception when executing __trace_add_event_call, the 5th call).
> >   __alignof__(struct ftrace_event_call) is worth 8.
> 
> This is really bizarre.  Does it only happen on x86_64?

Sadly, my ppc32 test machine is currently broken, so I could not check on other
than x86 archs.

> I'm wondering if GCC does something bizarre like work with different
> default alignments based upon the section or something like that.
> 
> If so, maybe adding the section attribute to the array definition will
> "fix" things?

Well, I thought about it in my sleep, and it looks like gcc is within its rights
to align these statically declared structures on a larger alignment: gcc has no
clue that we're going to do tricks with the linker to access the structures as
an array, so aligning on a larger alignment *should* be fine for the compiler,
but we suffer because we're doing something non-standard.

> 
> > On 32-bit architectures, we really want a aligned(4), and on 64-bit
> > architectures, aligned(8). Represent this by creating:
> > 
> > #define __long_aligned __attribute__((__aligned__(__alignof__(long))))
> 
> Do any of these datastructures have, or will have, "u64" or "long
> long" types in them?  If so, then we will need to use "8"
> unconditionally or "__alignof__(long long)".

If my memory serves me correctly, I think "long long" is aligned on 4 bytes on
ppc32, but on 8 bytes on x86_32 (yeah, that's weird). How about we create a
#define __long_long_aligned __attribute__((__aligned__(__alignof__(long long))))

?

Thanks,

Mathieu

> 
> I'll see if I can work out why using no align directive explodes
> on x86-64.

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
