From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Sun, 19 Apr 2015 10:51:57 +0000
Subject: Re: sparc64: Build failure due to commit f1600e549b94 (sparc: Make sparc64 use scalable lib/iommu-co
Message-Id: <20150419105157.GA9736@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150418.152753.603680048479537950.davem@davemloft.net>
 <20150418.154039.772836205352309363.davem@davemloft.net>
 <20150418195514.GC18556@oracle.com>
 <20150418.174115.1706650539865486258.davem@davemloft.net>
 <55332B75.7080103@roeck-us.net>
 <55332DBF.7030701@roeck-us.net>
In-Reply-To: <55332DBF.7030701@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On (04/18/15 21:23), Guenter Roeck wrote:
> 
> I spoke too early. Now I get a similar failure in the
> powerpc:allmodconfig build
> (which previously failed for a different reason).

I think this duplicate symbol is genuine.. there's a definition
in arch/powerpc/kernel/iommu.c. To avoid conflicting with that,
the one in lib/iommu-common.c can be renamed.  I guess we missed
this during review, and this went under the radar when I did
all my testing on sparc.

I'll put a patch together for this today..

--Sowmini
