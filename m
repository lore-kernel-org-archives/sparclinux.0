From: "David S. Miller" <davem@redhat.com>
Date: Mon, 02 Feb 2004 21:19:43 +0000
Subject: Re: Problems with bridging on Sparc64
Message-Id: <20040202131943.398500fb.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <8AA870658244D4119AF600508BDF0A361D4BF107@usahm014.exmi01.exch.eds.com>
In-Reply-To: <8AA870658244D4119AF600508BDF0A361D4BF107@usahm014.exmi01.exch.eds.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2 Feb 2004 15:18:04 -0500 
"Small, Jim" <jim.small@eds.com> wrote:

> I understand that David S Miller and other Sparc64 Linux networking gurus
> hang out in this forum.  I'm hoping you can help me with a bridging problem.
> 
> I am running kernel 2.4.24/Sparc64 on my Ultra 60.  I also have the latest
> version of the bridge utils - 0.9.6.

Unfortunately this is not fixable, unless you rebuild your bridging tools
as 64-bit binaries.

It is nearly impossible to translate the 32-bit versions of the bridging
ioctl interfaces because they use the SIOCDEVPRIVATE ioctl numbers which
do not indicate the type that the application is passing into the handler
(and thus we don't what to translate it to/from).

Stephen Hemminger (bridge maintainer) CC'd.
