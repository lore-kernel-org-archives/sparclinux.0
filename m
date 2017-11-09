From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 09 Nov 2017 15:53:23 +0000
Subject: Re: [PATCH v3] sparc: Provide cmpxchg64 for 32-bit builds
Message-Id: <20171109155323.GA19959@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1509979305-11791-1-git-send-email-linux@roeck-us.net>
 <20171109.152852.88103578951782189.davem@davemloft.net>
In-Reply-To: <20171109.152852.88103578951782189.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Nov 09, 2017 at 03:28:52PM +0900, David Miller wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> Date: Mon,  6 Nov 2017 06:41:45 -0800
> 
> > Fix the following build error, seen when building sparc32:allmodconfig.
> > 
> > drivers/net/ethernet/intel/i40e/i40e_ethtool.c:
> > 	In function 'i40e_set_priv_flags':
> > drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4150:2: error:
> > 	implicit declaration of function 'cmpxchg64'
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Guenter, are you really not seeing this commit which has been
> in my sparc GIT tree for a while?
> 
Dave,

At least as of yesterday, the patch had not found its way into mainline.

I am running kernel build tests in my spare time, as community service.
I do spend time before I submit a report or a proposed patch trying to
find if the problem or its fix was already posted, just to avoid the
"you dummy, this was already fixed" type feedback. However, I typically
don't repeat that if it appears that the original report or submission
was ignored. I just don't have the time to do that.

So, no, I did not see the patch in your tree. Sorry for the noise.
I'll refrain from reporting problems on sparc to avoid such noise
in the future. I'll definitely no longer send out reminders.

Guenter
