From: David Miller <davem@davemloft.net>
Date: Sat, 10 Jun 2017 21:12:10 +0000
Subject: Re: [PATCH v4 0/5] LDC changes for porting VCC driver into upstream kernel
Message-Id: <20170610.171210.2165359633470390825.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1497022394.git.jag.raman@oracle.com>
In-Reply-To: <cover.1497022394.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jag Raman <jag.raman@oracle.com>
Date: Fri,  9 Jun 2017 12:29:27 -0400

> This series of patches is part of an effort to add VCC (Virtual Console
> Concentrator) support to Linux.
> 
> VCC enables the virtualization of serial console on SPARC processors. VCC 
> provides access to the guest domain's serial console.
> 
> VCC depends on some core functionalities in the linux kernel for SPARC. The 
> functionalities include LDC (Logical Domain Channels), MDESC (Machine
> Descriptor) and VIO (Virtual IO protocol). In order for VCC to be enabled,
> it requires that these core functionalities support them.
> 
> This series of patches adds LDC support to enable VCC on Linux. It
> is the first batch of changes to enable VCC.
> 
> This version 4 of the series addresses the following changes
> suggested by Dave Miller
> Patch 1/5: Modifies ldc_print/__ldc_print to print caller name. Fixes
>            indentation of wrapped lines.

Series applied to sparc-next, thanks.
