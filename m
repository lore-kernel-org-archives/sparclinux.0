From: Tejun Heo <tj@kernel.org>
Date: Fri, 19 Mar 2010 02:18:51 +0000
Subject: Re: [BUG] percpu misaligned allocation
Message-Id: <4BA2DF0B.9080600@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4BA1F2BA.30604@kernel.org>	<20100318.175413.183069013.davem@davemloft.net>	<20100319013119.GB22095@nowhere> <20100318.185757.39197211.davem@davemloft.net>
In-Reply-To: <20100318.185757.39197211.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: fweisbec@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/19/2010 10:57 AM, David Miller wrote:
> I would use u64 so something like:
> 
> 	u64 [FTRACE_MAX_PROFILE_SIZE / sizeof(u64)]

<paranoid>DIV_ROUND_UP() would be safer than division</paranoid>

Thanks.

-- 
tejun
