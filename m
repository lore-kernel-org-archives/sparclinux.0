From: Christoph Hellwig <hch@infradead.org>
Date: Tue, 24 Apr 2007 12:45:27 +0000
Subject: Re: [RFC PATCH]: Rewritten ESP driver, porters needed!
Message-Id: <20070424124527.GA30023@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20070423.151322.111205472.davem@davemloft.net>
In-Reply-To: <20070423.151322.111205472.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-scsi@vger.kernel.org, jskov@cygnus.co.uk, weisd3458@uni.edu, tymm@computer.org, tsbogend@alpha.franken.de, flo@rfc822.org, airlied@linux.ie, ralf@linux-mips.org, sparclinux@vger.kernel.org

Oh, btw - there is a problem with the generic code beeing esp.ko -
we already have drivers/char/esp.c which buids into esp.ko for
ISA platforms, which have a bit of overlap with ESP-using platforms.
Maybe the driver should become esp_scsi.c/.ko or ncr_esp or
ncr53x9x?
