From: David Miller <davem@davemloft.net>
Date: Fri, 12 Dec 2014 02:54:09 +0000
Subject: Re: [PATCH 3/3] sunvdc: reconnect ldc after vds service domain restarts
Message-Id: <20141211.215409.263707199788716722.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1418318777-16453-3-git-send-email-dwight.engen@oracle.com>
In-Reply-To: <1418318777-16453-3-git-send-email-dwight.engen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dwight Engen <dwight.engen@oracle.com>
Date: Thu, 11 Dec 2014 12:26:17 -0500

> This change enables the sunvdc driver to reconnect and recover if a vds
> service domain is disconnected or bounced.
> 
> By default, it will wait indefinitely for the service domain to become
> available again, but will honor a non-zero vdc-timout md property if one
> is set. If a timeout is reached, any in-progress I/O's are completed
> with -EIO.
> 
> Signed-off-by: Dwight Engen <dwight.engen@oracle.com>
> Reviewed-by: Chris Hyser <chris.hyser@oracle.com>

Applied.
