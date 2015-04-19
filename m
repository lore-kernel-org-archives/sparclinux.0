From: David Miller <davem@davemloft.net>
Date: Sun, 19 Apr 2015 18:09:49 +0000
Subject: Re: sparc64: Build failure due to commit f1600e549b94 (sparc: Make sparc64 use scalable lib/iommu-co
Message-Id: <20150419.140949.1005823635639126807.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <55332B75.7080103@roeck-us.net>
	<55332DBF.7030701@roeck-us.net>
	<20150419105157.GA9736@oracle.com>
In-Reply-To: <20150419105157.GA9736@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sowmini.varadhan@oracle.com
Cc: linux@roeck-us.net, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Sun, 19 Apr 2015 06:51:57 -0400

> On (04/18/15 21:23), Guenter Roeck wrote:
>> 
>> I spoke too early. Now I get a similar failure in the
>> powerpc:allmodconfig build
>> (which previously failed for a different reason).
> 
> I think this duplicate symbol is genuine.. there's a definition
> in arch/powerpc/kernel/iommu.c. To avoid conflicting with that,
> the one in lib/iommu-common.c can be renamed.  I guess we missed
> this during review, and this went under the radar when I did
> all my testing on sparc.
> 
> I'll put a patch together for this today..

Maybe ping the powerpc folks becuase if they can do a quick
conversion, this change isn't necessary.
