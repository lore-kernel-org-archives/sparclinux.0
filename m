From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 15 Oct 2006 02:16:40 +0000
Subject: Re: Problematic simba PCI bridge code in xorg
Message-Id: <20061015021640.GA7480@droopy.oc.cox.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061014164325.GA4374@droopy.oc.cox.net>
In-Reply-To: <20061014164325.GA4374@droopy.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Oct 14, 2006 at 04:54:53PM -0700, David Miller wrote:

> That code was the code author's poor attempt to add VGA routing
> support for SIMBA based sparc boxes.
> 
> Unless you're doing some weird multi-head setup, you won't notice
> if that code is removed.  And since it makes the box crash, the
> code is totally pointless.
> 
> I disabled it in order to get my ultra5 and ultra10 working.
> 
> It's amazing that an obvious disk-eater bug with a proposed solution
> sits in the XORG bug database for months.

Thanks for the information. I'll disable this code in Debian, and will 
prod upstream to remove it too.

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
