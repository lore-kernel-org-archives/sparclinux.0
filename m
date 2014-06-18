From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 18 Jun 2014 04:41:02 +0000
Subject: Re: Build regressions/improvements in v3.16-rc1
Message-Id: <53A1185E.6080707@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1403018163-25307-1-git-send-email-geert@linux-m68k.org> <CAMuHMdU2DTt0va67uSKqhhqbVORuY+xEs3uGZ21sKjahE_MSXg@mail.gmail.com>
In-Reply-To: <CAMuHMdU2DTt0va67uSKqhhqbVORuY+xEs3uGZ21sKjahE_MSXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, sparclinux <sparclinux@vger.kernel.org>

On 06/17/2014 08:23 AM, Geert Uytterhoeven wrote:
> On Tue, Jun 17, 2014 at 5:16 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
[...]
>
>>    + /scratch/kisskb/src/sound/soc/fsl/fsl_dma.c: error: invalid use of undefined type 'struct ccsr_ssi':  => 926:34, 927:34
>
> powerpc/mpc85xx_defconfig
>

Being fixed:
	http://patchwork.ozlabs.org/patch/358500/

Guenter

