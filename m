From: David Miller <davem@davemloft.net>
Date: Fri, 25 Nov 2016 16:44:35 +0000
Subject: Re: [PATCH] silo: Add 64-bit support
Message-Id: <20161125.114435.595914086857484505.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 24 Nov 2016 23:26:20 +0100

> On 11/24/2016 11:05 PM, Aaro Koskinen wrote:
>> I think that's your job to try. If you want to "add 64-bit support"
>> (instead of forcing it to everybody), do the required changes so that
>> it's still works for everybody without extra fiddling.
> 
> Don't be so rude, I'm not forcing anything onto anyone.
> 
>>>> Also you broke the tilo build...
>>>
>>> Not here. Just tried it again and it builds fine. Can you be more specific?
>> 
>> The same issue as with silo.
> 
> Don't you think your statements are a bit misleading then? I didn't break anything,
> I changed the default target to 64-bit which is somewhat reasonable in the year
> 2016, isn't it.

Not really.

Many people, including myself, are still using predominantly 32-bit
userspace on sparc64 machines.  It is significantly faster, and for
me speed is really important.

So submitting a patch which breaks a common build environment is
really not acceptable.
