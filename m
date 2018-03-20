From: David Miller <davem@davemloft.net>
Date: Tue, 20 Mar 2018 15:14:46 +0000
Subject: Re: [PATCH sparc-next] sparc: Make auxiliary vectors for ADI available on 32-bit as well
Message-Id: <20180320.111446.111954216494768560.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20180320144602.16535-1-khalid.aziz@oracle.com>
In-Reply-To: <20180320144602.16535-1-khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khalid.aziz@oracle.com
Cc: shannon.nelson@oracle.com, nagarathnam.muthusamy@oracle.com, nick.alcock@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, khalid@gonehiking.org

From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Tue, 20 Mar 2018 08:46:02 -0600

> Commit c6202ca764ac ("sparc64: Add auxiliary vectors to report
> platform ADI properties") adds auxiliary vectors to report ADI
> capabilities on sparc64 platform only. This needs to be uniform
> across 64-bit and 32-bit. This patch makes the same vectors
> available on 32-bit as well.
> 
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>

Applied, thank you.
