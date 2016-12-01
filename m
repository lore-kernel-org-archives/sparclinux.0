From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 01 Dec 2016 12:50:40 +0000
Subject: Re: next: Commit 'mm: Prevent __alloc_pages_nodemask() RCU CPU stall ...' causing hang on sparc32 qe
Message-Id: <d489c061-00ff-2b1c-cf96-c4cf1bb7b2b6@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20161130012817.GH3924@linux.vnet.ibm.com>
 <b96c1560-3f06-bb6d-717a-7a0f0c6e869a@roeck-us.net>
 <20161130070212.GM3924@linux.vnet.ibm.com>
 <929f6b29-461a-6e94-fcfd-710c3da789e9@roeck-us.net>
 <20161130120333.GQ3924@linux.vnet.ibm.com>
 <20161130192159.GB22216@roeck-us.net>
 <20161130210152.GL3924@linux.vnet.ibm.com>
 <20161130231846.GB17244@roeck-us.net>
 <20161201011950.GX3924@linux.vnet.ibm.com>
 <20161201065657.GA4697@roeck-us.net>
 <20161201123409.GA3924@linux.vnet.ibm.com>
In-Reply-To: <20161201123409.GA3924@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: paulmck@linux.vnet.ibm.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org, davem@davemloft.net

On 12/01/2016 04:34 AM, Paul E. McKenney wrote:
> On Wed, Nov 30, 2016 at 10:56:57PM -0800, Guenter Roeck wrote:
>> Hi Paul,
>>
>> On Wed, Nov 30, 2016 at 05:19:50PM -0800, Paul E. McKenney wrote:
>> [ ... ]
>>
>>>>>>
>>>>>> BUG: sleeping function called from invalid context at mm/page_alloc.c:3775
>> [ ... ]
>>>
>>> Whew!  You had me going for a bit there.  ;-)
>>
>> Bisect results are here ... the culprit is, again, commit 2d66cccd73 ("mm:
>> Prevent __alloc_pages_nodemask() RCU CPU stall warnings"), and reverting that
>> patch fixes the problem. Good that you dropped it already :-).
>
> "My work is done."  ;-)
>
> And apologies for the hassle.  I have no idea what I was thinking when
> I put the cond_resched_rcu_qs() there!
>

No worries.

Cheers,
Guenter

