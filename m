From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Wed, 28 Jan 2009 08:45:18 +0000
Subject: Re: Sunfire V880 and 480R 2.6.27.x startup hangs
Message-Id: <20090128084518.GA3008@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jan 27, 2009 at 10:29:10PM -0800, David Miller wrote:
> From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
> Date: Mon, 26 Jan 2009 11:04:39 +0100
> 
> > [   48.965131] calling  of_bus_driver_init+0x0/0x104
> > [   49.021376] Setting up of bus
> 
> Strance, here is a patch to get some more information.

It's hanging in kset_register. Does this ring a bell to you ?
Will move the full output to the usual place. Thanks.

[   46.994534] calling  random32_init+0x0/0xf0
[   47.044539] initcall random32_init+0x0/0xf0 returned 0 after 0 msecs
[   47.120582] calling  sock_init+0x0/0x64
[   47.166520] initcall sock_init+0x0/0x64 returned 0 after 0 msecs
[   47.238297] calling  netpoll_init+0x0/0x30
[   47.287256] initcall netpoll_init+0x0/0x30 returned 0 after 0 msecs
[   47.362256] calling  netlink_proto_init+0x0/0x238
[   47.418529] NET: Registered protocol family 16
[   47.471670] initcall netlink_proto_init+0x0/0x238 returned 0 after 3 msecs
[   47.553935] calling  of_bus_driver_init+0x0/0x12c
[   47.610180] Setting up of bus
[   47.645596] In bus_register().
[   47.682056] Doing kobject_set_name()
[   47.724764] kset_register()

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
