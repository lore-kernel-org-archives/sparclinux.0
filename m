From: David Miller <davem@davemloft.net>
Date: Thu, 23 Feb 2012 23:31:45 +0000
Subject: Re: OF-related boot crash in 3.3.0-rc3-00188-g3ec1e88
Message-Id: <20120223.183145.519627082998533863.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120222174825.GA32694@google.com>
	<alpine.SOC.1.00.1202222025120.20496@math.ut.ee>
	<20120223185503.GI22536@google.com>
In-Reply-To: <20120223185503.GI22536@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tj@kernel.org
Cc: mroos@linux.ee, grant.likely@secretlab.ca, rob.herring@calxeda.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, sam@ravnborg.org

From: Tejun Heo <tj@kernel.org>
Date: Thu, 23 Feb 2012 10:55:03 -0800

> Hello,
> 
> On Wed, Feb 22, 2012 at 08:25:32PM +0200, Meelis Roos wrote:
>> > Can you please try the following patch?  If it still fails to boot,
>> > please attach the failing log.  Thank you.
>> 
>> It works on E3500! Will try other machines tomorrow.
> 
> Once confirmed, I'll push the patch through tip.  It just hides the
> underlying problem but we should be in no worse shape than before,
> it's two line change so reproduing the problem again for proper
> diagnosing isn't difficult, and we're getting a bit late in release
> cycle already.

Ok.
