From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Sat, 04 Dec 2004 23:13:00 +0000
Subject: Re: mmap breakage
Message-Id: <1102201980.15654.108.camel@duncow>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0412032354010.1963@bobcat>
In-Reply-To: <Pine.LNX.4.61.0412032354010.1963@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 2004-12-04 at 05:22, Jurij Smakov wrote:
> Hello,
> 
> In Debian we have recently received a number of bug reports [0,1] about 
> glibc's ld-linux.so.2 failing (when called via ldd, for example) on some 
> binaries. The minimum test case, originally mentioned in [0], was the 
> following:
> 
> 

Well I can demonstrate the behaviour (see attached test program) on sparc64 and i386. It allows mappings to be fully or partially replaced and even allows you to replace bits in the middle of a mapping.

Now the bad news...

This seems to be POSIX defined behaviour

http://www.opengroup.org/onlinepubs/009695399/functions/mmap.html

Specifically

"The mapping established by mmap() shall replace any previous mappings
for those whole pages containing any part of the address space of the
process starting at pa and continuing for len bytes."

and more specifically when MAP_FIXED is supplied

"If a MAP_FIXED request is successful, the mapping established by mmap()
replaces any previous mappings for the process' pages in the range
[pa,pa+len)."

and

"On the other hand, if the program specifies a fixed address mapping
(which requires some implementation knowledge to determine a suitable
address, if the function is supported at all), then the program is
presumed to be successfully managing its own address space and should be
trusted when it asks to map over existing data structures."

I guess that this isn't really what you want to hear but it does
describe why the behaviour exists. I don't have any magic suggestions as
to how to fix it - sorry.

Richard

P.S. You can see the overwriting of mappings if you look at
/proc/<pid>/maps. You will see that the second mapping has totally
superceded the first and the third mapping has split the second one up.

01000000-01002000 rw-p 00000000 00:0b 8               /dev/zero
01002000-01004000 rw-p 00000000 03:02 863336          /var/log/messages
01004000-01020000 rw-p 00004000 00:0b 8               /dev/zero



-- 
richm@oldelvet.org.uk

