From: David Miller <davem@davemloft.net>
Date: Tue, 01 Sep 2009 22:52:59 +0000
Subject: Re: [PATCH] percpu: don't assume existence of cpu0
Message-Id: <20090901.155259.120906603.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4A9CD41C.8060604@kernel.org>
	<Pine.SOC.4.64.0909011437270.20321@math.ut.ee>
	<4A9D13F0.7010504@kernel.org>
In-Reply-To: <4A9D13F0.7010504@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tj@kernel.org
Cc: mroos@linux.ee, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>
Date: Tue, 01 Sep 2009 21:30:40 +0900

> Meelis Roos wrote:
>>> Aha...  Does the following patch fix the problem?
>> 
>> Yes, yesterdays 2.6.31-rc8-git plus this patch seems to work fine, no 
>> warnings/oopses/panics. It is happily churning on debian unstable 
>> upgrade now.
> 
> Good to hear.  Will forward to Linus right away.  Thanks.

Thanks a lot for fixing this so quickly Tejun.
