From: Shuah Khan <shuah.khan@hp.com>
Date: Fri, 26 Oct 2012 21:40:24 +0000
Subject: Re: [PATCH RFT RESEND linux-next] sparc: dma-mapping: support debug_dma_mapping_error
Message-Id: <1351287624.6885.4.camel@lorien2>
List-Id: <sparclinux.vger.kernel.org>
References: <1351211909.6851.26.camel@lorien2>
	 <1351267989.4013.20.camel@lorien2>
	 <20121026.150153.1335892148865957561.davem@davemloft.net>
	 <20121026.151055.328093458246032481.davem@davemloft.net>
In-Reply-To: <20121026.151055.328093458246032481.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: kyungmin.park@samsung.com, arnd@arndb.de, m.szyprowski@samsung.com, sam@ravnborg.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com

On Fri, 2012-10-26 at 15:10 -0400, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Fri, 26 Oct 2012 15:01:53 -0400 (EDT)
> 
> > From: Shuah Khan <shuah.khan@hp.com>
> > Date: Fri, 26 Oct 2012 10:13:09 -0600
> > 
> >> Add support for debug_dma_mapping_error() call to avoid warning from
> >> debug_dma_unmap() interface when it checks for mapping error checked
> >> status. Without this patch, device driver failed to check map error
> >> warning is generated.
> >> 
> >> Signed-off-by: Shuah Khan <shuah.khan@hp.com>
> > 
> > Why are you resending this?
> > 
> > When you resend patches, you have to give a reason.  Did the patch
> > change?  Are you updating the CC: list of the patch posting? Are
> > you correcting something else?
> 
> In fact you sent this _3_ times.  Please, don't do this, or at least
> explain why you are reposting something each time.

I am really sorry for the noise. I forgot to mark this explicitly for
linux-next the first time and this patch depends on a patch that went
into linux-next. I sent a few patches for several architectures and lost
track. I meant to add explanation before I hit send. The reason for
resend is to tag it for linux-next. 

-- Shuah


