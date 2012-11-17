From: Joerg Roedel <joro@8bytes.org>
Date: Sat, 17 Nov 2012 12:22:26 +0000
Subject: Re: [PATCH RFT] sparc: dma-mapping: support debug_dma_mapping_error
Message-Id: <20121117122226.GT25742@8bytes.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1351211773.6851.24.camel@lorien2>
In-Reply-To: <1351211773.6851.24.camel@lorien2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Shuah Khan <shuah.khan@hp.com>
Cc: davem@davemloft.net, kyungmin.park@samsung.com, m.szyprowski@samsung.com, sam@ravnborg.org, arnd@arndb.de, sparclinux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, shuahkhan@gmail.com

On Thu, Oct 25, 2012 at 06:36:13PM -0600, Shuah Khan wrote:
> >From 9e8feb61482288c5a5dd609e0dd17c1a262a48a3 Mon Sep 17 00:00:00 2001
> From: Shuah Khan <shuahkhan@gmail.com>
> Date: Thu, 25 Oct 2012 18:31:42 -0600
> Subject: [PATCH RFT] sparc: dma-mapping: support debug_dma_mapping_error
> 
> Add support for debug_dma_mapping_error() call to avoid warning from
> debug_dma_unmap() interface when it checks for mapping error checked
> status. Without this patch, device driver failed to check map error
> warning is generated.
> 
> Signed-off-by: Shuah Khan <shuah.khan@hp.com>

Applied to dma-debug, thanks.

Btw, what about the patches for the other archs? They should depend on
the dma-debug branch too and should also be there, no?


	Joerg


