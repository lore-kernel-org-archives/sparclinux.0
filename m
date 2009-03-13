From: David Miller <davem@davemloft.net>
Date: Fri, 13 Mar 2009 22:35:56 +0000
Subject: Re: Ultra1 ESP detection problem
Message-Id: <20090313.153556.66900171.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0903132344220.21922@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0903132344220.21922@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sat, 14 Mar 2009 00:24:31 +0200 (EET)

> This is an Ultra 1 SBus (non-enterprise), having onboard SCSI, sbus card 
> with esp scsi and hme (FASHME) and a qlogic pti sbus card with scsi. 
> Boot disk is attached to onboard scsi. 2.6.26 and earlier kernels detect 
> all the scsi buses fine, 2.6.27 and 2.6.28 not yet tested, 2.6.29-rc8 
> fails to detect the onboard scsi (esp: probe of f0062a74 failed with 
> error -12).

	host = scsi_host_alloc(tpnt, sizeof(struct esp));

	err = -ENOMEM;
	if (!host)
		goto fail;

This is what's failing since -12 is -ENOMEM.

Can you try to bisect this down or similar?  I really
can guarentee you that I have to delete this report since
I'm so backlogged I won't get to it for a very long time.

Thanks.
