From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Jan 2021 09:48:26 +0000
Subject: Re: Old platforms: bring out your dead
Message-Id: <CAMuHMdVmZyEz_NVjqtJUrrsjq=mCsa6on+O6hK3ztisNvxQkjw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net> <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
 <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com> <1be37673-db0e-f09d-68c8-f929be4019ab@physik.fu-berlin.de>
In-Reply-To: <1be37673-db0e-f09d-68c8-f929be4019ab@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, Gerhard Pircher <gerhard_pircher@gmx.net>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Sparc kernel list <sparclinux@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Adrian,

On Thu, Jan 14, 2021 at 10:42 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> Oh, and if anyone else is interested in helping with the SH port, I'm happy to send
> them a free LANDISK or NextVoD SuperH device - the latter has a 450 MHz ST-40
> CPU and 256 MB RAM.

Wasn't ST-40 support removed in 2007[1]?
However, that didn't stop people from submitting ST-40 fixes to the core
SH code three years later[2] ;-)

[1] f96691872439ab20 ("sh: Kill off the remaining ST40 cruft.")
[2] a086536858ad0eb5 ("sh: Ensure ST40-300 BogoMIPS value is consistent")

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
