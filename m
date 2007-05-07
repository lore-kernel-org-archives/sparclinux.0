From: David Miller <davem@davemloft.net>
Date: Mon, 07 May 2007 21:05:27 +0000
Subject: Re: [PATCH]: Final ESP driver rewrite
Message-Id: <20070507.140527.21365180.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070427.002829.43009224.davem@davemloft.net>
In-Reply-To: <20070427.002829.43009224.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Mon, 7 May 2007 20:49:30 +0100

> Hello David,
> 
> Building this I got the following warnings from modpost:
> 
> WARNING: vmlinux - Section mismatch: reference to .init.text:esp_bootup_reset from .text between 'esp_eh_host_reset_handler' (at offset 0x108814) and 'esp_info'
> WARNING: vmlinux - Section mismatch: reference to .init.text:scsi_esp_register from __ksymtab between '__ksymtab_scsi_esp_register' (at offset 0x2a20) and '__ksymtab_scsi_esp_intr'
> 
> Regarding the first one: esp_bootup_reset gets called from
> esp_eh_host_reset_handler, so it cannot be __devinit. The patch
> attached fixes this.

Patch applied, thanks.
