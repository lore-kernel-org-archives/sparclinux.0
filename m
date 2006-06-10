From: David Miller <davem@davemloft.net>
Date: Sat, 10 Jun 2006 00:00:53 +0000
Subject: Re: [PATCH] Build mptspi.c on architectures where CONFIG_PM is
Message-Id: <20060609.170053.107254117.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1149345407.14611.49.camel@localhost.localdomain>
In-Reply-To: <1149345407.14611.49.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tcallawa@redhat.com
Cc: linux-scsi@vger.kernel.org, sparclinux@vger.kernel.org

From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Sat, 03 Jun 2006 09:36:47 -0500

> sparc64 does not have CONFIG_PM defined, and mptscsih_resume is wrapped
> in an #ifdef CONFIG_PM in mptscsih.h. mptscsih_resume is only used in
> the mptspi_resume function in mptspi.c, and its only call is in the
> pci_driver struct (and that call is also #ifdef CONFIG_PM). In order to
> get the code to compile, I just needed to wrap the actual function in
> #ifdef CONFIG_PM, which is what this patch does. I can confirm that it
> gets the module building again without errors.
> 
> Signed-off-by: Tom "spot" Callaway <tcallawa@redhat.com>

Thanks Tom I'll apply this.
