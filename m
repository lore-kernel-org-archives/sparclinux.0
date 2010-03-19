From: Richard Kennedy <richard@rsk.demon.co.uk>
Date: Fri, 19 Mar 2010 15:48:33 +0000
Subject: Re: [BUG] percpu misaligned allocation
Message-Id: <4BA39CD1.8060900@rsk.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20100319013119.GB22095@nowhere>	<20100318.185757.39197211.davem@davemloft.net>	<4BA2DF0B.9080600@kernel.org> <20100318.200205.59696640.davem@davemloft.net>
In-Reply-To: <20100318.200205.59696640.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: tj@kernel.org, fweisbec@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On 19/03/10 03:02, David Miller wrote:
> From: Tejun Heo <tj@kernel.org>
> Date: Fri, 19 Mar 2010 11:18:51 +0900
> 
>> On 03/19/2010 10:57 AM, David Miller wrote:
>>> I would use u64 so something like:
>>>
>>> 	u64 [FTRACE_MAX_PROFILE_SIZE / sizeof(u64)]
>>
>> <paranoid>DIV_ROUND_UP() would be safer than division</paranoid>
> 
> There's potential real trouble if it isn't a multiple of sizeof(u64)
> so better:
> 
> 	BUILD_BUG_ON(FTRACE_MAX_PROFILE_SIZE % sizeof(u64));
> 
> :-)
> 
> What a mess, just because this thing can't be typed properly :-/
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Couldn't you use a union?

For example if you have
union test {
	long t;
	char buffer[50];
};
gcc will then do the right thing.

on x86_64 sizeof(union test) = 56
but on x86_32 it's only 52.

regards
Richard

