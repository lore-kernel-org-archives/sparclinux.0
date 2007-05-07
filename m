From: David Miller <davem@davemloft.net>
Date: Mon, 07 May 2007 04:58:06 +0000
Subject: Re: [PATCH] fix sun_esp.c compile
Message-Id: <20070506.215806.41633901.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <463E8CFF.7040103@earthlink.net>
In-Reply-To: <463E8CFF.7040103@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Sun, 06 May 2007 22:20:47 -0400

> Fix a sparc32 compile problem in latest git.
> 
> drivers/scsi/sun_esp.c: In function 'sbus_esp_reset_dma':
> drivers/scsi/sun_esp.c:294: error: 'loops_per_jiffy' undeclared (first 
> use in this function)
> drivers/scsi/sun_esp.c:294: error: (Each undeclared identifier is 
> reported only once
> drivers/scsi/sun_esp.c:294: error: for each function it appears in.)
> drivers/scsi/sun_esp.c: In function 'sbus_esp_dma_drain':
> drivers/scsi/sun_esp.c:364: error: 'loops_per_jiffy' undeclared (first 
> use in this function)
> drivers/scsi/sun_esp.c: In function 'sbus_esp_dma_invalidate':
> drivers/scsi/sun_esp.c:396: error: 'loops_per_jiffy' undeclared (first 
> use in this function)
> 
> Signed-off-by: Robert Reif <reif@earthlink.net>

Thanks Robert, this is queued up in my sparc-2.6.git tree
already.
