From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Mon, 26 Jan 2009 10:04:39 +0000
Subject: Re: Sunfire V880 and 480R 2.6.27.x startup hangs
Message-Id: <20090126100439.GB1994@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Jan 25, 2009 at 06:30:23PM -0800, David Miller wrote:
>
> > Compiled 2.6.27.12 today without the CON_BOOT flag and booted with the
> > options above. The hang seems to be in of_bus_driver_init, see
> > console output below.
> 
> I wonder what's getting tripped up in there :-)
> 
> Please add this patch and get the new console output, thanks!

Not getting much futher, only a "Setting up of bus", see below. 
The full console output I leave on:

http://www.iwr.uni-heidelberg.de/ftp/linux/sparc-boot/console20090126.txt

Is that ok or should I always attach the complete console ?
If time permits I'll test on a 480R, too. Thanks.

~> tail /tmp/console20090126.txt
[   48.455736] initcall random32_init+0x0/0xf0 returned 0 after 0 msecs
[   48.531777] calling  sock_init+0x0/0x64
[   48.577716] initcall sock_init+0x0/0x64 returned 0 after 0 msecs
[   48.649494] calling  netpoll_init+0x0/0x30
[   48.698453] initcall netpoll_init+0x0/0x30 returned 0 after 0 msecs
[   48.773455] calling  netlink_proto_init+0x0/0x238
[   48.829727] NET: Registered protocol family 16
[   48.882871] initcall netlink_proto_init+0x0/0x238 returned 0 after 3 msecs
[   48.965131] calling  of_bus_driver_init+0x0/0x104
[   49.021376] Setting up of bus

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
