From: David Miller <davem@davemloft.net>
Date: Fri, 29 Feb 2008 00:25:38 +0000
Subject: Re: bbc_envctrl & sunblade1000 temp/fan monitoring
Message-Id: <20080228.162538.147221036.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <BAY123-W223997AE674E1FB857BC07D1260@phx.gbl>
In-Reply-To: <BAY123-W223997AE674E1FB857BC07D1260@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Pablo_Andr=E9s_Martikian <pablomartikian@hotmail.com>
Date: Fri, 15 Feb 2008 12:28:57 +0100

> Maybe I didn't search enough, or maybe there is no other way, so I
> modified the bbc_envctrl.c to print the values via the procfs to the
> /proc/kenvctrl file. I just added a spinlock and the
> create_proc_file and destroy. This is the output I show:
>
> # cat /proc/kenvctrl
> TEMP0: cpu 73 amb 27
> TEMP1: cpu 71 amb 27
> FAN0: psuppy 1 cpufanspeed 44 sysfanspeed 41

This works, I guess.  Another way you could do this is to
create sysfs filesystem nodes under /sys.  Using that you
could also create writable nodes that can be used to tweak
the temperature ranges.

And yes it work for the other envctrl drivers as well.

> I attach the source. I think the spinlock is well used.

I don't see the attachment.
