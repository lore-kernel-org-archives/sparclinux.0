From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Fri, 06 Feb 2004 22:36:20 +0000
Subject: Re: kernel 2.4.25-pre8 fails to build for sparc32
Message-Id: <20040206223620.GA30588@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040206012437.GB2057@tintin>
In-Reply-To: <20040206012437.GB2057@tintin>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Feb 06, 2004 at 11:16:15PM +0100, Nicolas Boullis wrote:

> Well, I thought that some distribution were using a 32-bit kernel for 
> installation, even on sparc64... Was I wrong?

Yes.  See arch/sparc/kernel/head.S:no_sun4u_here.  Or about a hundred
other places in the sparc32 code where ultras clearly couldn't
possibly work.

-- 
Keith M Wesolowski
