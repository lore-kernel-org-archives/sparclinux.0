From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Mon, 22 Mar 2004 05:39:05 +0000
Subject: Re: Unable to build 2.6.4 w/o CONFIG_INPUT
Message-Id: <20040322053905.GA23680@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040322043836.GA19635@net-ronin.org>
In-Reply-To: <20040322043836.GA19635@net-ronin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Mar 21, 2004 at 09:07:33PM -0800, carbonated beverage wrote:

> On Sun, Mar 21, 2004 at 08:50:30PM -0800, Keith M Wesolowski wrote:
> > sparc32 or 64?
> 
> sparc32.  It's a sun4m box (ss4).

The short response is "don't do that then."  The 40kB ain't worth the
hassle.

The long response is to fix the dependencies so we can use the generic
Kconfigs, which allow to deselect VT.  You can get my patch for this
at http://foobazco.org/~wesolows/25-kconfig3264-7.diff.  I've been
lovingly maintaining it until the day I get sufficiently tired of this
crap to send it to l-k in exchange for a lifetime supply of derisive
jeers.

-- 
Keith M Wesolowski
