From: "David S. Miller" <davem@redhat.com>
Date: Tue, 17 Feb 2004 06:29:34 +0000
Subject: Re: 2.4.24 link err for sparc64
Message-Id: <20040216222934.498910c1.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040216072928.GA30923@net-ronin.org>
In-Reply-To: <20040216072928.GA30923@net-ronin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: carbonated beverage <ramune@net-ronin.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Sun, 15 Feb 2004 23:29:29 -0800
carbonated beverage <ramune@net-ronin.org> wrote:

> I ripped out sysctl support from a 2.4.24 kernel (stock
> tarball from ftp.*.*.kernel.org) and the final link failed
> with:
> 
> arch/sparc64/kernel/kernel.o(.text+0x19750): In function `sys32_sysctl':
> : undefined reference to `do_sysctl'

-ENOSYS is the right error to return, to be consistent with what
kernel/sysctl.c itself does in this case.

Thanks for the report, I'll push the fix around.
