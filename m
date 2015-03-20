From: David Ahern <david.ahern@oracle.com>
Date: Fri, 20 Mar 2015 02:17:37 +0000
Subject: Re: [PATCH] sparc: perf: Remove redundant perf_pmu_{en|dis}able calls
Message-Id: <550B8341.2030304@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1426795557-135648-1-git-send-email-david.ahern@oracle.com>
In-Reply-To: <1426795557-135648-1-git-send-email-david.ahern@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 3/19/15 7:55 PM, David Miller wrote:
> I wonder why I coded it this way, maybe long ago in the past
> the caller didn't do this.

short answer: I know 2.6.39 does not need this, so it changed somewhere 
between 2.6.39 and 3.18.

 From what I can tell you used the x86 perf code as the template for 
sparc. That was roughly 2009 or 2010. The x86 code has changed a lot 
over the years; the sparc code not so much.


