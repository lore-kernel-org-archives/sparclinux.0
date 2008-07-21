From: David Miller <davem@davemloft.net>
Date: Mon, 21 Jul 2008 23:51:07 +0000
Subject: Re: [PATCH 2/4] ide: <asm-sparc/ide.h>: use __raw_{read,write}w()
Message-Id: <20080721.165107.193400368.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080714153825.9085.98433.sendpatchset@localhost.localdomain>
	<20080714153832.9085.83030.sendpatchset@localhost.localdomain>
In-Reply-To: <20080714153832.9085.83030.sendpatchset@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, sparclinux@vger.kernel.org, wli@holomorphy.com

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Mon, 14 Jul 2008 17:38:32 +0200

> Use __raw_{read,write}w() in __ide_{in,out}sw().
> 
> Cc: William L. Irwin <wli@holomorphy.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Applied.
