From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 14 Oct 2005 21:42:24 +0000
Subject: Re: qlogicpti kernel panic
Message-Id: <20051014.144224.39338476.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1129315998.2243.35.camel@localhost.localdomain>
In-Reply-To: <1129315998.2243.35.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Peter Jones <pjones@redhat.com>
Date: Fri, 14 Oct 2005 16:49:34 -0400

> Roughly, what's the portable way?

See the followup patch I posted.

libata-scsi.c is where I culled the code from.

It should be generically somewhere, but the problem
is that the "KM_*" kmap type depends upon the context
in which the routine is called (user or IRQ).
