From: Dennis Jenkins <dennis.jenkins@sbcglobal.net>
Date: Thu, 03 Mar 2005 13:06:05 +0000
Subject: Re: [PATCH] sparc: fix compile failure ("struct resource" related)
Message-Id: <20050303130605.1826.qmail@web81301.mail.yahoo.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20050301134440.05ae1152.akpm@osdl.org>
In-Reply-To: <20050301134440.05ae1152.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Does this mean that I will be able to successfully
compile a 2.6 kernel using gcc 3.3.5 on my sparc64
gentoo box?  Yeah!

now.. If only I (or someone) could fix the fcal/socal
driver.  I even tried using the socal_asm.h firmware
patch derived from the Solaris 10 "socal" firmware. 
No luck. :(

--- William Lee Irwin III <wli@holomorphy.com> wrote:

> On Tue, Mar 01, 2005 at 01:44:40PM -0800, Andrew
> Morton wrote:
> > Thanks.  Many of these fixups are due to a
> 64-bit-resource patch in Greg's
> > bk-pci tree which he has now reverted.  That being
> said:
> > - That patch will come back sometime
> > - Fixes like the below make sense anyway and can
> be merged any time.
> > - All the fixes which were only applicable when
> the 64-bit-resource patch
> >   is present have been sent to Greg for when that
> patch reemerges.
> 
> Well, in isolation it's a C99 initializer cleanup,
> which is good.
> 
> Acked-by: William Irwin <wli@holomorphy.com>
> 
> 
> -- wli
> -
> To unsubscribe from this list: send the line
> "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> 


==Dennis Jenkins
