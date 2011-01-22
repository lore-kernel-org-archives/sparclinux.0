From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Sat, 22 Jan 2011 18:53:26 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <20110122185326.GA3969@Krystal>
List-Id: <sparclinux.vger.kernel.org>
References: <20110119.142137.184823805.davem@davemloft.net> <20110119223339.GD23544@Krystal> <20110119.164107.135521108.davem@davemloft.net> <20110121000421.GA5014@Krystal> <4D39CB0C.8070308@oldelvet.org.uk> <20110121185259.GA13198@Krystal> <4D39E913.8060104@oldelvet.org.uk> <20110121204033.GA14125@Krystal> <4D3A0DC9.8010101@oldelvet.org.uk> <4D3B2519.6050307@oldelvet.org.uk>
In-Reply-To: <4D3B2519.6050307@oldelvet.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Mortimer <richm@oldelvet.org.uk>
Cc: David Miller <davem@davemloft.net>, rostedt@goodmis.org, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@redhat.com

* Richard Mortimer (richm@oldelvet.org.uk) wrote:
> On 21/01/2011 22:50, Richard Mortimer wrote:
>>
>>
>> On 21/01/2011 20:40, Mathieu Desnoyers wrote:
>>> * Richard Mortimer (richm@oldelvet.org.uk) wrote:
>>>
>>> Thanks for the info! At first glance, it does not seem to contradict my
>>> findings. When you find time, can you have a try at v3 I just posted ?
>>>
>> I'm setting the compilation off now. I will give it a whirl some time
>> Saturday or Sunday.
>>
> ...
>
>>
>>> Make sure to start tracing in your tests, as I think the unaligned
>>> access only
>>> happens when accessing the struct tracepoint fields below the "int
>>> state" field.
>>>
>
> I have the revised patch running now with tracing enabled. Everything  
> looks good to me.

Thanks for testing it!

Mathieu

>
> Thanks.
>
> Richard

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
