From: David Miller <davem@davemloft.net>
Date: Wed, 12 Aug 2009 23:25:17 +0000
Subject: Re: [PATCH 2/2 2.6.31-rc5 REPOST] percpu, sparc64: fix sparse
Message-Id: <20090812.162517.13032565.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090806115705.GB10734@elte.hu>
	<4A7B01B8.8000902@kernel.org>
	<4A825CD5.3060209@kernel.org>
In-Reply-To: <4A825CD5.3060209@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tj@kernel.org
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Tejun Heo <tj@kernel.org>
Date: Wed, 12 Aug 2009 15:10:29 +0900

> Tejun Heo wrote:
>> Ingo Molnar wrote:
>>> for the x86 bits:
>>>
>>>  Acked-by: Ingo Molnar <mingo@elte.hu>
>>>
>>> Once Dave acks it i suspect you can send it to Linus directly?
> 
> Aieeeee, no response.

These patches look fine, and I've tested them also on my
Niagara-2 box.

Acked-by: David S. Miller <davem@davemloft.net>

Sorry for the delay :)
