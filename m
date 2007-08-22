From: David Miller <davem@davemloft.net>
Date: Wed, 22 Aug 2007 21:50:52 +0000
Subject: Re: sun4v oops
Message-Id: <20070822.145052.24611606.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1187814718.3439.350.camel@dhcp83-165.boston.redhat.com>
In-Reply-To: <1187814718.3439.350.camel@dhcp83-165.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Wed, 22 Aug 2007 17:44:41 -0400

> I'm not. Fedora is still on gcc 4.1.
> 
> System.map says:
> 
> 00000000004778bc t rcu_start_batch
> 0000000000477928 t __rcu_process_callbacks
> 0000000000477b98 t rcu_process_callbacks
> 0000000000477bd4 t rcu_barrier_callback
> 
> Not sure how useful that is. I accidentally rebooted into this kernel,
> and it booted all the way to login this time,

Strange.

> but I noticed the following in dmesg:

Those kobject_add messages are known and I'm working on a
solution to that issue.

> One last item: This kernel loads the e1000 driver fine, but while it
> detects the devices, it doesn't think there is link on the eth0 port (or
> any of eth0-3 for that matter). There is definitely a good link there,
> but it won't pull an IP over dhcp.

Works perfectly fine here on every Niagara I own.

You'll need to dig deep into this yourself since I suspect
you're going to be the only person who can reproduce this
and it's going to be inefficient to debug something like
this remotely.
