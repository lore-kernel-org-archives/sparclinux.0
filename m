From: "H. Peter Anvin" <hpa@zytor.com>
Date: Wed, 17 May 2006 20:57:39 +0000
Subject: Re: klibc and SPARC
Message-Id: <446B8E43.205@zytor.com>
List-Id: <sparclinux.vger.kernel.org>
References: <e4g1ho$dae$1@terminus.zytor.com>
In-Reply-To: <e4g1ho$dae$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

[Resend to fix Cc: list]

Followup to:  <20060517.134042.27108210.davem@davemloft.net>
By author:    "David S. Miller" <davem@davemloft.net>
In newsgroup: linux.dev.sparclinux
 >
 > From: "H. Peter Anvin" <hpa@zytor.com>
 > Date: Wed, 17 May 2006 13:37:12 -0700 (PDT)
 >
 > > Is there a way to get that information from userspace, and if not,
 > > should there be a general way to do it or an ad hoc solution?  It sort
 > > of looks like arch/sparc64/prom describes a form of filesystem, but I
 > > don't see any obvious userspace interface.
 >
 > There are two ways.
 >
 > First option is to mount the "openpromfs" filesystem under
 > /proc/openprom, the full firmware device tree and properties are
 > available under there as a filesystem.

Just found that ;)

 > The second option is to load the /dev/openprom driver, which you open,
 > and then access using ioctls() defined in <asm/openpromio.h>

Does it make sense to say that these prom configurations are only
recognized by kinit if openpromfs is available (without which it will
simply behave as on any other platform), or should I go through the
additional trouble of supporting both methods?

         -hpa
