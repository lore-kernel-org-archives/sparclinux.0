From: Admar Schoonen <admar@luon.net>
Date: Sun, 21 Nov 2004 16:49:58 +0000
Subject: Re: 2.6.10-rc2: no mach64 framebuffer (and possible ext3 fs corruption?)
Message-Id: <20041121164958.GA5554@zonne.luon.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20041121145828.GA13642@zonne.luon.net>
In-Reply-To: <20041121145828.GA13642@zonne.luon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Nov 21, 2004 at 03:58:28PM +0100, Admar Schoonen wrote:
> I just tried out 2.6.10-rc2 with pwc-10.0.4 patch from saillard.org and the alsa
> patch that Sjoerd Simons recently posted to this list.
> 
> First observations:
> 1. blank screen
> 2. machine lockup when trying to use alsa
> 3. ext3 filesystem corruption
> 
> Some further details:
> 2. loading the snd-ioctl32 module and trying some alsa suff freezes the machine.
> This looks the same as when Sjoerd's patch isn't applied, so perhaps I made an
> error here. Right now I'm compiling 2.6.9 with Sjoerd's patch to try again.

Some more info: Sjoerds patch against 2.6.9 works perfect. Excellent native alsa
sound from my blade 100 (snd_ali5451 module). I also verified that with
2.6.10-rc2, I did have his patch applied, so there must be something in
2.6.10-rc2 that breaks sound again.

Admar
