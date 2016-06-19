From: David Miller <davem@davemloft.net>
Date: Sun, 19 Jun 2016 06:49:08 +0000
Subject: Re: 4.6-rc*: Kernel unaligned access at pci_bus_read_config_dword+0x64/0x80
Message-Id: <20160618.234908.1671877676732375612.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqw4jG3kPz6wG5Yx5DoZV0h+Xak5j682c7stq0fNOiopZQ@mail.gmail.com>
	<CADxRZqw6Q-jLCnZzzq=akP5vqd3Y8RCF34pWQGNSuL2VscrbJg@mail.gmail.com>
	<20160618.210421.1400395696678491125.davem@davemloft.net>
In-Reply-To: <20160618.210421.1400395696678491125.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: matorola@gmail.com
Cc: mroos@linux.ee, sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Sat, 18 Jun 2016 21:04:21 -0700 (PDT)

> From: Anatoly Pugachev <matorola@gmail.com>
> Date: Thu, 16 Jun 2016 13:02:07 +0300
> 
>> bisected to git commit 63e3027
> 
> That's a merge commit that adds 100 different commits, and this happened
> way back in March.
> 
> Please find the exact dword access in:
> 
> 	drivers/pci/pcie/portdrv_{core,pci,bus}.c
> 
> that triggers this unaligned access so we can debug this further.

Meanwhile I figured it out, this should fix the bug:

diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
index dfbab61..1fa3a32 100644
--- a/drivers/pci/vc.c
+++ b/drivers/pci/vc.c
@@ -221,9 +221,9 @@ static int pci_vc_do_save_buffer(struct pci_dev *dev, int pos,
 		else
 			pci_write_config_word(dev, pos + PCI_VC_PORT_CTRL,
 					      *(u16 *)buf);
-		buf += 2;
+		buf += 4;
 	}
-	len += 2;
+	len += 4;
 
 	/*
 	 * If we have any Low Priority VCs and a VC Arbitration Table Offset
