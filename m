From: Paul Thomas <pthomas8589@gmail.com>
Date: Tue, 25 May 2010 06:21:42 +0000
Subject: Re: GR-LEON4-ITX
Message-Id: <AANLkTinRvjVVBpKdzk-ZRba8GpcnqU4ih79oe42SrEup@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <AANLkTiku3COSiJ8kJcOuzykS-gVWvHrC_tlCxydQmaV7@mail.gmail.com>
In-Reply-To: <AANLkTiku3COSiJ8kJcOuzykS-gVWvHrC_tlCxydQmaV7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, May 24, 2010 at 10:11 PM, Kristoffer Glembo
<kristoffer@gaisler.com> wrote:
> Hello Paul,
>
> The easiest way to get Linux running on the GR-LEON4-ITX board
> is to use the kernel that is delivered with the board. It is
> based on 2.6.21 and contains all our drivers and boot loader
> (this kernel is also available from our webpage).
>
> The mainline kernel does work on LEON3/4 (including SMP) but
> we have not yet made available an updated distribution with surrounding
> infrastructure (e.g. boot loader, root file systems, OpenFirmware tree generation, etc).
>
> Hopefully it will not be too long until we release an updated version based
> on the latest kernel. All tough it will take some time to get all drivers
> from the 2.6.21 version into the mainline kernel.
>
> Link to the board for anyone interested in getting a new SPARC V8 with lots of on chip
> devices:
> http://www.gaisler.com/cms/index.php?option=com_content&task=view&id39&Itemid#2
>
> Best regards,
> Kristoffer Glembo
> Aeroflex Gaisler
>
>

Kristoffer,

Thanks for the information. I'm not in a hurry. I'd like to work with
the mainline kernel. I'm used to using u-boot, a custom kernel & a
generic emdebian root fs. Is u-boot the default bootloader on the
board?

thanks,
Paul
