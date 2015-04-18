From: David Miller <davem@davemloft.net>
Date: Sat, 18 Apr 2015 19:27:53 +0000
Subject: Re: sparc64: Build failure due to commit f1600e549b94 (sparc: Make sparc64 use scalable lib/iommu-co
Message-Id: <20150418.152753.603680048479537950.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20150418120510.GB1587@oracle.com>
	<5532A249.30703@roeck-us.net>
	<20150418183844.GA21225@oracle.com>
In-Reply-To: <20150418183844.GA21225@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sowmini.varadhan@oracle.com
Cc: linux@roeck-us.net, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Sat, 18 Apr 2015 14:38:44 -0400

> On (04/18/15 11:28), Guenter Roeck wrote:
>> 
>> Some merge gone wrong, maybe ? I tried to revert f1600e549b94
>> and apply http://patchwork.ozlabs.org/patch/459803/ instead.
> 
> That patch is a part-2 of a 3-part patch set. In order, this should
> have been v10: applied as:
> 
>    http://patchwork.ozlabs.org/patch/459804/
>    http://patchwork.ozlabs.org/patch/459803/
>    http://patchwork.ozlabs.org/patch/459802/
> 
> The mail thread for the 3-part patch set was here
>    http://www.spinics.net/lists/sparclinux/msg13785.html
> 
> I noticed that the existing dates on the iommu commits were also odd:
> 
>   commit 671d773297969bebb1732e1cdc1ec03aa53c6be2
>   Author: Sowmini Varadhan <sowmini.varadhan@oracle.com>
>   Date:   Thu Mar 12 20:02:37 2015 -0400
> 
> 
>   commit f1600e549b948a32ad7672e069b2915314637ae3
>   Author: Sowmini Varadhan <sowmini.varadhan@oracle.com>
>   Date:   Thu Mar 12 20:02:36 2015 -0400
>   
>   commit 10b88a4b17d31a7409494b179dcb76e7ab2fcaea
>   Author: Sowmini Varadhan <sowmini.varadhan@oracle.com>
>   Date:   Thu Mar 12 20:02:35 2015 -0400
> 
> We have had many discussions of this patch set since March 12,
> and the correct version should have been v10, dated something
> after Apr 9, and acked by Benjamin Herrenschmidt.

Dammit, somehow I applied V4 :-/

Sorry about that.  I'll try to sort this out.
