From: Christoph Hellwig <hch@infradead.org>
Date: Sat, 07 Aug 2004 17:10:51 +0000
Subject: Re: architectures with their own "config PCMCIA"
Message-Id: <20040807181051.A19250@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040807170122.GM17708@fs.tum.de>
In-Reply-To: <20040807170122.GM17708@fs.tum.de>; from bunk@fs.tum.de on Sat, Aug 07, 2004 at 07:01:22PM +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@fs.tum.de>
Cc: wli@holomorphy.com, davem@redhat.com, geert@linux-m68k.org, schwidefsky@de.ibm.com, linux390@de.ibm.com, sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org

On Sat, Aug 07, 2004 at 07:01:22PM +0200, Adrian Bunk wrote:
> The following architetures have their own "config PCMCIA" instead of 
> including drivers/pcmcia/Kconfig (in 2.6.8-rc3-mm1):
> - m68k
> - s390
> - sparc
> - sparc64
> 
> Is there any good reason for this, or would a patch to change these 
> architectures to include drivers/pcmcia/Kconfig be OK?

What about switching them to use drivers/Kconfig instead?

