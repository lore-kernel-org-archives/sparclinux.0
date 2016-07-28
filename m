From: David Miller <davem@davemloft.net>
Date: Thu, 28 Jul 2016 05:46:46 +0000
Subject: Re: [PATCH V2 1/2] arch/sparc: SPARC-S7 piggyback support
Message-Id: <20160727.224646.763946484256415755.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Joe Moriarty <joe.moriarty@oracle.com>
Date: Tue, 24 May 2016 11:16:11 -0400

> Merge: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux
> 
> The a.out header is sometimes wrong and doesn't match the binary file
> contents for different Oracle projects using Oracle Linux. This patch
> was created to make sure the set of changes in a.out header file match
> the changes in the a.out binary file.

This doesn't explain anything to me, nor show why the calculation
changes in this patch are being made at all.

> -	if (lseek(image, offset, 0) < 0)
> +	if (lseek(image, offset, SEEK_SET) < 0)
 ...
> -		if (lseek(image, 4, 0) < 0)
> +		if (lseek(image, 4, SEEK_SET) < 0)
 ...
> +	if (lseek(image, AOUT_TEXT_OFFSET + align(end - start), SEEK_SET) < 0)
>  		die("lseek");

These "0 --> SEEK_SET" changes are firstly not metioned at all in
your commit message, and are a completely seperate change from
fixing the offsets and lengths.

Same goes for the comment spelling fix.  It's entirely unrelated
to this bug fix and needs to be in a separate patch.

This is an extremely low quality patch submission, sorry.

