From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 22 Sep 2004 03:20:18 +0000
Subject: Re: Ultra 2 Enterprise: All 2.6.xx SMP kernels hardlock
Message-Id: <20040921202018.2fe564af.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <703d4eaa04092018404389859@mail.gmail.com>
In-Reply-To: <703d4eaa04092018404389859@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 21 Sep 2004 21:08:05 -0600 (MDT)
Jason Wever <weeve@gentoo.org> wrote:

> However 2.6.9-rc2 on the Blade 100 stops at the point it would normally 
> switch from the "Loading Linux..." prompt to the framebuffer.  I've tried 
> letting it go but it doesn't seem to go anywhere as I never get any 
> network connectivity.  Is there a way I can try to generate some 
> semi-useful output here to help troubleshoot what is going on?

I see this too, try two things (which I haven't gotten around
to trying yet):

1) boot with the "-p" option, this will log early
   console messages
2) try also "console=prom" and make sure CONFIG_PROM_CONSOLE
   is enabled as well
