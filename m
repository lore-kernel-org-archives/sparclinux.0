From: "David S. Miller" <davem@redhat.com>
Date: Mon, 23 Feb 2004 05:41:26 +0000
Subject: Re: oops in sched_init() on E3000
Message-Id: <20040222214126.1ea97d14.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040222043448.GG703@holomorphy.com>
In-Reply-To: <20040222043448.GG703@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 22 Feb 2004 18:57:12 -0500
Ben Collins <bcollins@debian.org> wrote:

> > Ben Collins and I may have messed up net booting when we added SILO+kernel
> > support for larger images, but it could also be this STACK phdr thing too.
> 
> My big kernel testing worked with net booting, but I didn't use
> elftoaout, I booted the elf image directly.

Please play with this if you get a chance Ben, we'll need it for tftpboot.img
stuff in the end.
