From: Tomas Szepe <szepe@pinerecords.com>
Date: Thu, 27 May 2004 06:51:52 +0000
Subject: Re: patch to fix XFS recovery on sparc64
Message-Id: <20040527065152.GE3692@louise.pinerecords.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040515020745.GA3359@tintin>
In-Reply-To: <20040515020745.GA3359@tintin>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On May-15 2004, Sat, 04:07 +0200
Nicolas Boullis <nboullis@debian.org> wrote:

> I guess I'm not the only one who has been hit by this bug on sparc64: on 
> XFS recovery, the kernel freezes for several minutes, and then breaks in 
> some semi-random way.
> 
> After much investigation, I discovered that the bug lied in the 
> xfs_contig_bits function in xfs_bit.c; that function is broken on 64-bit 
> big-endian architectures. The attached patch is an attempt to fix that.
> 
> Any comment about this patch? Any idea where I should try to push it?

Try discussing the problem with Nathan Scott <nathans@sgi.com>.

-- 
Tomas Szepe <szepe@pinerecords.com>
