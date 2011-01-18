From: David Miller <davem@davemloft.net>
Date: Tue, 18 Jan 2011 06:27:24 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <20110117.222724.112609854.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110115.211722.39173519.davem@davemloft.net>
	<20110116.220755.179947617.davem@davemloft.net>
	<20110117143954.GA17813@pcpool00.mathematik.uni-freiburg.de>
In-Reply-To: <20110117143954.GA17813@pcpool00.mathematik.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: brl+ccmadness@pcpool00.mathematik.uni-freiburg.de
Cc: richm@oldelvet.org.uk, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, fweisbec@gmail.com, mingo@redhat.com, Jesper.Nilsson@axis.com, jeffm@suse.com

From: "Bernhard R. Link" <brl+ccmadness@pcpool00.mathematik.uni-freiburg.de>
Date: Mon, 17 Jan 2011 15:39:54 +0100

>> I think we want none of this, and I think we should elide the align
>> directives entirely, or at least fix them so we don't get unaligned
>> stuff on 64-bit.
> 
> One fix might be to move the __attribute__ from include/trace/ftrace.h
> (and from include/linux/syscalls.h) to include/linux/ftrace_event.h
> and attach it to the struct there. This way it should only increase it.

I'm beginning to think that the align directive is there purposely to
down-align the structure so that the amount of space that tracing
information consumes is minimized.

I honestly can't tell, only Steven Rostedt can tell us for sure,
because there are no commit messages or comments that explain why
these things need to be there.

If the align directives exist for that reason, then your suggestion
would likely completely undo what these directives are trying to
achieve.

Someone mentioned that the default struct alignment on x86-64 is
something rather rediculious like 32 bytes or something like that.
Yet someone else suggested to use __aligned__(32) to fix this, so
color me completely confused.

