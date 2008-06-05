From: David Miller <davem@davemloft.net>
Date: Thu, 05 Jun 2008 18:42:50 +0000
Subject: Re: [RFC: 2.6 patch] sparc64/kernel/: make code static
Message-Id: <20080605.114250.114917586.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080605182637.GI1469@cs181133002.pp.htv.fi>
In-Reply-To: <20080605182637.GI1469@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Adrian Bunk <bunk@kernel.org>
Date: Thu, 5 Jun 2008 21:26:38 +0300

> This patch makes the following needlessly global code static:
> - central.c: struct central_bus
> - central.c: struct fhc_list
> - central.c: apply_fhc_ranges()
> - central.c: apply_central_ranges()
> - ds.c: struct ds_states_template[]
> - pci_msi.c: sparc64_setup_msi_irq()
> - pci_msi.c: sparc64_teardown_msi_irq()
> - pci_sun4v.c: struct sun4v_dma_ops
> - sys_sparc32.c: cp_compat_stat64()
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

Applied.
