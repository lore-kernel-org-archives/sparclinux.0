From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Mon, 05 Apr 2004 23:51:37 +0000
Subject: Re: Oops when booting 2.6.5
Message-Id: <20040405235137.GA23553@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040405153414.GC1430@artsapartment.org>
In-Reply-To: <20040405153414.GC1430@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Apr 05, 2004 at 11:00:39PM +0200, Thomas 'Mike' Michlmayr wrote:

> do you think this (theoretical) fix can be backported to 2.4 easily?
> ISTR having the same problem on 2.4/sparc32.

Whatever it is, it's not the same, unless you use 17 or more swapfiles
(don't do that then).  Can you please confirm this happens in 2.4.25
and provide a ksymoops trace?

-- 
Keith M Wesolowski
