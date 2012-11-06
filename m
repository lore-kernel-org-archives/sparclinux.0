From: David Miller <davem@davemloft.net>
Date: Tue, 06 Nov 2012 17:44:15 +0000
Subject: Re: [PATCH 41/42] sparc, mm: Remove calling of free_all_bootmem_node()
Message-Id: <20121106.124415.1042816028807879843.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CAE9FiQWUiNqv-fd_4Y79eq+-w6wU34nEwn76+QJ7TWw7uCLaaQ@mail.gmail.com>
	<1352147263-20383-1-git-send-email-yinghai@kernel.org>
	<1352147263-20383-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1352147263-20383-3-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yinghai@kernel.org
Cc: tglx@linutronix.de, mingo@elte.hu, hpa@zytor.com, jacob.shin@amd.com, akpm@linux-foundation.org, stefano.stabellini@eu.citrix.com, konrad.wilk@oracle.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Yinghai Lu <yinghai@kernel.org>
Date: Mon,  5 Nov 2012 12:27:42 -0800

> Now NO_BOOTMEM version free_all_bootmem_node() does not really
> do free_bootmem at all, and it only call
> register_page_bootmem_info_node instead.
> 
> That is confusing, try to kill that free_all_bootmem_node().
> 
> Before that, this patch will remove calling of free_all_bootmem_node()
> 
> We add register_page_bootmem_info() to call register_page_bootmem_info_node
> directly.
> 
> Also could use free_all_bootmem() for numa case, and it is just
> the same as free_low_memory_core_early().
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

Acked-by: David S. Miller <davem@davemloft.net>
