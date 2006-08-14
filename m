From: David Miller <davem@davemloft.net>
Date: Mon, 14 Aug 2006 10:51:17 +0000
Subject: Re: AW: latest 2.4.33 kernel
Message-Id: <20060814.035117.74748455.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <DA6197CAE190A847B662079EF7631C0601569276@OEKAW2EXVS03.hbi.ad.harman.com>
In-Reply-To: <DA6197CAE190A847B662079EF7631C0601569276@OEKAW2EXVS03.hbi.ad.harman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Mon, 14 Aug 2006 12:36:57 +0200

> Is it possible that __HAVE_ARCH_MEMCHR is defined even though it isn't available? Should I try to undef it, and if so, where would I do this?

If you have built smbfs as a module, then the problem is that the memchr symbol
is not being exported to modules.

In that case you need to add the line "EXPORT_SYMBOL_NOVERS(memchr);" to
the file(s) arch/sparc{,64}/kernel/sparc{,64}_ksyms.c

This change will require a full rebuild.

Another fast solution for you is to simply build smbfs non-modular.
