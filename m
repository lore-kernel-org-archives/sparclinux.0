From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Jan 2021 08:15:56 +0000
Subject: Re: Old platforms: bring out your dead
Message-Id: <CAMuHMdU3s9hvenrRFibggT=hGDfauhh2hPcN7f3E0uG-iVG7iw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net> <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
 <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com>
In-Reply-To: <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Gerhard Pircher <gerhard_pircher@gmx.net>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Sparc kernel list <sparclinux@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Linus,

On Wed, Jan 13, 2021 at 4:20 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Jan 12, 2021 at 3:45 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> That said there are a three things that people should really be doing if they
> want to keep their pet archs/subarchs around as good community
> members, and they are in essence to:

> 2. Migrate existing drivers to newly appeared and
>     appropriate subsystems (I think there are some hacky heartbeat LED
>     drivers down in arch/* for example) there is also the feature matrix
>     core maintainers like and which appears if you type
>     Documentation/features/list-arch.sh <archname>
>     would be nice if you work on them if you can support them!
>     Or at least take a look.

The choir is listening ;-)

For Amiga, that would require writing a real GPIO driver (modifying
gpio-mmio?) for the CIAs, and converting its users (amiflop, amijoy,
amimouse, parport_amiga, amiserial, and dmasound_paula) from direct CIA
register access to GPIO access (mctrl_gpio for amiserial)).
Note that the heartbeat LED is shared by heartbeat and audio.

An interim solution might be to just write a simple gpio driver for the
single CIA pin driving the heartbeat LED, allowing the user to set up
ledtrig-heartbeat.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
