From: David Miller <davem@davemloft.net>
Date: Thu, 24 Mar 2016 19:20:16 +0000
Subject: Re: [Patch V2 1/2] sparc64 changes for gdb-7.6
Message-Id: <20160324.152016.2026457455119227349.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1458772868-10255-2-git-send-email-dave.kleikamp@oracle.com>
In-Reply-To: <1458772868-10255-2-git-send-email-dave.kleikamp@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Wed, 23 Mar 2016 17:41:07 -0500

> +   /* If the section has relocations, we must read it ourselves.
> +-     Otherwise we attach it to the BFD.  */
> ++     Otherwise we attach it to the BFD.  
> ++     Also, in sparc64 only try mmap for sections which
> ++     are properly aligned in order to avoid SIGBUS errors.  */
> ++
> ++#if defined(__sparc__) && __WORDSIZE = 64
> ++  if (info->size > 4 * pagesize && (sectp->flags & SEC_RELOC) = 0 && !(sectp->filepos & 0x3))
> ++#else
> +   if ((sectp->flags & SEC_RELOC) = 0)
> ++#endif
> +     {
> +       const gdb_byte *bytes = gdb_bfd_map_section (sectp, &info->size);

This doesn't make any sense at all.

The bug is probably that unaligned relocations are being improperly
accessed using 32-bit loads and storess them.

Several relocs, particularly those used in debugging sections, need to
be carefully accessed using byte at a time accesses in order to avoid
said SIGBUS problem.

BFD and the rest of binutils have code to handle this case properly.

Please don't paper over the core issue with hacks like this.

Thanks.
