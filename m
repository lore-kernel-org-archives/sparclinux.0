From: David Miller <davem@davemloft.net>
Date: Fri, 02 Aug 2013 01:07:48 +0000
Subject: Re: sparc ESP SCSI error handling BUG+hang
Message-Id: <20130801.180748.905410067616601949.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20130729.153223.2291945302397524459.davem@davemloft.net>
	<20130729.161532.1928549790091477295.davem@davemloft.net>
	<alpine.SOC.1.00.1307301257120.260@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1307301257120.260@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Tue, 30 Jul 2013 12:58:44 +0300 (EEST)

>> > Therefore I think the fix is going to involve adding a member to
>> > "struct esp_cmd_entry" called "->orig_tag[]" so that we can see what
>> > the original tag[] values were at esp_alloc_lun_tag() time.
>> 
>> Please try this patch:
> 
> It works on 3 consecutive boots, thank you!
> 
> Tested-by: Meelis Roos <mroos@linux.ee>

Thanks for testing, I'll push this to Linus via the sparc tree.
