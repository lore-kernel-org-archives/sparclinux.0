From: Nicolas Boullis <nboullis@debian.org>
Date: Fri, 06 Feb 2004 22:16:15 +0000
Subject: Re: kernel 2.4.25-pre8 fails to build for sparc32
Message-Id: <20040206221615.GA1558@tintin>
List-Id: <sparclinux.vger.kernel.org>
References: <20040206012437.GB2057@tintin>
In-Reply-To: <20040206012437.GB2057@tintin>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

On Thu, Feb 05, 2004 at 06:59:51PM -0800, Keith M Wesolowski wrote:

> I think you're confused.  You probably mean you want to use a 32-bit
> userland, which you can do just fine with a sparc64 kernel.

Well, I dont' think I am that confused. I'm currently using a 64-bit 
kernel, with 32-bit applications, and everything works fine.

But I'd like to check if XFS is as broken in 32-bit as in 64-bit (the
64-bit kernel freezes when a XFS restore is attemted), and to try a
driver module in 32-bit mode. As far as I know, both require a 64-bit 
kernel...

> The
> sparc32 kernel does not support ultrasparc CPUs nor any of the
> associated hardware in ultras.  Please do not bother trying to make it
> work.  Use ARCH=sparc64 and all will be well.

Well, I thought that some distribution were using a 32-bit kernel for 
installation, even on sparc64... Was I wrong?


Regards,

Nicolas
