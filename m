From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Tue, 07 Dec 2004 06:11:11 +0000
Subject: Re: mmap breakage
Message-Id: <20041207061111.GA32404@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0412032354010.1963@bobcat>
In-Reply-To: <Pine.LNX.4.61.0412032354010.1963@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Dec 06, 2004 at 10:06:26PM -0800, David S. Miller wrote:

> Actually, Jurij when you run ldd on a 64-bit binary what does
> it say?  I can't reproduce that strange 0x08000000 address.

/lib/ld-linux.so.2 and the programs in question are ELF32.  The
ET_DYN_BASE is the same on sparc64 for ELF32 objects as it is on
sparc32.  Presumably the latter is to accomodate the silly 4c VM
hole...

-- 
Keith M Wesolowski
"Site launched. Many things not yet working." --Hector Urtubia
