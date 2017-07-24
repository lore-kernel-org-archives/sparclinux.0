From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 24 Jul 2017 13:42:24 +0000
Subject: Re: [PATCH v2 3/3] sparc64: Increase max_phys_bits to 51 for M8.
Message-Id: <20170724134224.GA12962@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1500876859-8398-3-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1500876859-8398-3-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi!

On Mon, Jul 24, 2017 at 11:44:19AM +0530, Allen Pais wrote:
> On M8 chips, use a max_phys_bits value of 51 and also fix the VA
> hole.

Are there any plans to add the possibility to limit the VA space per
process to 48 bits?  I'm asking since some applications, in particular
JavaScript engines are using the upper bits for tagging pointers.

This has the result that on sparc64, software like NodeJS or QtScript
doesn't build at the moment. See this discussion for more [1].

As five-level page tables were added for x86 as well to extend the VA
space to 52 bits [2], I asked the kernel maintainers behind these
patches and they told me they have the possibility to limit the
address space per process on x86 to avoid these issues.

Would it be possible to add this feature on sparc64 as well?

Thanks,
Adrian

> [1] https://bugreports.qt.io/browse/QTBUG-56264
> [2] https://lwn.net/Articles/717293/

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
