From: Roland Dreier <roland@topspin.com>
Date: Tue, 04 Jan 2005 19:22:14 +0000
Subject: Re: [7/7] LEON SPARC V8 processor support for linux-2.6.10
Message-Id: <528y7957a1.fsf@topspin.com>
List-Id: <sparclinux.vger.kernel.org>
References: <41DAE8CC.3010904@gaisler.com>
In-Reply-To: <41DAE8CC.3010904@gaisler.com> (Jiri Gaisler's message of "Tue,
 04 Jan 2005 20:04:44 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Gaisler <jiri@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, wli@holomorphy.com

Is there no way to do this:

    > +ifneq ($(CONFIG_LEON_3),y)
    > +obj-$(CONFIG_SERIAL_LEON) += leon.o
    > +endif

by using dependencies in Kconfig rather than adding conditionals to
the Makefile?  Does it work to make SERIAL_LEON depend on LEON && !LEON_3?

 - R.

