From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 Jan 2021 12:02:09 +0000
Subject: Re: Old platforms: bring out your dead
Message-Id: <CAHp75VfzUt_kgzNuXt7pYG4UWcZMF9MtnT1n1j8thOys=OJ+ZA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net> <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
 <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com> <b8eb1c83-d2f8-1c72-ca67-4160b90b3845@landley.net>
In-Reply-To: <b8eb1c83-d2f8-1c72-ca67-4160b90b3845@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Gerhard Pircher <gerhard_pircher@gmx.net>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Sparc kernel list <sparclinux@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Wed, Jan 13, 2021 at 9:58 AM Rob Landley <rob@landley.net> wrote:
> On 1/12/21 4:46 PM, Linus Walleij wrote:

...

> Testing that a basic superh system still builds and boots under qemu and j-core
> I can commit to doing regularly. Testing specific hardware devices on boards I
> don't regularly use is a lot harder.

In our lab we have different hardware connected (including non-x86,
mostly due to maintenance and testing drivers) and it allows us to run
more or less fresh kernels on it. Setup is pretty simple: server with
connected USB 2 serial, network, etc, power cutters, relays to emulate
power button presses for the hardware that can't be turned off and on
by cutting the main power (usual case for tablets / phones) and so on.
From a software point of view we use a netboot image [1][2] which
allows us to kexec kernel downloaded via net.

Now to the point, perhaps organizations like LF can set up something
like this with one technician to support this and pay electricity /
internet bills?

[1]: https://github.com/andy-shev/linux/tree/netboot (just a set of
kernel configuration options on top of defaults)
[2]: https://github.com/andy-shev/buildroot/tree/intel/board/intel/common
(see README in the folder)

-- 
With Best Regards,
Andy Shevchenko
