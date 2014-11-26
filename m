From: Christoph Hellwig <hch@lst.de>
Date: Wed, 26 Nov 2014 19:13:09 +0000
Subject: Re: [hch-scsi-queue:drivers-for-3.19 174/180] drivers/scsi/wd719x.c:247:2: error: implicit declarati
Message-Id: <20141126191309.GA32112@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <201411252333.lLEJOiQu%fengguang.wu@intel.com> <20141126102843.GB23189@lst.de> <201411261832.48201.linux@rainbow-software.org>
In-Reply-To: <201411261832.48201.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Christoph Hellwig <hch@lst.de>, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, linux-scsi@vger.kernel.org, sparclinux@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Wed, Nov 26, 2014 at 06:32:48PM +0100, Ondrej Zary wrote:
> wd819x should probably depend on VIRT_TO_BUS? But that means it will not work 
> on sparc. Is there a way to make it work? I have a sparc machine but haven't 
> tested it.

The explanation from Arnd in the other thread makes more sense -
dma_cache_sync only is for non-coherent allocations so we should be
able to remove it entirely.  Can you prepare and test a patch to just remove
it for me?
