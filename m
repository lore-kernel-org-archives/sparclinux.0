From: David Miller <davem@davemloft.net>
Date: Thu, 24 Nov 2016 16:20:57 +0000
Subject: Re: [PATCH v2] dbri: Fix compiler warning
Message-Id: <20161124.112057.785317837336457718.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1479957315-2517-1-git-send-email-tushar.n.dave@oracle.com>
 <s5hfumh9gpt.wl-tiwai@suse.de>
In-Reply-To: <s5hfumh9gpt.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tiwai@suse.de
Cc: sparclinux@vger.kernel.org, alsa-devel@alsa-project.org, thomas.tai@oracle.com, tushar.n.dave@oracle.com

From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 24 Nov 2016 13:59:10 +0100

> On Thu, 24 Nov 2016 04:15:15 +0100,
> Tushar Dave wrote:
>> 
>> @@ -2539,7 +2545,7 @@ static int snd_dbri_create(struct snd_card *card,
>>  	if (!dbri->dma)
>>  		return -ENOMEM;
>>  
>> -	dprintk(D_GEN, "DMA Cmd Block 0x%p (0x%08x)\n",
>> +	dprintk(D_GEN, "DMA Cmd Block 0x%p (0x%08llx)\n",
>>  		dbri->dma, dbri->dma_dvma);
> 
> Better to use %pad for dma_addr_t here.
> If the config doesn't enable ATU, dma_addr_t would be still u32, and
> your change will be buggy.

dma_addr_t is unconditionally a 64-bit type on sparc64.

However, you are right in that on sparc32 it is still 32-bit.


