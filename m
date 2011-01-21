From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Fri, 21 Jan 2011 22:50:49 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <4D3A0DC9.8010101@oldelvet.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20110119221327.GA23544@Krystal> <20110119.142137.184823805.davem@davemloft.net> <20110119223339.GD23544@Krystal> <20110119.164107.135521108.davem@davemloft.net> <20110121000421.GA5014@Krystal> <4D39CB0C.8070308@oldelvet.org.uk> <20110121185259.GA13198@Krystal> <4D39E913.8060104@oldelvet.org.uk> <20110121204033.GA14125@Krystal>
In-Reply-To: <20110121204033.GA14125@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: David Miller <davem@davemloft.net>, rostedt@goodmis.org, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@redhat.com



On 21/01/2011 20:40, Mathieu Desnoyers wrote:
> * Richard Mortimer (richm@oldelvet.org.uk) wrote:
> [...]
>> P.S. I saw your followup mail so hopefully this matches what you have found!
>
> Thanks for the info! At first glance, it does not seem to contradict my
> findings. When you find time, can you have a try at v3 I just posted ?
>
I'm setting the compilation off now. I will give it a whirl some time 
Saturday or Sunday.

Before I did that I created kernel/sched.s and have verified that the 
two error locations are accesses to it_func_ptr as you suspected.


ldx     [%g1+%lo(__tracepoint_sched_wakeup)+28], %l0    !, it_func_ptr
and
ldx     [%g3], %l2      !, it_func_ptr

with v3 of you patches applied it uses +32 to get the offset of 
it_func_ptr so that looks good.

> Make sure to start tracing in your tests, as I think the unaligned access only
> happens when accessing the struct tracepoint fields below the "int state" field.
>
Will do.

Regards

Richard
