From: Meelis Roos <mroos@linux.ee>
Date: Tue, 30 Jul 2013 09:58:44 +0000
Subject: Re: sparc ESP SCSI error handling BUG+hang
Message-Id: <alpine.SOC.1.00.1307301257120.260@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1304211357540.2145@math.ut.ee> <20130729.153223.2291945302397524459.davem@davemloft.net> <20130729.161532.1928549790091477295.davem@davemloft.net>
In-Reply-To: <20130729.161532.1928549790091477295.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org

> > Therefore I think the fix is going to involve adding a member to
> > "struct esp_cmd_entry" called "->orig_tag[]" so that we can see what
> > the original tag[] values were at esp_alloc_lun_tag() time.
> 
> Please try this patch:

It works on 3 consecutive boots, thank you!

Tested-by: Meelis Roos <mroos@linux.ee>

-- 
Meelis Roos (mroos@linux.ee)
