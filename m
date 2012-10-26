From: David Miller <davem@davemloft.net>
Date: Fri, 26 Oct 2012 19:01:53 +0000
Subject: Re: [PATCH RFT RESEND linux-next] sparc: dma-mapping: support debug_dma_mapping_error
Message-Id: <20121026.150153.1335892148865957561.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1351211773.6851.24.camel@lorien2>
	<1351211909.6851.26.camel@lorien2>
	<1351267989.4013.20.camel@lorien2>
In-Reply-To: <1351267989.4013.20.camel@lorien2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: shuah.khan@hp.com
Cc: kyungmin.park@samsung.com, arnd@arndb.de, m.szyprowski@samsung.com, sam@ravnborg.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com

From: Shuah Khan <shuah.khan@hp.com>
Date: Fri, 26 Oct 2012 10:13:09 -0600

> Add support for debug_dma_mapping_error() call to avoid warning from
> debug_dma_unmap() interface when it checks for mapping error checked
> status. Without this patch, device driver failed to check map error
> warning is generated.
> 
> Signed-off-by: Shuah Khan <shuah.khan@hp.com>

Why are you resending this?

When you resend patches, you have to give a reason.  Did the patch
change?  Are you updating the CC: list of the patch posting? Are
you correcting something else?
