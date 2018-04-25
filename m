From: Christoph Hellwig <hch@lst.de>
Date: Wed, 25 Apr 2018 07:21:05 +0000
Subject: Re: [PATCH 22/22] parisc: use generic dma_noncoherent_ops
Message-Id: <20180425072105.GA12308@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180420080313.18796-1-hch@lst.de> <20180420080313.18796-23-hch@lst.de> <e0b4f3be-68b9-c3af-e432-fd20419e2d70@gmx.de>
In-Reply-To: <e0b4f3be-68b9-c3af-e432-fd20419e2d70@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Helge Deller <deller@gmx.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Apr 21, 2018 at 07:43:46PM +0200, Helge Deller wrote:
> This patch breaks a 32bit kernel on a B160L machine (PA7300LC CPU, "pcxl2").
> After applying this patch series the lasi82956 network driver works unreliable. 
> NIC gets IP, but ping doesn't work.
> See drivers/net/ethernet/i825xx/lasi_82596.c, it uses dma*sync() functions.

Just to confirm:  Without the series it is known to actually work?
