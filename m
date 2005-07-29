From: Kumba <kumba@gentoo.org>
Date: Fri, 29 Jul 2005 05:11:39 +0000
Subject: Re: fd0 not found
Message-Id: <42E9BA8B.4000601@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
References: <42E61753.8050502@cpttm.org.mo>
In-Reply-To: <42E61753.8050502@cpttm.org.mo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David S. Miller wrote:
> 
> Furthermore, anyone planning to "learn something" from opensolaris and
> then incorporate such things into Linux had better well explicitly
> implement and properly document a closed room implementation where one
> person reads the OpenSolaris code, explains what is happening to
> another person, who in turn implements the Linux version.
> 
> Otherwise there are grave contamination and copyright infringement
> issues possible.  One would, in addition to the properly documented
> closed room implementation, need to do a patent check on the ideas
> being copied over as well.
> 
> As a result of all that, looking to OpenSolaris for information to
> help out the Linux sparc port is a bad idea.

I assumed this was the case likely.  Was more a mild curiosity on what the 
feasbility of that was (And whether it's even remotely possible).  I've already 
peered at OS code out of boredem and in doing so, I noticed they had a 
kludge/hack in place for that IDE DMA issue that's always plagued the b100 
series, so it piqued my interest.


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
