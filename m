From: David Miller <davem@davemloft.net>
Date: Fri, 17 Mar 2017 03:30:10 +0000
Subject: Re: [PATCH v2 net-next 0/5] sunvnet: better connection management
Message-Id: <20170316.203010.1792960724364202011.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1489512283-422140-1-git-send-email-shannon.nelson@oracle.com>
In-Reply-To: <1489512283-422140-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: shannon.nelson@oracle.com
Cc: netdev@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Tue, 14 Mar 2017 10:24:38 -0700

> These patches remove some problems in handling of carrier state
> with the ldmvsw vswitch, remove  an xoff misuse in sunvnet, and
> add stats for debug and tracking of point-to-point connections
> between the ldom VMs.
> 
> v2:
>  - added ldmvsw ndo_open to reset the LDC channel
>  - updated copyrights

Series applied, thanks Shannon.
