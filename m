From: David Miller <davem@davemloft.net>
Date: Wed, 21 Jun 2017 19:05:46 +0000
Subject: Re: [PATCH net-next 1/2] ldmvsw: add vio version and remote-mac to ethtool info
Message-Id: <20170621.150546.230947714652245325.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1498061394-233018-1-git-send-email-shannon.nelson@oracle.com>
        <1498061394-233018-2-git-send-email-shannon.nelson@oracle.com>
In-Reply-To: <1498061394-233018-2-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: shannon.nelson@oracle.com
Cc: netdev@vger.kernel.org, sparclinux@vger.kernel.org

From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 21 Jun 2017 09:09:53 -0700

> In the ethtool -i output print the vio version and the remote-mac
> of the ldom that the vif device is serving as this vif info is
> not exposed elsewhere.  The remote-mac address is most useful for
> tracking which client ldom is being served by the vif.
> 
> Orabug: 26316362
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>

Although less useful, it is exposed already via the kernel logs.

Also, this is not at all an appropriate place to expose this.  The
"driver info" ethtool command is not a place to post per-connection
or per-link information.

Probably one of the IFLA_* netlink attributes would work best for
this.  You could even use PHYS_PORT_ID for this, which gives you
32 bytes to work with.
