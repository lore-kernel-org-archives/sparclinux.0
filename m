From: David Miller <davem@davemloft.net>
Date: Fri, 20 Mar 2015 01:57:23 +0000
Subject: Re: [PATCH] sparc64: Setup sysfs to mark LDOM sockets, cores and threads correctly
Message-Id: <20150319.215723.1740098776893456680.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1426795630-135778-1-git-send-email-david.ahern@oracle.com>
In-Reply-To: <1426795630-135778-1-git-send-email-david.ahern@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Ahern <david.ahern@oracle.com>
Date: Thu, 19 Mar 2015 16:07:10 -0400

> The current sparc kernel has no representation for sockets though tools like
> lscpu can pull this from sysfs. This patch walks the machine description
> cache and socket hierarchy and marks sockets as well as cores and threads
> such that a representative sysfs is created by drivers/base/topology.c.
 ...
> Most of this patch was done by Chris with updates by David.
> 
> Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
> Signed-off-by: David Ahern <david.ahern@oracle.com>

This is reasonably involved so I'm going to take some time review
this.
