From: David Miller <davem@davemloft.net>
Date: Thu, 07 Jan 2010 04:22:31 +0000
Subject: Re: [patch 5/6] sparc: cpumask_of_node() should handle -1 as a node
Message-Id: <20100106.202231.90723930.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100106045509.245662398@samba.org>
	<20100106045525.329010098@samba.org>
In-Reply-To: <20100106045525.329010098@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: anton@samba.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, akpm@linux-foundation.org

From: Anton Blanchard <anton@samba.org>
Date: Wed, 06 Jan 2010 15:55:14 +1100

> pcibus_to_node can return -1 if we cannot determine which node a pci bus
> is on. If passed -1, cpumask_of_node will negatively index the lookup array
> and pull in random data:
> 
> # cat /sys/devices/pci0000:00/0000:00:01.0/local_cpus
> 00000000,00000003,00000000,00000000
> # cat /sys/devices/pci0000:00/0000:00:01.0/local_cpulist
> 64-65
> 
> Change cpumask_of_node to check for -1 and return cpu_all_mask in this
> case:
> 
> # cat /sys/devices/pci0000:00/0000:00:01.0/local_cpus
> ffffffff,ffffffff,ffffffff,ffffffff
> # cat /sys/devices/pci0000:00/0000:00:01.0/local_cpulist
> 0-127
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Acked-by: David S. Miller <davem@davemloft.net>
