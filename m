From: Christoph Hellwig <hch@infradead.org>
Date: Wed, 09 Oct 2019 17:51:49 +0000
Subject: Re: [PATCH] proc: centralise declaration of cpuinfo_op
Message-Id: <20191009175149.GA28540@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20191009113930.13236-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20191009113930.13236-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, linux-s390@vger.kernel.org, Rich Felker <dalias@libc.org>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, linux-arm-kernel@lists.infradead.org, Mark Salter <msalter@redhat.com>, sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 12:39:30PM +0100, Ben Dooks wrote:
> When building for arm, cpuinfo_op generates a warning due
> to no declaration. Since this is used in fs/proc/cpuinfo.c
> and inconsitently declared across archiectures move the
> declaration info <linux/seq_file.h>. This means that the
> cpuinfo_op will have a declaration any place it is used.
> 
> Removes the following sparse warning:
> 
> arch/arm/kernel/setup.c:1320:29: warning: symbol 'cpuinfo_op' was not declared. Should it be static?

I like the consolidation, but I don't think seq_file.h is the right
place.  A procfs or cpu topology related header seems like the better
choice.
