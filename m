From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 31 Jan 2006 00:20:33 +0000
Subject: Re: kernel compile problems on sparc32
Message-Id: <20060130.162033.05742106.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <970C8856-7B16-11DA-940F-00050249ADE1@kaffe.org>
In-Reply-To: <970C8856-7B16-11DA-940F-00050249ADE1@kaffe.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: kaffe <riccardo@kaffe.org>
Date: Sun, 1 Jan 2006 23:33:11 +0100

> in arch/sparc32/math/math.c around lines 330 there are two #ifdef's 
> with debugging outputs, they are in the default: section of a switch(), 
> since if debug is disabled no statement exist, compilation will file.
> My suggestion for a fix is simply to add
> 
> #ifdef ----
>    --debug statement--
> #else
>     ;
> #endif
> 
> I found two of these occurrences and I did not make a patch but just 
> fixed my file, thus sorry for the "wordy" description.

Thanks, I'm just going to delete these "default" cases from
the switch entirely in order to fix this.  If type is not
initialized then we get a debug message and an emulation failure
later in the function, so these default cases are totally
unnecessary.
