From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Fri, 19 Mar 2010 02:30:29 +0000
Subject: Re: [BUG] percpu misaligned allocation
Message-Id: <20100319023027.GD22095@nowhere>
List-Id: <sparclinux.vger.kernel.org>
References: <4BA1F2BA.30604@kernel.org> <20100318.175413.183069013.davem@davemloft.net> <20100319013119.GB22095@nowhere> <20100318.185757.39197211.davem@davemloft.net> <4BA2DF0B.9080600@kernel.org>
In-Reply-To: <4BA2DF0B.9080600@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tejun Heo <tj@kernel.org>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Mar 19, 2010 at 11:18:51AM +0900, Tejun Heo wrote:
> On 03/19/2010 10:57 AM, David Miller wrote:
> > I would use u64 so something like:
> > 
> > 	u64 [FTRACE_MAX_PROFILE_SIZE / sizeof(u64)]
> 
> <paranoid>DIV_ROUND_UP() would be safer than division</paranoid>
> 
> Thanks.


Ok, thanks guys, I'll try this out.

