From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 12 May 2012 06:27:10 +0000
Subject: Re: [PATCH] sparc32: Restore SMP build and rectify sun4m NMI when non-SMP.
Message-Id: <20120512062710.GB1879@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120512.002817.467682394309360735.davem@davemloft.net>
In-Reply-To: <20120512.002817.467682394309360735.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, May 12, 2012 at 12:28:17AM -0400, David Miller wrote:
> 
> The non-SMP sun4m NMI handler was still accessing SUN4C registers.
> 
> Fix that and share the sun4m NMI trap code between SMP and non-SMP
> cases.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
Looks good.
And I must admit I only did UP builds after I fixed up the NMI handling.
Because I found some issues late in my UP builds, so I had to go
back and redo my initial patch.

Only bad excuses - but somehow I am glad I failed here as the
NMI handler looks much better now!

	Sam
