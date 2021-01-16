From: Finn Thain <fthain@telegraphics.com.au>
Date: Sat, 16 Jan 2021 23:22:15 +0000
Subject: Re: Old platforms never die, was Re: Old platforms: bring out your dead
Message-Id: <alpine.LNX.2.23.453.2101171017320.6@nippy.intranet>
List-Id: <sparclinux.vger.kernel.org>
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de> <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net> <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de> <alpine.LNX.2.23.453.2101131035500.6@nippy.intranet>
 <897dbd50-ce42-8fdb-8777-fab08185e324@landley.net>
In-Reply-To: <897dbd50-ce42-8fdb-8777-fab08185e324@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Gerhard Pircher <gerhard_pircher@gmx.net>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Sparc kernel list <sparclinux@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Sat, 16 Jan 2021, Rob Landley wrote:

> Speaking of which, my qemu m68k system has failed to boot ever since commit:
> 
> commit f93bfeb55255bddaa16597e187a99ae6131b964a
> Author: Finn Thain <fthain@telegraphics.com.au>
> Date:   Sun Jun 28 14:23:12 2020 +1000
> 
>     macintosh/via-macii: Poll the device most likely to respond
> 

Yes, that patch series broke your emulator by fixing kernel bugs. Please 
refer to this message for some background and some solutions--
https://lore.kernel.org/linux-m68k/alpine.LNX.2.23.453.2008100844450.8@nippy.intranet/
