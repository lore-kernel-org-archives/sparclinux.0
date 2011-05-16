From: David Miller <davem@davemloft.net>
Date: Mon, 16 May 2011 20:42:04 +0000
Subject: Re: [PATCH] sparc32,leon: Remove unnecessary page_address calls in
Message-Id: <20110516.134204.59675881.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1304065020-28326-1-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1304065020-28326-1-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 29 Apr 2011 12:29:27 +0200

> On Fri, Apr 29, 2011 at 10:17:00AM +0200, Kristoffer Glembo wrote:
>> The function mmu_inval_dma_area takes a virtual address as a parameter
>> which is problematic in case the buffer is located in highmem and the
>> mapping currently is unavailable.
>> 
>> Since the function was only implemented for LEON this patch removes
>> calls to it in non LEON code paths and renames it to dma_make_coherent
>> which instead takes a physical address (which for now is unused since we
>> flush the whole cache). This way it is possible to remove several unnecessary
>> calls to page_address which will fail if the virtual mapping is unavailable.
>> 
>> Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>
> Looks good!
> 
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Applied.
