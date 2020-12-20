From: chase rayfield <cusbrar1@gmail.com>
Date: Sun, 20 Dec 2020 19:41:17 +0000
Subject: Re: [RFC PATCH 0/13] sparc32: sunset sun4m and sun4d
Message-Id: <CACwypyN30H4WWwQxsyAZDO=yjB7bo8dLj9Of5ygN7TB_UdaWWw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201218184347.2180772-1-sam@ravnborg.org>
In-Reply-To: <20201218184347.2180772-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From Experience... The best way to go about Gentoo for 32bit sparcs is
in a chroot on a faster 64bit Sparc system, you could probably also
run a faster than realtime QEMU but that's a bit more of a hassle if
you have fast Sun hardware. Last time I did this was on a T2000, I
have been meaning to retrace my steps on a T4.

I did run into a bug with portage or python... it would be nice to fix
that so those could be used on Slower systems. I'd also like at some
point to compile a list of software in the vein of suckless.org
(perhaps a bit less masochistic though), that is usable on old
machines, the one I really want to dogfood is pcb-rnd and corelEDA on
a sparcstation to see how well it could compete with KiCad.

Weird thing about the LCDs not syncing... all the LCDs I have that are
1280x1024 or greater work. The problem is that sometimes the default
resolution also has a sync rate of a few hz higher than some LCDs can
handle, most of my LCDs are older higher end models (1600x1200 etc...)
so also happen to support those rates. You can get most commodity LCDs
to sync by choosing a display mode via serial port that plays nice
with standard VGA resolutions and rates.
