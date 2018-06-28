From: David Miller <davem@davemloft.net>
Date: Thu, 28 Jun 2018 00:15:05 +0000
Subject: Re: mpt3sas regression...
Message-Id: <20180628.091505.1347631194560924387.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20180624.134639.2035609272357314002.davem@davemloft.net>
In-Reply-To: <20180624.134639.2035609272357314002.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Chaitra Basappa <chaitra.basappa@broadcom.com>
Date: Wed, 27 Jun 2018 19:58:34 +0530

>  Please let us know what is the issue faced and  if its recreating then
> share the driver logs with logging_level=0x3f8.

The driver cannot even probe successfully to start scanning for disks
because some busy bit never clears.  I think it was in one of the
firmware status registers or the doorbell register.

