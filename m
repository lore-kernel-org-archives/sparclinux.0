From: David Miller <davem@davemloft.net>
Date: Thu, 21 Apr 2011 23:39:21 +0000
Subject: Re: [PATCH] sparc32: fix sparcstation 5 boot
Message-Id: <20110421.163921.59668847.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110421082934.GA22659@merkur.ravnborg.org>
In-Reply-To: <20110421082934.GA22659@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 21 Apr 2011 10:29:34 +0200

>>From b0777dd526dbc375fa6e35fc07016af82cf71636 Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Thu, 21 Apr 2011 10:25:41 +0200
> Subject: [PATCH] sparc32: fix sparcstation 5 boot
> 
> The sparcstation 5 I have available has no MID property for the CPU.
> This resulted in a panic when booting a SMP kernel on this box.
> 
> The assigned field in cpu_data is never used, so if we fail
> to read the MID property then inform user and continue booting.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Thanks for fixing this.

At least the current code traps the condition, the last time this
stuff worked it was by accident, device_scan() on sparc32 used
to be something like:

void __init
device_scan(void)
{
	char node_str[128];
	int thismid;

	prom_getstring(prom_root_node, "device_type", node_str, sizeof(node_str));
 ...
		int scan;
		scan = prom_getchild(prom_root_node);
		/* One can look it up in PROM instead */
		while ((scan = prom_getsibling(scan)) != 0) {
			prom_getstring(scan, "device_type",
				       node_str, sizeof(node_str));
			if (strcmp(node_str, "cpu") = 0) {
				linux_cpus[linux_num_cpus].prom_node = scan;
				prom_getproperty(scan, "mid",
						 (char *) &thismid, sizeof(thismid));
				linux_cpus[linux_num_cpus].mid = thismid;
				printk("Found CPU %d <node=%08lx,mid=%d>\n",
				       linux_num_cpus, (unsigned long) scan, thismid);
				linux_num_cpus++;
			}
		}

No error checking or anything, which basically writes a random value
into linux_cpus[].mid when the property is not present.

I guess it would up being zero often enough. :-/

And the 'ss5' device tree dump in the prtconf repo:

	git://git.kernel.org/pub/scm/linux/kernel/git/davem/prtconfs.git

confirms no 'mid' property for the 'cpu' device tree node.

Applied and queued for -stable, thanks again!
