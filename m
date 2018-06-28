From: Chaitra Basappa <chaitra.basappa@broadcom.com>
Date: Thu, 28 Jun 2018 15:57:54 +0000
Subject: RE: mpt3sas regression...
Message-Id: <13f147db51318183fe6e2a1126550c52@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180624.134639.2035609272357314002.davem@davemloft.net>
In-Reply-To: <20180624.134639.2035609272357314002.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David,
  I could see the same issue on sparc64 system, soon we will repost the
patch addressing this.

Thanks,
 Chaitra


-----Original Message-----
From: David Miller [mailto:davem@davemloft.net]
Sent: Thursday, June 28, 2018 5:45 AM
To: chaitra.basappa@broadcom.com
Cc: linux-scsi@vger.kernel.org; sparclinux@vger.kernel.org
Subject: Re: mpt3sas regression...

From: Chaitra Basappa <chaitra.basappa@broadcom.com>
Date: Wed, 27 Jun 2018 19:58:34 +0530

>  Please let us know what is the issue faced and  if its recreating then
> share the driver logs with logging_level=0x3f8.

The driver cannot even probe successfully to start scanning for disks
because some busy bit never clears.  I think it was in one of the
firmware status registers or the doorbell register.
