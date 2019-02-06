From: Corentin Labbe <clabbe.montjoie@gmail.com>
Date: Wed, 06 Feb 2019 19:38:24 +0000
Subject: Re: [Qemu-devel] sparc: crash when using initrd > 5M
Message-Id: <20190206193824.GA1909@Red>
List-Id: <sparclinux.vger.kernel.org>
References: <20190103154810.GB32032@Red>
	<3a375dc6-f0ba-c3f0-6e86-2fd5cdf3ee35@ilande.co.uk>
	<8c302745-5097-afed-5c7e-9a992da03cf6@ilande.co.uk>
	<20190205091115.GA27918@Red>
	<2a85b239-7117-71aa-b921-86c42a54aeba@ilande.co.uk>
	<20190206072850.GA4295@Red>
	<8da59b77-eef2-4897-5254-0f6fb22539a6@ilande.co.uk>
In-Reply-To: <8da59b77-eef2-4897-5254-0f6fb22539a6@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: sparclinux@vger.kernel.org, qemu-devel@nongnu.org

On Wed, Feb 06, 2019 at 07:37:29AM +0000, Mark Cave-Ayland wrote:
> On 06/02/2019 07:28, Corentin Labbe wrote:
> 
> >>> Hello
> >>>
> >>> Sorry even with the patch I still hit the issue.
> >>>
> >>> I have added some debug and at least qemu set initrd_size correctly now.
> >>>
> >>> I have tried to compile openbios-sparc32 for debugging but fail with
> >>> arch/sparc32/context.c:116:5: error: PIC register clobbered by 'l7' in 'asm'
> >>>      asm __volatile__ ("\n\tcall __switch_context"
> >>>      ^~~
> >>> make[1]: *** [rules.mak:219: target/arch/sparc32/context.o] Error 1
> >>> (gcc 7.2 and gc 6.4 with binutils 2.30)
> >>
> >> Hmmm. One other thing I've noticed is that newer kernels tend need a minimum of 256M
> >> RAM to start up - does it work if you add -m 256 to your command line?
> >>
> >>
> > 
> > I have already set 256M of RAM. (and tried 512)
> 
> I wonder then if this is being triggered by a recent kernel change? I tend to test
> using the latest Debian ports ISOs which are currently running 4.9 and that booted
> fine when I was testing the patches above.
> 
> Can you try with a few older kernels to see if this is the case?
> 

Hello

In fact the problem was due to .config since a defconfig works fine on next-20190205
After lots of diff I found that CONFIG_LOG_BUF_SHIFT cause this behaviour.

Note that values of 16,17 cause also the same problem.

Regards
