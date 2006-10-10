From: David Miller <davem@davemloft.net>
Date: Tue, 10 Oct 2006 21:36:09 +0000
Subject: Re: [PATCH 3/4] fix sparc32 modpost warnings
Message-Id: <20061010.143609.01050203.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061010154548.GD30909@palantir8>
In-Reply-To: <20061010154548.GD30909@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Tue, 10 Oct 2006 16:45:48 +0100

> Fix these 2.6.19-rc1 build warnings from modpost:
> 
> WARNING: vmlinux - Section mismatch: reference to .init.text:__alloc_bootmem from .text between 'srmmu_nocache_init' (at offset 0x1a0f8) and 'srmmu_mmu_info'
> WARNING: vmlinux - Section mismatch: reference to .init.text:__alloc_bootmem from .text between 'srmmu_nocache_init' (at offset 0x1a118) and 'srmmu_mmu_info'
> WARNING: vmlinux - Section mismatch: reference to .init.text:srmmu_early_allocate_ptable_skeleton from .text between 'srmmu_nocache_init' (at offset 0x1a188) and 'srmmu_mmu_info'
> 
> Martin
> 
> 	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

This patch looks great, applied.

Thanks a lot.
