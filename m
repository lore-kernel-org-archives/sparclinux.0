From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 05 Jan 2005 00:01:12 +0000
Subject: Re: [1/7] LEON SPARC V8 processor support for linux-2.6.10
Message-Id: <1104877412.17166.49.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <41DAE89A.6060009@gaisler.com>
In-Reply-To: <41DAE89A.6060009@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Gaisler <jiri@gaisler.com>
Cc: sparclinux@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, wli@holomorphy.com

On Maw, 2005-01-04 at 19:03, Jiri Gaisler wrote
> + *  The license and distribution terms for this file may be
> + *  found in the file LICENSE in this distribution or at
> + *  http://www.rtems.com/license/LICENSE.

Legalese hat on

Please don't do this. Suppose the file changes or the site goes away.
Include a copy of the license in the patch set directly.

