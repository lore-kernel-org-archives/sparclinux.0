From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 11 Sep 2014 19:51:05 +0000
Subject: Re: [PATCH v3] sparc32: dma_alloc_coherent must honour gfp flags
Message-Id: <5411FD29.5050005@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1410351472-10501-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1410351472-10501-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 09/10/2014 11:03 PM, David Miller wrote:
> From: Daniel Hellstrom<daniel@gaisler.com>
> Date: Wed, 10 Sep 2014 14:17:52 +0200
>
>> dma_zalloc_coherent() calls dma_alloc_coherent(__GFP_ZERO)
>> but the sparc32 implementations sbus_alloc_coherent() and
>> pci32_alloc_coherent() doesn't take the gfp flags into
>> account.
>>
>> Tested on the SPARC32/LEON GRETH Ethernet driver which fails
>> due to dma_alloc_coherent(__GFP_ZERO) returns non zeroed
>> pages.
>>
>> Signed-off-by: Daniel Hellstrom<daniel@gaisler.com>
> Applied, thanks Daniel.
Thanks! I think this is subject for the stable branches.
