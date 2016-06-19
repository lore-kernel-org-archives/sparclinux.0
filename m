From: David Miller <davem@davemloft.net>
Date: Sun, 19 Jun 2016 04:04:21 +0000
Subject: Re: 4.6-rc*: Kernel unaligned access at pci_bus_read_config_dword+0x64/0x80
Message-Id: <20160618.210421.1400395696678491125.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqzd3uDAAGsU0Tsg7vzxEvdtCv+QQDp8UM=6nVNk2VqO=A@mail.gmail.com>
	<CADxRZqw4jG3kPz6wG5Yx5DoZV0h+Xak5j682c7stq0fNOiopZQ@mail.gmail.com>
	<CADxRZqw6Q-jLCnZzzq=akP5vqd3Y8RCF34pWQGNSuL2VscrbJg@mail.gmail.com>
In-Reply-To: <CADxRZqw6Q-jLCnZzzq=akP5vqd3Y8RCF34pWQGNSuL2VscrbJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: matorola@gmail.com
Cc: mroos@linux.ee, sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org

From: Anatoly Pugachev <matorola@gmail.com>
Date: Thu, 16 Jun 2016 13:02:07 +0300

> bisected to git commit 63e3027

That's a merge commit that adds 100 different commits, and this happened
way back in March.

Please find the exact dword access in:

	drivers/pci/pcie/portdrv_{core,pci,bus}.c

that triggers this unaligned access so we can debug this further.

Thanks.
