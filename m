From: David Miller <davem@davemloft.net>
Date: Sun, 25 Jun 2017 19:31:29 +0000
Subject: Re: [v1] sparc64: fix typo in property
Message-Id: <20170625.153129.570928511200893261.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1498162744-840346-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1498162744-840346-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 22 Jun 2017 16:19:04 -0400

> There is a typo in a comment that propogated into code:
> upa-portis instead of upa-portid
> 
> This problem was detected by code inspection, and I am not sure if it
> effects any current systems. It was not reproduced by QEMU.
> 
> It is likely that all existing implementations of OpenBoot have cpuid
> property in cpu node.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reported-by: Steven Sistare <steven.sistare@oracle.com>
> Reviewed-by: Steven Sistare <steven.sistare@oracle.com>

You can actually check the situation out in the prtconfs repository:

	git://git.kernel.org/pub/scm/linux/kernel/git/davem/prtconfs.git

And as can be clearly seen there many UPA based systems only have the
'upa-portid' property and do not have a 'cpuid' one in the cpu node.

Was this bug introduced by the recent timer changes?

It looks like it is, and when you are fixing bugs caused by commit X
you must list it in a properly formatted "Fixes: " tag so that everyone
can tell where the bug was introduced and therefore what, if any,
trees the bug fix needs be backported to.  The format is:

Fixes: $(SHA1_ID) ("Commit message header line")

The SHA1_ID is to be listed with 12 digits of signifigance.

The Fixes: tag comes at the beginnig of the signoffs, acks, and
other tags and the end of the commit message.  No empty lines
should occur between the Fixes: and other tags.

Thank you.
