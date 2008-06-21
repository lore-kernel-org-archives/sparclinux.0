From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sat, 21 Jun 2008 00:37:15 +0000
Subject: Re: stack overflow on Sparc64
Message-Id: <Pine.LNX.4.64.0806201925400.6353@engineering.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806201819430.25997@engineering.redhat.com>
 <20080620.152847.169209890.davem@davemloft.net>
 <Pine.LNX.4.64.0806201833200.25997@engineering.redhat.com>
 <20080620.154716.75920403.davem@davemloft.net>
In-Reply-To: <20080620.154716.75920403.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, agk@redhat.com

On Fri, 20 Jun 2008, David Miller wrote:

> From: Mikulas Patocka <mpatocka@redhat.com>
> Date: Fri, 20 Jun 2008 18:36:09 -0400 (EDT)
>
>> On Fri, 20 Jun 2008, David Miller wrote:
>>
>>> Yes for debugging and other things it has to stay.
>>
>> If you want it to stay, then it doesn't make sense to make functions
>> tail-call-friendly --- because it should not crash with or without
>> debugging.
>
> On the contrary, of course it makes sense to do so.
>
> When debugging is disabled, the kernel will run faster.
>
> We have to fix the stack usage in either case, but from a
> performance standpoint when debugging is disabled the
> tail-call friendly layout is still highly desirable.

I agree, but performance is different problem than stack overflows.

I put all the patches for this overflow problem here:
http://people.redhat.com/mpatocka/patches/kernel-stack-overflow

Mikulas
