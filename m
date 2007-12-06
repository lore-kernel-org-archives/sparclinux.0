From: Wes Hardin <wes.hardin@dalsemi.com>
Date: Thu, 06 Dec 2007 19:57:28 +0000
Subject: Re: SunOS/Solaris Binary Emulation
Message-Id: <47585428.8060208@dalsemi.com>
List-Id: <sparclinux.vger.kernel.org>
References: <475825D7.1090209@dalsemi.com>
In-Reply-To: <475825D7.1090209@dalsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Pieter,
	yours was one of the pages I was looking at.  I just overlooked the 
suggestion to copy all the libraries and binaries as I have limited diskspace 
right now.

I was pointed to a tarball of an old RedHat package called solemul, apparently 
from the days when they supported SPARC.

This package includes a skeleton for /usr/gnemeul/solaris (including /dev) and 
a list of files needed from Solaris.  Using this basic file list, Solaris's 
uname now executes it seems, but dies with "Illegal Instruction".  This seems 
to be par for any Solaris binary I try.

So I bit the bullet, increased my LVM volume and copied the entire /usr/lib 
and /usr/bin from Solaris to my Linux machine.  No change.

So far I've copied /usr/lib, /usr/bin, /sbin, /usr/sbin, /usr/platform from 
Solaris.  Anything else?

I guess I should mention that I'm copying from Solaris 8, if I haven't 
already.  Is Solaris 8 too new?  I think I have a Solaris 7 and a few Solaris 
2.6 machines left.

Pieter D.J. Krul wrote:
> Jan Engelhardt wrote:
>>> manhack:/usr/gnemul/solaris/bin# ldd ./uname
>>> /usr/bin/ldd: line 117: ./uname: No such file or directory
>> I suppose you need the Solaris libraries too, including dynamic
>> linker. See output of `readelf -d uname`.
> 
> I tend to agree. All SunOS and Solaris binaries, libraries and devicefiles are by default expected
> to exist in /usr/gnemul/sunos and/or /usr/gnemul/solaris.
> 
> I've scribbled a few things on this topic some time ago, which should have become a sort of
> faq/howto at that time. You can find this on http://www.krul.cc/~pkrul/docs/solemu/
> 
> HTH
> 
> Pieter
-- 
/* wes hardin */
