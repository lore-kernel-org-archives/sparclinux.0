From: David Miller <davem@davemloft.net>
Date: Tue, 06 Jan 2015 22:23:39 +0000
Subject: Re: [PATCH V2] sparc64: fatal trap should stop all cpus
Message-Id: <20150106.172339.234764614075259812.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <54AB1B83.6070800@oracle.com>
In-Reply-To: <54AB1B83.6070800@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Mon, 05 Jan 2015 17:17:23 -0600

> The below patch works with the hypervisor. I'm not sure if the calls
> to set_cpu_online are really needed, but I left them in for now.

I don't see any other implementation of smp_send_stop() doing this.

I'd rather you leave it out.

Please also submit new versions of patches properly, as fresh
list postings.

Otherwise I have to edit out the commit message and that's more
work for me.

Thanks.
