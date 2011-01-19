From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Wed, 19 Jan 2011 15:27:17 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <4D3702D5.5050502@oldelvet.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1295273486.16479.15.camel@gandalf.stny.rr.com>	<20110117.213448.226787087.davem@davemloft.net>	<20110117.220039.71097651.davem@davemloft.net> <20110117.220857.104046847.davem@davemloft.net>
In-Reply-To: <20110117.220857.104046847.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: rostedt@goodmis.org, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@redhat.com, mathieu.desnoyers@efficios.com



On 18/01/2011 06:08, David Miller wrote:
> From: David Miller<davem@davemloft.net>
> Date: Mon, 17 Jan 2011 22:00:39 -0800 (PST)
>
>> ftrace: Remove unnecessary alignment tag from ftrace_event_call.
>>
>> It's completely unnecessary and causes problems on platforms
>> where this tag down-aligns the structure's alignment.
>>
>> Signed-off-by: David S. Miller<davem@davemloft.net>
>   ...
>
> Ok, unless we can explain why these alignments are needed at all, we
> should kill all of them:
>
> --------------------
> tracing: Remove unnecessary __aligned__(4) tag from trace data.
>
> It's completely unnecessary and causes problems on platforms
> where this tag down-aligns the structure's alignment.
>
> Signed-off-by: David S. Miller<davem@davemloft.net>
>

For reference my build with the above patch completed last night. That 
does boot on my sparc64 Sun Fire V120 so at the very least the 
relocation issues go away.

The machine wasn't very happy and networking/nfs was a little upset but 
I'll wait until the patchset is more refined before investigating 
further and trying to work out if it is related or not.

Regards

Richard
