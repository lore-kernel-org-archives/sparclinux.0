From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 01 Jun 2017 12:48:51 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <20170601124851.GD3226@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20170531193431.GA26922@waldemar-brodkorb.de>
 <20170531.171008.528800003662477033.davem@davemloft.net>
 <20170601121224.GE26922@waldemar-brodkorb.de>
 <CADxRZqyug5w1+tWpWxAX7aKkom166j=xqHUa-L61EKWEx7XAHw@mail.gmail.com>
In-Reply-To: <CADxRZqyug5w1+tWpWxAX7aKkom166j=xqHUa-L61EKWEx7XAHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anatoly Pugachev <matorola@gmail.com>
Cc: Sparc kernel list <sparclinux@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Thu, Jun 01, 2017 at 03:46:04PM +0300, Anatoly Pugachev wrote:
> on the same topic , latest git does not compile for me with gcc-7.0.1
> gcc version 7.0.1 20170407 (experimental) [trunk revision 246759]
> (Debian 7-20170407-1)

Let's first try this again once the 7.1.0-6 gcc-7 package has built
successfully in Debian experimental. It's been uploaded for a while
now but we have the usual issues with the gcc testsuite crashing the
kernel.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
