From: Christoph Lameter <clameter@sgi.com>
Date: Thu, 24 May 2007 17:01:37 +0000
Subject: Re: [2/3] 2.6.22-rc2: known regressions v2
Message-Id: <Pine.LNX.4.64.0705241001040.28086@schroedinger.engr.sgi.com>
List-Id: <sparclinux.vger.kernel.org>
References: <46558708.2040803@googlemail.com> <46559B54.80106@googlemail.com>
In-Reply-To: <46559B54.80106@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, "Cherwin R. Nooitmeer" <cherwin@gmail.com>, linux-pcmcia@lists.infradead.org, Robert de Rooy <robert.de.rooy@gmail.com>, Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, Mikael Pettersson <mikpe@it.uu.se>, linux1394-devel@lists.sourceforge.net, Stefan Richter <stefanr@s5r6.in-berlin.de>, =?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@bitplanet.net>, linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Marcus Better <marcus@better.se>, Andrey Borzenkov <arvidjaar@mail.ru>, linux-usb-devel@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@suse.de>

On Thu, 24 May 2007, Michal Piotrowski wrote:

> Memory management
>=20
> Subject    : kernel BUG at include/linux/slub_def.h:88 kmalloc_index()
> References : http://bugzilla.kernel.org/show_bug.cgi?id=8476
> Submitter  : Cherwin R. Nooitmeer <cherwin@gmail.com>
> Status     : Unknown


Looks like this is in DRM code:

BUG: at include/linux/slub_def.h:88 kmalloc_index()
 [<c014f67f>] get_slab+0x43/0x1c6
 [<c014f875>] __kmalloc+0xc/0x57
 [<f0a7b564>] drm_rmdraw+0x0/0x27d [drm]
 [<f0a7b698>] drm_rmdraw+0x134/0x27d [drm]
 [<f0a7b564>] drm_rmdraw+0x0/0x27d [drm]
 [<f0a7c1d0>] drm_ioctl+0x144/0x18c [drm]
 [<c01265ad>] enqueue_hrtimer+0xe3/0xef
 [<c015c184>] do_ioctl+0x4c/0x64
 [<c015c3c7>] vfs_ioctl+0x22b/0x23e
 [<c015c40d>] sys_ioctl+0x33/0x4e
 [<c0103ca0>] syscall_call+0x7/0xb

