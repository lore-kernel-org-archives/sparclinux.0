From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Fri, 06 Nov 2009 09:59:55 +0000
Subject: Re: [PATCH 2/2] Added leon3_dma_ops and LEON specific mmu_inval_dma_area.
Message-Id: <4AF3F39B.4060700@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> 
> I suggested the SBUS ones because they inherit the OpenFirmware
> device node name into the resource.  They have also been cleaned
> up substantially, the PCI ones are very messy still.
> 
> 

Ok I will provide a patch that uses the SBUS versions.

Is it ok if I add sbus_sync_single_for_cpu/device which is a NOP if
SPARC_LEON is not defined?

Best regards,
Kristoffer





