From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Fri, 06 Feb 2004 02:59:51 +0000
Subject: Re: kernel 2.4.25-pre8 fails to build for sparc32
Message-Id: <20040206025951.GA27446@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040206012437.GB2057@tintin>
In-Reply-To: <20040206012437.GB2057@tintin>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Feb 06, 2004 at 02:24:38AM +0100, Nicolas Boullis wrote:

> First of all, sorry if I'm doing something wrong with this report, I'm 
> still quite a newbie on this list...
> 
> I just tried to build a sparc32 kernel for my Ultra5. (I know this is 
> sparc64 hardware, but I need to test some things with a sparc32 kernel, 
> and I think it's supposed to work fine...) Unfortunately, the build 
> fails with the following message:

I think you're confused.  You probably mean you want to use a 32-bit
userland, which you can do just fine with a sparc64 kernel.  The
sparc32 kernel does not support ultrasparc CPUs nor any of the
associated hardware in ultras.  Please do not bother trying to make it
work.  Use ARCH=sparc64 and all will be well.

-- 
Keith M Wesolowski
