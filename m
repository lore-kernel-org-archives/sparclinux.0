From: David Miller <davem@davemloft.net>
Date: Wed, 21 Jun 2017 19:06:34 +0000
Subject: Re: [PATCH net-next 2/2] sunvnet: implement basic ethtool get_settings
Message-Id: <20170621.150634.1121246733116528491.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1498061394-233018-1-git-send-email-shannon.nelson@oracle.com>
        <1498061394-233018-3-git-send-email-shannon.nelson@oracle.com>
In-Reply-To: <1498061394-233018-3-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: shannon.nelson@oracle.com
Cc: netdev@vger.kernel.org, sparclinux@vger.kernel.org

From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 21 Jun 2017 09:09:54 -0700

> Add the get_settings callback so that both the ldmvsw and sunvnet
> drivers will give a little more information when asked for its
> basic settings.  These aren't necessarily very useful, but they
> make some users happier.  Also, a side effect is that the speed
> attribute in /sys/class/net/<dev> is now readable, which makes
> a couple of the ldom management tools happier.
> 
> Orabug: 26175474
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>

I would set the speed to something other than zero, and also
consider the ramifications of this change upon things like
'bonding' and 'team'.
