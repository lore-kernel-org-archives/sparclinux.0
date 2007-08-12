From: "Blue Swirl" <blauwirbel@gmail.com>
Date: Sun, 12 Aug 2007 15:59:15 +0000
Subject: Re: Sun4c interrupt controller - Sun4d relevance
Message-Id: <f43fc5580708120859u25e70f73te58bc710a100bdd9@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <46BF2A25.9090900@netunix.com>
In-Reply-To: <46BF2A25.9090900@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 8/12/07, Chris Newport <crn@netunix.com> wrote:
> This is VERY interesting as it should be possible to fix Sun4d by finding
> the differences between sun4d and sun4m in Solaris and covering those
> points.
>
> This would almost certainly be easier than trying to fix the current
> mess. Unfortunately I am no longer able to do this but maybe someone
> will be interested enough to try. It might even be possible to fix
> pluto/fc but maybe that is too much to ask.

It is also possible to add sun4d emulation to Qemu. I think the
architecture is similar to sun4m except for sbi, io-unit and different
counter. CPU/MMU (with working SMP) and I/O devices are already
emulated.
