From: David Miller <davem@davemloft.net>
Date: Fri, 19 Mar 2010 03:02:05 +0000
Subject: Re: [BUG] percpu misaligned allocation
Message-Id: <20100318.200205.59696640.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100319013119.GB22095@nowhere>
	<20100318.185757.39197211.davem@davemloft.net>
	<4BA2DF0B.9080600@kernel.org>
In-Reply-To: <4BA2DF0B.9080600@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tj@kernel.org
Cc: fweisbec@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>
Date: Fri, 19 Mar 2010 11:18:51 +0900

> On 03/19/2010 10:57 AM, David Miller wrote:
>> I would use u64 so something like:
>> 
>> 	u64 [FTRACE_MAX_PROFILE_SIZE / sizeof(u64)]
> 
> <paranoid>DIV_ROUND_UP() would be safer than division</paranoid>

There's potential real trouble if it isn't a multiple of sizeof(u64)
so better:

	BUILD_BUG_ON(FTRACE_MAX_PROFILE_SIZE % sizeof(u64));

:-)

What a mess, just because this thing can't be typed properly :-/
